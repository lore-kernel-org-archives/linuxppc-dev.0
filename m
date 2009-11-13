Return-Path: <pengxihan@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id 4D752B7B9A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2009 13:45:27 +1100 (EST)
Received: by pwi6 with SMTP id 6so1765869pwi.9
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2009 18:45:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e9c3a7c20911121736ma9f8d72waa377c4b61b2f480@mail.gmail.com>
References: <389deec70911100344j5969e834nc80a9fd330935ef3@mail.gmail.com>
	<e9c3a7c20911121736ma9f8d72waa377c4b61b2f480@mail.gmail.com>
Date: Fri, 13 Nov 2009 10:45:25 +0800
Message-ID: <389deec70911121845p2b3bae9fob2bd8422e0fd011d@mail.gmail.com>
Subject: Re: OOPS on MPC8548 board when writing RAID5 array
From: hank peng <pengxihan@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: linux-raid <linux-raid@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Suresh Vishnu <Vishnu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2009/11/13 Dan Williams <dan.j.williams@intel.com>:
> Hi Hank,
>
> Thanks for testing.
>
> On Tue, Nov 10, 2009 at 4:44 AM, hank peng <pengxihan@gmail.com> wrote:
>> CPU is MPC8548, kernel version is 2.6.31.5,CONFIG_FSL_DMA and
>> CONFIG_ASYNC_TX_DMA options are all enabled.
>> #mdadm -C /dev/md0 --assume-clean -l5 -n3 /dev/sd{a,b,c}
>> #dd if=3D/dev/zero of=3D/dev/md0 bs=3D1M count=3D1000
>> Oops: Exception in kernel mode, sig: 5 [#1]
>> MPC85xx CDS
>> Modules linked in:
>> NIP: c01c45d8 LR: c01c4d48 CTR: 00000000
>> REGS: c2dd5c80 TRAP: 0700 =C2=A0 Not tainted =C2=A0(2.6.31.5)
>> MSR: 00029000 <EE,ME,CE> =C2=A0CR: 22004028 =C2=A0XER: 00000000
>> TASK =3D e820a580[3804] 'md0_raid5' THREAD: c2dd4000
>> GPR00: 00000001 c2dd5d30 e820a580 c2fb1088 00000001 00000000 00000002 00=
001000
>> GPR08: 00000001 c0485a20 00000000 ef8092f8 22002024 55555555 c2d67870 c0=
282d2c
>> GPR16: 00001000 e8355c00 c2eff964 00000000 00000000 00000019 01000040 c2=
dd5e00
>> GPR24: c2dd5dfc 00000001 c2dd5dc0 c099c420 00000000 c2d67838 00000002 c2=
dd5d58
>> NIP [c01c45d8] async_tx_quiesce+0x28/0x74
> [..]
>> I checked the kernel source code, and find that this OOPS was caused
>> by the following BUG_ON code:
>> It is in crypto/async_tx/async_tx.c:
>> void async_tx_quiesce(struct dma_async_tx_descriptor **tx)
>> {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (*tx) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* if ack is alre=
ady set then we cannot be sure
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * we are referri=
ng to the correct operation
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BUG_ON(async_tx_t=
est_ack(*tx));
>> =C2=A0 /* OOPS occured */
>
> Yes, this looks like a manifestation of the issue I brought up in my
> review of the driver [1]. =C2=A0The talitos_prep_dma_xor routine is alway=
s
> acknowledging its descriptors, which it should not because that is the
> responsibility of the client of the api. =C2=A0When the raid code tries t=
o
> attach a memcpy that depends on the xor it sees that it needs to
> switch to from talitos to fsldma (or software if fsldma is turned
> off). =C2=A0Since talitos does not have the DMA_INTERRUPT capability to
> trigger the channel switch we need to perform a synchronous wait for
> the xor to complete before submitting the memcpy. =C2=A0When the ack bit =
is
> not set the xor descriptor might be recycled by the dma device driver
> while we are waiting for it, hence the BUG_ON().
>
Thanks for reply, Dan.
Forgot to say, when this OOPS happened, I have not applied talitos XOR
patch. I only enabled async_xx api and FSL_DMA, so here
I think XOR was done by CPU and memcpy was done by DMA using async_xx api.
Another interseting thing I should say is that I have tried latest
stable kernel 2.6.31.6, this problem didn't exist. After I applied
talitos XOR patch, it was OK too. I checked the related souce codes
and it seems that there were no changes which make me feel very
confused.

I have been testing latest serials of kernels about XOR patch on
MPC8548 board and I hope Freescale guys also can give me help.

> --
> Dan
>
> See the final comment:
> [1]: http://marc.info/?l=3Dlinux-raid&m=3D125685641412112&w=3D2
>



--=20
The simplest is not all best but the best is surely the simplest!
