Return-Path: <R65777@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 298C02C01BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2013 03:00:35 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Anthony Foiani <tkil@scrye.com>
Subject: RE: MPC8315 reboot failure, lockdep splat possibly related?
Date: Sun, 18 Aug 2013 17:00:25 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D07115911@039-SN2MPN1-013.039d.mgd.msft.net>
References: <g61v5p02b.fsf@dworkin.scrye.com>
 <6A3DF150A5B70D4F9B66A25E3F7C888D07114F7C@039-SN2MPN1-013.039d.mgd.msft.net>
 <gwqnjoo9g.fsf@dworkin.scrye.com>
In-Reply-To: <gwqnjoo9g.fsf@dworkin.scrye.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Anthony Foiani [mailto:tkil@scrye.com]
> Sent: Sunday, August 18, 2013 5:37 AM
> To: Bhushan Bharat-R65777
> Cc: linuxppc-dev@lists.ozlabs.org
> Subject: Re: MPC8315 reboot failure, lockdep splat possibly related?
>=20
> Bhushan Bharat-R65777 <R65777@freescale.com> writes:
>=20
> > You should get rid of this by changing spin_lock/unlock() in
> > fsl_sata_set_irq_coalescing() to spin_lock_irqsave/restore()
>=20
> I can verify that the suggested change removes the lockdep warning.
> The below patch is against 3.9.7 and has been tested on hardware with tha=
t
> release.
>=20
> It applies with slight fuzz to linux-next; I've compile-tested that versi=
on, but
> I have not booted that build on the hardware.  The linux-next patch can b=
e found
> here:
>=20
>   http://scrye.com/~tkil/linux/fsl-sata-lockdep-201308/next-sata-fsl-save=
-irqs-
> while-coalescing.patch
>   (or: http://preview.tinyurl.com/mpd4e9h )

Anthony, I would prefer if you can send the patch (In case not then let me =
know)

Thanks
-Bharat

>=20
> Unfortunately, the hang on reboot was not easily repeatable; I'll report =
whether
> it happens in the next few days or not.


>=20
> Thanks again,
> Anthony Foiani
>=20
> -- >8 --
>=20
> From 2abb6df770c95eb4103476c70847a78f816fe5e3 Mon Sep 17 00:00:00 2001
> From: Anthony Foiani <anthony.foiani@gmail.com>
> Date: Sat, 17 Aug 2013 13:28:17 -0600
> Subject: [PATCH] sata: fsl: save irqs while coalescing
>=20
> Before this patch, I was seeing the following lockdep splat on my
> MPC8315 (PPC32) target:
>=20
>   [    9.086051] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   [    9.090393] [ INFO: inconsistent lock state ]
>   [    9.094744] 3.9.7-ajf-gc39503d #1 Not tainted
>   [    9.099087] ---------------------------------
>   [    9.103432] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>   [    9.109431] scsi_eh_1/39 [HC1[1]:SC0[0]:HE0:SE1] takes:
>   [    9.114642]  (&(&host->lock)->rlock){?.+...}, at: [<c02f4168>]
> sata_fsl_interrupt+0x50/0x250
>   [    9.123137] {HARDIRQ-ON-W} state was registered at:
>   [    9.128004]   [<c006cdb8>] lock_acquire+0x90/0xf4
>   [    9.132737]   [<c043ef04>] _raw_spin_lock+0x34/0x4c
>   [    9.137645]   [<c02f3560>] fsl_sata_set_irq_coalescing+0x68/0x100
>   [    9.143750]   [<c02f36a0>] sata_fsl_init_controller+0xa8/0xc0
>   [    9.149505]   [<c02f3f10>] sata_fsl_probe+0x17c/0x2e8
>   [    9.154568]   [<c02acc90>] driver_probe_device+0x90/0x248
>   [    9.159987]   [<c02acf0c>] __driver_attach+0xc4/0xc8
>   [    9.164964]   [<c02aae74>] bus_for_each_dev+0x5c/0xa8
>   [    9.170028]   [<c02ac218>] bus_add_driver+0x100/0x26c
>   [    9.175091]   [<c02ad638>] driver_register+0x88/0x198
>   [    9.180155]   [<c0003a24>] do_one_initcall+0x58/0x1b4
>   [    9.185226]   [<c05aeeac>] kernel_init_freeable+0x118/0x1c0
>   [    9.190823]   [<c0004110>] kernel_init+0x18/0x108
>   [    9.195542]   [<c000f6b8>] ret_from_kernel_thread+0x64/0x6c
>   [    9.201142] irq event stamp: 160
>   [    9.204366] hardirqs last  enabled at (159): [<c043f778>]
> _raw_spin_unlock_irq+0x30/0x50
>   [    9.212469] hardirqs last disabled at (160): [<c000f414>]
> reenable_mmu+0x30/0x88
>   [    9.219867] softirqs last  enabled at (144): [<c002ae5c>]
> __do_softirq+0x168/0x218
>   [    9.227435] softirqs last disabled at (137): [<c002b0d4>]
> irq_exit+0xa8/0xb4
>   [    9.234481]
>   [    9.234481] other info that might help us debug this:
>   [    9.240995]  Possible unsafe locking scenario:
>   [    9.240995]
>   [    9.246898]        CPU0
>   [    9.249337]        ----
>   [    9.251776]   lock(&(&host->lock)->rlock);
>   [    9.255878]   <Interrupt>
>   [    9.258492]     lock(&(&host->lock)->rlock);
>   [    9.262765]
>   [    9.262765]  *** DEADLOCK ***
>   [    9.262765]
>   [    9.268684] no locks held by scsi_eh_1/39.
>   [    9.272767]
>   [    9.272767] stack backtrace:
>   [    9.277117] Call Trace:
>   [    9.279589] [cfff9da0] [c0008504] show_stack+0x48/0x150 (unreliable)
>   [    9.285972] [cfff9de0] [c0447d5c] print_usage_bug.part.35+0x268/0x27=
c
>   [    9.292425] [cfff9e10] [c006ace4] mark_lock+0x2ac/0x658
>   [    9.297660] [cfff9e40] [c006b7e4] __lock_acquire+0x754/0x1840
>   [    9.303414] [cfff9ee0] [c006cdb8] lock_acquire+0x90/0xf4
>   [    9.308745] [cfff9f20] [c043ef04] _raw_spin_lock+0x34/0x4c
>   [    9.314250] [cfff9f30] [c02f4168] sata_fsl_interrupt+0x50/0x250
>   [    9.320187] [cfff9f70] [c0079ff0] handle_irq_event_percpu+0x90/0x254
>   [    9.326547] [cfff9fc0] [c007a1fc] handle_irq_event+0x48/0x78
>   [    9.332220] [cfff9fe0] [c007c95c] handle_level_irq+0x9c/0x104
>   [    9.337981] [cfff9ff0] [c000d978] call_handle_irq+0x18/0x28
>   [    9.343568] [cc7139f0] [c000608c] do_IRQ+0xf0/0x1a8
>   [    9.348464] [cc713a20] [c000fc8c] ret_from_except+0x0/0x14
>   [    9.353983] --- Exception: 501 at _raw_spin_unlock_irq+0x40/0x50
>   [    9.353983]     LR =3D _raw_spin_unlock_irq+0x30/0x50
>   [    9.364839] [cc713af0] [c043db10] wait_for_common+0xac/0x188
>   [    9.370513] [cc713b30] [c02ddee4] ata_exec_internal_sg+0x2b0/0x4f0
>   [    9.376699] [cc713be0] [c02de18c] ata_exec_internal+0x68/0xa8
>   [    9.382454] [cc713c20] [c02de4b8] ata_dev_read_id+0x158/0x594
>   [    9.388205] [cc713ca0] [c02ec244] ata_eh_recover+0xd88/0x13d0
>   [    9.393962] [cc713d20] [c02f2520] sata_pmp_error_handler+0xc0/0x8ac
>   [    9.400234] [cc713dd0] [c02ecdc8] ata_scsi_port_error_handler+0x464/=
0x5e8
>   [    9.407023] [cc713e10] [c02ecfd0] ata_scsi_error+0x84/0xb8
>   [    9.412528] [cc713e40] [c02c4974] scsi_error_handler+0xd8/0x47c
>   [    9.418457] [cc713eb0] [c004737c] kthread+0xa8/0xac
>   [    9.423355] [cc713f40] [c000f6b8] ret_from_kernel_thread+0x64/0x6c
>=20
> This fix was suggested by Bhushan Bharat <R65777@freescale.com>, and was
> discussed in email at:
>=20
>   http://linuxppc.10917.n7.nabble.com/MPC8315-reboot-failure-lockdep-spla=
t-
> possibly-related-tp75162.html
>=20
> Signed-off-by: Anthony Foiani <anthony.foiani@gmail.com>
> ---
>  drivers/ata/sata_fsl.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c index
> 0e93ba9..c240b63 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -292,6 +292,7 @@ static void fsl_sata_set_irq_coalescing(struct ata_ho=
st
> *host,  {
>  	struct sata_fsl_host_priv *host_priv =3D host->private_data;
>  	void __iomem *hcr_base =3D host_priv->hcr_base;
> +	unsigned long flags;
>=20
>  	if (count > ICC_MAX_INT_COUNT_THRESHOLD)
>  		count =3D ICC_MAX_INT_COUNT_THRESHOLD;
> @@ -304,12 +305,12 @@ static void fsl_sata_set_irq_coalescing(struct ata_=
host
> *host,
>  			(count > ICC_MIN_INT_COUNT_THRESHOLD))
>  		ticks =3D ICC_SAFE_INT_TICKS;
>=20
> -	spin_lock(&host->lock);
> +	spin_lock_irqsave(&host->lock, flags);
>  	iowrite32((count << 24 | ticks), hcr_base + ICC);
>=20
>  	intr_coalescing_count =3D count;
>  	intr_coalescing_ticks =3D ticks;
> -	spin_unlock(&host->lock);
> +	spin_unlock_irqrestore(&host->lock, flags);
>=20
>  	DPRINTK("intrrupt coalescing, count =3D 0x%x, ticks =3D %x\n",
>  			intr_coalescing_count, intr_coalescing_ticks);
> --
> 1.8.1.4
>=20
