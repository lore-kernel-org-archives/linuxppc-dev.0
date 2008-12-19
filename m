Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AA089DDDEA
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 18:43:25 +1100 (EST)
Date: Fri, 19 Dec 2008 10:43:17 +0300
From: Yuri Tikhonov <yur@emcraft.com>
Message-ID: <714415337.20081219104317@emcraft.com>
To: "Dan Williams" <dan.j.williams@intel.com>
Subject: Re[2]: [PATCH 02/11][v2] async_tx: add support for asynchronous GF
	multiplication
In-Reply-To: <e9c3a7c20812171034l7403c788y9fd1e7ce217cb41b@mail.gmail.com>
References: <200812090055.42334.yur@emcraft.com>
	<e9c3a7c20812171034l7403c788y9fd1e7ce217cb41b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, wd@denx.de,
	dzu@denx.de, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Dan,

On Wednesday, December 17, 2008 you wrote:

 [..]

>> +       /* DMAs use destinations as sources, so use BIDIRECTIONAL mappin=
g */
>> +       dma_dest[0] =3D !blocks[src_cnt] ? 0 :
>> +                               dma_map_page(dma->dev, blocks[src_cnt],
>> +                                            offset, len, DMA_BIDIRECTIO=
NAL);

> "0" could be a valid dma address on some architectures.
> DMA_ERROR_CODE looks like the closest fit for what we are trying to do
> here, but that only exists on sparc and powerpc.  We could add a
> "dest_mask" parameter to device_prep_dma_pq where the mask is  1 =3D
> p-only, 2 =3D q-only, and 3 =3D p and q.

 Understood. We can just introduce new DMA_xxx flags and pass them=20
among the other ones passed with device_prep_dma_pq() to ADMA driver=20
instead of introducing a new "dest_mask" parameter. Though, I guess,=20
you meant exactly the same.

