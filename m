Return-Path: <pengxihan@gmail.com>
Received: from mail-pz0-f201.google.com (mail-pz0-f201.google.com
	[209.85.222.201]) by ozlabs.org (Postfix) with ESMTP id 2DABEB7BA5
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Nov 2009 11:43:56 +1100 (EST)
Received: by pzk39 with SMTP id 39so3445472pzk.15
	for <linuxppc-dev@ozlabs.org>; Mon, 02 Nov 2009 16:43:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e9c3a7c20910291546r2603e191g87a23023c32f1b1b@mail.gmail.com>
References: <1255588866-4133-1-git-send-email-Vishnu@freescale.com>
	<1255588866-4133-2-git-send-email-Vishnu@freescale.com>
	<e9c3a7c20910291546r2603e191g87a23023c32f1b1b@mail.gmail.com>
Date: Tue, 3 Nov 2009 08:43:54 +0800
Message-ID: <389deec70911021643t6897f21fv52cc660e5f5d67e5@mail.gmail.com>
Subject: Re: [PATCH v0 2/2] Crypto: Talitos: Support for Async_tx XOR offload
From: hank peng <pengxihan@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Vishnu Suresh <Vishnu@freescale.com>, linux-crypto@vger.kernel.org,
	Dipen Dudhat <Dipen.Dudhat@freescale.com>,
	Maneesh Gupta <Maneesh.Gupta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I have tested this patch on my MPC8548 machine box, kernel version is
2.6.30. There is a problem.
#mdadm -C /dev/md0 -l5 -n3 /dev/sd{a,b,c}
Recovery can be done successfully, interrupts looks normal.
# cat /proc/interrupts
           CPU0
 16:   16091057   OpenPIC   Level     mvSata
 17:          0   OpenPIC   Level     mvSata
 18:          4   OpenPIC   Level     phy_interrupt, phy_interrupt
 20:         39   OpenPIC   Level     fsldma-channel
 21:          0   OpenPIC   Level     fsldma-channel
 22:          0   OpenPIC   Level     fsldma-channel
 23:          0   OpenPIC   Level     fsldma-channel
 29:        241   OpenPIC   Level     eth0_tx
 30:    1004692   OpenPIC   Level     eth0_rx
 34:          0   OpenPIC   Level     eth0_er
 35:          0   OpenPIC   Level     eth1_tx
 36:          0   OpenPIC   Level     eth1_rx
 40:          0   OpenPIC   Level     eth1_er
 42:      73060   OpenPIC   Level     serial
 43:       9854   OpenPIC   Level     i2c-mpc, i2c-mpc
 45:   61264188   OpenPIC   Level     talitos
BAD:          0

Then, I plan to create a VG, but problem occured.
#pvcreate /dev/md0

After I input this command, system hangs there without any messages.

BTW, all is OK before using this patch.


2009/10/30 Dan Williams <dan.j.williams@intel.com>:
> On Wed, Oct 14, 2009 at 11:41 PM, Vishnu Suresh <Vishnu@freescale.com> wr=
ote:
> [..]
>> diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
>> index b08403d..343e578 100644
>> --- a/drivers/crypto/Kconfig
>> +++ b/drivers/crypto/Kconfig
>> @@ -192,6 +192,8 @@ config CRYPTO_DEV_TALITOS
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0select CRYPTO_ALGAPI
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0select CRYPTO_AUTHENC
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0select HW_RANDOM
>> + =C2=A0 =C2=A0 =C2=A0 select DMA_ENGINE
>> + =C2=A0 =C2=A0 =C2=A0 select ASYNC_XOR
>
> You need only select DMA_ENGINE. =C2=A0ASYNC_XOR is selected by its users=
.
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on FSL_SOC
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0help
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say 'Y' here to use the Freescale Secu=
rity Engine (SEC)
>> diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
>> index c47ffe8..84819d4 100644
>> --- a/drivers/crypto/talitos.c
>> +++ b/drivers/crypto/talitos.c
> [..]
>> +static void talitos_process_pending(struct talitos_xor_chan *xor_chan)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_desc *desc, *_desc;
>> + =C2=A0 =C2=A0 =C2=A0 unsigned long flags;
>> + =C2=A0 =C2=A0 =C2=A0 int status;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 spin_lock_irqsave(&xor_chan->desc_lock, flags);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 list_for_each_entry_safe(desc, _desc, &xor_chan->=
pending_q, node) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 status =3D talitos_su=
bmit(xor_chan->dev, &desc->hwdesc,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 talitos_rele=
ase_xor, desc);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (status !=3D -EINP=
ROGRESS)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 break;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&desc->node)=
;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_add_tail(&desc->=
node, &xor_chan->in_progress_q);
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_irqrestore(&xor_chan->desc_lock, flag=
s);
>> +}
>
> The driver uses spin_lock_bh everywhere else which is either a bug, or
> this code is being overly protective. =C2=A0In any event lockdep will
> rightly complain about this. =C2=A0The API and its users do not submit
> operations in hard-irq context.
>
>> +
>> +static void talitos_release_xor(struct device *dev, struct talitos_desc=
 *hwdesc,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *context, int error)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_desc *desc =3D context;
>> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan;
>> + =C2=A0 =C2=A0 =C2=A0 dma_async_tx_callback callback;
>> + =C2=A0 =C2=A0 =C2=A0 void *callback_param;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (unlikely(error)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(dev, "xor ope=
ration: talitos error %d\n", error);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BUG();
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 xor_chan =3D container_of(desc->async_tx.chan, st=
ruct talitos_xor_chan,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 common);
>> + =C2=A0 =C2=A0 =C2=A0 spin_lock_bh(&xor_chan->desc_lock);
>> + =C2=A0 =C2=A0 =C2=A0 if (xor_chan->completed_cookie < desc->async_tx.c=
ookie)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xor_chan->completed_c=
ookie =3D desc->async_tx.cookie;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 callback =3D desc->async_tx.callback;
>> + =C2=A0 =C2=A0 =C2=A0 callback_param =3D desc->async_tx.callback_param;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (callback) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock_bh(&xor_c=
han->desc_lock);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 callback(callback_par=
am);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock_bh(&xor_cha=
n->desc_lock);
>> + =C2=A0 =C2=A0 =C2=A0 }
>
> You do not need to unlock to call the callback. =C2=A0Users of the API
> assume that they are called in bh context and that they are not
> allowed to submit new operations directly from the callback (this
> simplifies the descriptor cleanup routines in other drivers).
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 list_del(&desc->node);
>> + =C2=A0 =C2=A0 =C2=A0 list_add_tail(&desc->node, &xor_chan->free_desc);
>> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_bh(&xor_chan->desc_lock);
>> + =C2=A0 =C2=A0 =C2=A0 if (!list_empty(&xor_chan->pending_q))
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 talitos_process_pendi=
ng(xor_chan);
>> +}
>
> It appears this routine is missing a call to dma_run_dependencies()?
> This is needed if another channel is handling memory copy offload. =C2=A0=
I
> assume this is the case due to your other patch to fsldma. =C2=A0See
> iop_adma_run_tx_complete_actions(). =C2=A0If this xor resource can also
> handle copy operations that would be more efficient as it eliminates
> channel switching. =C2=A0See the ioatdma driver and its use of
> ASYNC_TX_DISABLE_CHANNEL_SWITCH.
>
>> +static struct dma_async_tx_descriptor * talitos_prep_dma_xor(
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct dma_chan *chan, dma_addr_t dest, dma_addr_t *src,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 unsigned int src_cnt, size_t len, unsigned long flags)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_chan *xor_chan;
>> + =C2=A0 =C2=A0 =C2=A0 struct talitos_xor_desc *new;
>> + =C2=A0 =C2=A0 =C2=A0 struct talitos_desc *desc;
>> + =C2=A0 =C2=A0 =C2=A0 int i, j;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 BUG_ON(unlikely(len > TALITOS_MAX_DATA_LEN));
>> +
>> + =C2=A0 =C2=A0 =C2=A0 xor_chan =3D container_of(chan, struct talitos_xo=
r_chan, common);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 spin_lock_bh(&xor_chan->desc_lock);
>> + =C2=A0 =C2=A0 =C2=A0 if (!list_empty(&xor_chan->free_desc)) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new =3D container_of(=
xor_chan->free_desc.next,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct talitos_xor_desc, no=
de);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&new->node);
>> + =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 new =3D talitos_xor_a=
lloc_descriptor(xor_chan, GFP_KERNEL);
>> + =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 spin_unlock_bh(&xor_chan->desc_lock);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (!new) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(xor_chan->com=
mon.device->dev,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 "No free memory for XOR DMA descriptor\n");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> + =C2=A0 =C2=A0 =C2=A0 dma_async_tx_descriptor_init(&new->async_tx, &xor=
_chan->common);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&new->node);
>> + =C2=A0 =C2=A0 =C2=A0 INIT_LIST_HEAD(&new->tx_list);
>
> You can save some overhead in the fast path by moving this
> initialization to talitos_xor_alloc_descriptor.
>
>> +
>> + =C2=A0 =C2=A0 =C2=A0 desc =3D &new->hwdesc;
>> + =C2=A0 =C2=A0 =C2=A0 /* Set destination: Last pointer pair */
>> + =C2=A0 =C2=A0 =C2=A0 to_talitos_ptr(&desc->ptr[6], dest);
>> + =C2=A0 =C2=A0 =C2=A0 desc->ptr[6].len =3D cpu_to_be16(len);
>> + =C2=A0 =C2=A0 =C2=A0 desc->ptr[6].j_extent =3D 0;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /* Set Sources: End loading from second-last poin=
ter pair */
>> + =C2=A0 =C2=A0 =C2=A0 for (i =3D 5, j =3D 0; (j < src_cnt) && (i > 0); =
i--, j++) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to_talitos_ptr(&desc-=
>ptr[i], src[j]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->ptr[i].len =3D =
cpu_to_be16(len);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->ptr[i].j_extent=
 =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 /*
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* documentation states first 0 ptr/len comb=
o marks end of sources
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* yet device produces scatter boundary erro=
r unless all subsequent
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0* sources are zeroed out
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
>> + =C2=A0 =C2=A0 =C2=A0 for (; i >=3D 0; i--) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 to_talitos_ptr(&desc-=
>ptr[i], 0);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->ptr[i].len =3D =
0;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 desc->ptr[i].j_extent=
 =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 }
>> +
>> + =C2=A0 =C2=A0 =C2=A0 desc->hdr =3D DESC_HDR_SEL0_AESU | DESC_HDR_MODE0=
_AESU_XOR
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | DESC_=
HDR_TYPE_RAID_XOR;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 new->async_tx.parent =3D NULL;
>> + =C2=A0 =C2=A0 =C2=A0 new->async_tx.next =3D NULL;
>
> These fields are managed by the async_tx channel switch code. =C2=A0No ne=
ed
> to manage it here.
>
>> + =C2=A0 =C2=A0 =C2=A0 new->async_tx.cookie =3D 0;
>
> This is set below to -EBUSY, it's redundant to touch it here.
>
>> + =C2=A0 =C2=A0 =C2=A0 async_tx_ack(&new->async_tx);
>
> This makes it impossible to attach a dependency to this operation.
> Not sure this is what you want.
>
> --
> Dan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>



--=20
The simplest is not all best but the best is surely the simplest!