>> +       dma_dest[1] =3D !blocks[src_cnt+1] ? 0 :
>> +                               dma_map_page(dma->dev, blocks[src_cnt+1],
>> +                                            offset, len, DMA_BIDIRECTIO=
NAL);
>> +
>> +       for (i =3D 0; i < src_cnt; i++)
>> +               dma_src[i] =3D dma_map_page(dma->dev, blocks[i],
>> +                                         offset, len, DMA_TO_DEVICE);
>> +
>> +       while (src_cnt) {
>> +               async_flags =3D flags;
>> +               pq_src_cnt =3D min(src_cnt, dma->max_pq);
>> +               /* if we are submitting additional pqs, leave the chain =
open,
>> +                * clear the callback parameters, and leave the destinat=
ion
>> +                * buffers mapped
>> +                */
>> +               if (src_cnt > pq_src_cnt) {
>> +                       async_flags &=3D ~ASYNC_TX_ACK;
>> +                       dma_flags |=3D DMA_COMPL_SKIP_DEST_UNMAP;
>> +                       _cb_fn =3D NULL;
>> +                       _cb_param =3D NULL;
>> +               } else {
>> +                       _cb_fn =3D cb_fn;
>> +                       _cb_param =3D cb_param;
>> +               }
>> +               if (_cb_fn)
>> +                       dma_flags |=3D DMA_PREP_INTERRUPT;
>> +
>> +               /* Since we have clobbered the src_list we are committed
>> +                * to doing this asynchronously.  Drivers force forward
>> +                * progress in case they can not provide a descriptor
>> +                */
>> +               tx =3D dma->device_prep_dma_pq(chan, dma_dest,
>> +                                            &dma_src[src_off], pq_src_c=
nt,
>> +                                            scf_list ? &scf_list[src_of=
f] :
>> +                                                       NULL,
>> +                                            len, dma_flags);

> ...one nit for readability can we replace these ternary conditionals
> with proper if-else statements?  i.e.

>                 if (scf_list)
>                         scf =3D &scf_list[src_off];
>                 else
>                         scf =3D NULL;
>                 tx =3D dma->device_prep_dma_pq(chan, dma_dest,
>                                              &dma_src[src_off], pq_src_cn=
t,
>                                              scf, len, dma_flags);

 Thanks for pointing this. Sure. Furthermore, it's additionally even a=20
question of performance: e.g. in do_async_pq() we do this "? : " in a=20
cycle, whereas there is absolutely no reason to think it changes.

 [..]

>> +/**
>> + * async_pq_zero_sum - attempt a PQ parities check with a dma engine.
>> + * @blocks: array of source pages. The 0..src_cnt-1 are the sources, the
>> + *     src_cnt and src_cnt+1 are the P and Q destinations to check, res=
p.
>> + *     Only one of two destinations may be present.
>> + *     NOTE: client code must assume the contents of this array are des=
troyed
>> + * @scf: coefficients to use in GF-multiplications
>> + * @offset: offset in pages to start transaction
>> + * @src_cnt: number of source pages
>> + * @len: length in bytes
>> + * @presult: where to store the result of P-ckeck, which is 0 if P-pari=
ty
>> + *     OK, and non-zero otherwise.
>> + * @qresult: where to store the result of P-ckeck, which is 0 if Q-pari=
ty
>> + *     OK, and non-zero otherwise.
>> + * @flags: ASYNC_TX_ASSUME_COHERENT, ASYNC_TX_ACK, ASYNC_TX_DEP_ACK
>> + * @depend_tx: depends on the result of this transaction.
>> + * @cb_fn: function to call when the xor completes
>> + * @cb_param: parameter to pass to the callback routine
>> + */
>> +struct dma_async_tx_descriptor *
>> +async_pq_zero_sum(struct page **blocks, unsigned char *scf,
>> +       unsigned int offset, int src_cnt, size_t len,
>> +       u32 *presult, u32 *qresult, enum async_tx_flags flags,
>> +       struct dma_async_tx_descriptor *depend_tx,
>> +       dma_async_tx_callback cb_fn, void *cb_param)
>> +{
>> +       struct dma_chan *chan =3D async_tx_find_channel(depend_tx,
>> +                                                     DMA_PQ_ZERO_SUM,
>> +                                                     &blocks[src_cnt], =
2,
>> +                                                     blocks, src_cnt, l=
en);
>> +       struct dma_device *device =3D chan ? chan->device : NULL;
>> +       struct dma_async_tx_descriptor *tx =3D NULL;
>> +
>> +       BUG_ON(src_cnt < 2);
>> +
>> +       if (device && src_cnt <=3D device->max_pq) {
>> +               dma_addr_t dma_src[src_cnt + 2];
>> +               enum dma_ctrl_flags dma_flags =3D cb_fn ? DMA_PREP_INTER=
RUPT : 0;
>> +               int i;
>> +
>> +               for (i =3D 0; i < src_cnt + 2; i++)
>> +                       dma_src[i] =3D blocks[i] ? dma_map_page(device->=
dev,
>> +                                       blocks[i], offset, len,
>> +                                       DMA_TO_DEVICE) : 0;

> If we go with the "dest_mask" approach to specifying p and q then we
> need to separate them into their own parameter here... although in
> this case it would be a "src_mask" to select p or q.

 We shouldn't do this if enhance 'enum dma_ctrl_flags' with, say,=20
DMA_PREP_P_PRESENT, DMA_PREP_Q_PRESENT. The adma driver which support=20
device_prep_dma_pqzero_sum() then should use/or not first dma_src=20
(which are destinations) depending on dma_flags set.

 [..]

>> diff --git a/include/linux/async_tx.h b/include/linux/async_tx.h
>> index 0f50d4c..5d6b639 100644
>> --- a/include/linux/async_tx.h
>> +++ b/include/linux/async_tx.h
>> @@ -42,6 +42,12 @@ struct dma_chan_ref {
>>  * @ASYNC_TX_XOR_ZERO_DST: this flag must be used for xor operations whe=
re the
>>  * the destination address is not a source.  The asynchronous case handl=
es this
>>  * implicitly, the synchronous case needs to zero the destination block.
>> + * @ASYNC_TX_PQ_ZERO_P: this flag must be used for async_pq operations =
since the
>> + * destination there is always the source (the result of P after async_=
pq is
>> + * xor-ed with the previous content of P block if this flag isn't set).
>> + * @ASYNC_TX_PQ_ZERO_Q: this flag must be used for async_pq operations =
since the
>> + * destination there is always the source (the result of Q after async_=
pq is
>> + * xor-ed with the previous content of Q block if this flag isn't set).
>>  * @ASYNC_TX_XOR_DROP_DST: this flag must be used if the destination add=
ress is
>>  * also one of the source addresses.  In the synchronous case the destin=
ation
>>  * address is an implied source, whereas the asynchronous case it must b=
e listed
>> @@ -50,12 +56,17 @@ struct dma_chan_ref {
>>  * @ASYNC_TX_ACK: immediately ack the descriptor, precludes setting up a
>>  * dependency chain
>>  * @ASYNC_TX_DEP_ACK: ack the dependency descriptor.  Useful for chainin=
g.
>> + * @ASYNC_TX_ASYNC_ONLY: if set then try to perform operation requested=
 only in
>> + * the asynchronous mode.
>>  */
>>  enum async_tx_flags {
>>        ASYNC_TX_XOR_ZERO_DST    =3D (1 << 0),
>> -       ASYNC_TX_XOR_DROP_DST    =3D (1 << 1),
>> -       ASYNC_TX_ACK             =3D (1 << 3),
>> -       ASYNC_TX_DEP_ACK         =3D (1 << 4),
>> +       ASYNC_TX_PQ_ZERO_P       =3D (1 << 1),
>> +       ASYNC_TX_PQ_ZERO_Q       =3D (1 << 2),
>> +       ASYNC_TX_XOR_DROP_DST    =3D (1 << 3),
>> +       ASYNC_TX_ACK             =3D (1 << 4),
>> +       ASYNC_TX_DEP_ACK         =3D (1 << 5),
>> +       ASYNC_TX_ASYNC_ONLY      =3D (1 << 6),
>>  };
>>
>>  #ifdef CONFIG_DMA_ENGINE
>> @@ -146,5 +157,33 @@ async_trigger_callback(enum async_tx_flags flags,
>>        struct dma_async_tx_descriptor *depend_tx,
>>        dma_async_tx_callback cb_fn, void *cb_fn_param);
>>
>> +struct dma_async_tx_descriptor *
>> +async_pqxor(struct page *pdest, struct page *qdest,
>> +       struct page **src_list, unsigned char *scoef_list,
>> +       unsigned int offset, int src_cnt, size_t len, enum async_tx_flag=
s flags,
>> +       struct dma_async_tx_descriptor *depend_tx,
>> +       dma_async_tx_callback callback, void *callback_param);
>> +

> ...forgot to update the declartion.

 Argh.. Missed this when re-generated my final internal patch version.

> In this case async_pq() can be declared static since nothing outside
> of async_pq.c calls it.

 It's not true. async_r6_dd_recov() and async_r6_dp_recov() functions=20
actively utilize async_pq(). See crypto/async_tx/async_r6recov.c.

 [..]

>>  void async_tx_quiesce(struct dma_async_tx_descriptor **tx);
>>  #endif /* _ASYNC_TX_H_ */
>> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
>> index adb0b08..84525c3 100644
>> --- a/include/linux/dmaengine.h
>> +++ b/include/linux/dmaengine.h
>> @@ -81,7 +81,7 @@ enum dma_status {
>>  enum dma_transaction_type {
>>        DMA_MEMCPY,
>>        DMA_XOR,
>> -       DMA_PQ_XOR,
>> +       DMA_PQ,
>>        DMA_DUAL_XOR,
>>        DMA_PQ_UPDATE,
>>        DMA_ZERO_SUM,
>> @@ -123,6 +123,8 @@ enum dma_ctrl_flags {
>>        DMA_CTRL_ACK =3D (1 << 1),
>>        DMA_COMPL_SKIP_SRC_UNMAP =3D (1 << 2),
>>        DMA_COMPL_SKIP_DEST_UNMAP =3D (1 << 3),
>> +       DMA_PREP_ZERO_P =3D (1 << 4),
>> +       DMA_PREP_ZERO_Q =3D (1 << 5),
>>  };

> I would rather not add operation-type-specific flags to
> dma_ctrl_flags.

 But we need somehow:

1) point the ADMA driver should it clear the destination or not;
2) if (1), then what destination(s) to clear.

 Above I even propose to add two more flags here :) Are there any=20
reasons why we should spare dma_ctrl_flags, and, instead of adding a=20
couple of new flag bits which are even do not lead to the sizeof(enum)=20
growth, increase the stack usage and, in general, the time of=20
functions calls by adding new parameters to ADMA methods ?

>   In this case can we set up a dependency chain with
> async_memset()?

 Well, we can. But wouldn't this be an overhead? For example,=20
ppc440spe DMA allows to do so-called RXOR which overwrites, and=20
doesn't take care of destinations. So, we can do ZERO_DST(s)+PQ in one=20
short on one DMA engine. Again, I'm not sure that keeping=20
dma_ctrl_flags unchanged is worthy of creating such a dependency;=20
it'll obviously lead both to degradation of performance & increasing=20
of CPU utilization.

>>
>>  /**
>> @@ -299,6 +301,7 @@ struct dma_async_tx_descriptor {
>>  * @global_node: list_head for global dma_device_list
>>  * @cap_mask: one or more dma_capability flags
>>  * @max_xor: maximum number of xor sources, 0 if no capability
>> + * @max_pq: maximum number of PQ sources, 0 if no capability
>>  * @refcount: reference count
>>  * @done: IO completion struct
>>  * @dev_id: unique device ID
>> @@ -308,7 +311,9 @@ struct dma_async_tx_descriptor {
>>  * @device_free_chan_resources: release DMA channel's resources
>>  * @device_prep_dma_memcpy: prepares a memcpy operation
>>  * @device_prep_dma_xor: prepares a xor operation
>> + * @device_prep_dma_pq: prepares a pq operation
>>  * @device_prep_dma_zero_sum: prepares a zero_sum operation
>> + * @device_prep_dma_pqzero_sum: prepares a pqzero_sum operation
>>  * @device_prep_dma_memset: prepares a memset operation
>>  * @device_prep_dma_interrupt: prepares an end of chain interrupt operat=
ion
>>  * @device_prep_slave_sg: prepares a slave dma operation
>> @@ -322,6 +327,7 @@ struct dma_device {
>>        struct list_head global_node;
>>        dma_cap_mask_t  cap_mask;
>>        int max_xor;
>> +       int max_pq;
>>

> max_xor and max_pq can be changed to unsigned shorts to keep the size
> of the struct the same.

 Right.

>>        struct kref refcount;
>>        struct completion done;
>> @@ -339,9 +345,17 @@ struct dma_device {
>>        struct dma_async_tx_descriptor *(*device_prep_dma_xor)(
>>                struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
>>                unsigned int src_cnt, size_t len, unsigned long flags);
>> +       struct dma_async_tx_descriptor *(*device_prep_dma_pq)(
>> +               struct dma_chan *chan, dma_addr_t *dst, dma_addr_t *src,
>> +               unsigned int src_cnt, unsigned char *scf,
>> +               size_t len, unsigned long flags);
>>        struct dma_async_tx_descriptor *(*device_prep_dma_zero_sum)(
>>                struct dma_chan *chan, dma_addr_t *src, unsigned int src_=
cnt,
>>                size_t len, u32 *result, unsigned long flags);
>> +       struct dma_async_tx_descriptor *(*device_prep_dma_pqzero_sum)(
>> +               struct dma_chan *chan, dma_addr_t *src, unsigned int src=
_cnt,
>> +               unsigned char *scf,
>> +               size_t len, u32 *presult, u32 *qresult, unsigned long fl=
ags);

> I would rather we turn the 'result' parameter into a pointer to flags
> where bit 0 is the xor/p result and bit1 is the q result.

 Yes, this'll be better.


 Thanks for reviewing. I'll re-generate ASYNC_TX patch (in the parts=20
where I absolutely agreed with you), and then re-post. Any comments=20
regarding RAID-6 part?

 Regards, Yuri

 --
 Yuri Tikhonov, Senior Software Engineer
 Emcraft Systems, www.emcraft.com
