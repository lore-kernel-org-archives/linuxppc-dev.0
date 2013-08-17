Return-Path: <R65777@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A4D792C0271
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Aug 2013 14:58:43 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: Anthony Foiani <tkil@scrye.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: MPC8315 reboot failure, lockdep splat possibly related?
Date: Sat, 17 Aug 2013 04:58:34 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D07114F7C@039-SN2MPN1-013.039d.mgd.msft.net>
References: <g61v5p02b.fsf@dworkin.scrye.com>
In-Reply-To: <g61v5p02b.fsf@dworkin.scrye.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+bharat.bhushan=3Dfreescale.com@lists.ozlabs.org] On Behalf Of Ant=
hony
> Foiani
> Sent: Saturday, August 17, 2013 7:10 AM
> To: linuxppc-dev@lists.ozlabs.org
> Subject: MPC8315 reboot failure, lockdep splat possibly related?
>=20
>=20
> Greetings.
>=20
> I've been experiencing occasional lockups at reboot for a few weeks, but =
only
> once every 10-20 boots.  A good reboot looks like this:
>=20
>   [47529.721640] lm77 0-0048: shutdown
>   [47529.725160] rtc-m41t80 0-0068: shutdown
>   [47529.729169] i2c i2c-0: shutdown
>   [47529.732534] fsl-ehci fsl-ehci.0: shutdown
>   [47529.736842] sd 1:0:0:0: shutdown
>   [47529.740239] sd 1:0:0:0: [sda] Synchronizing SCSI cache
>   [47529.747091] uio_pci_generic 0000:00:0a.0: shutdown
>   [47529.752079] pci 0000:00:00.0: shutdown
>   [47529.756021] Restarting system.
>=20
> While a bad one fails after the EHCI shutdown:
>=20
>   [  747.578001] lm77 0-0048: shutdown
>   [  747.581522] rtc-m41t80 0-0068: shutdown
>   [  747.585538] i2c i2c-0: shutdown
>   [  747.588909] sd 1:0:0:0: shutdown
>   [  747.592304] sd 1:0:0:0: [sda] Synchronizing SCSI cache
>   [  747.597973] fsl-ehci fsl-ehci.0: shutdown
>=20
> I enabled lockdep, and I get this splat on every boot, regardless of whet=
her it
> locks up at reboot or not.  Could it possibly be related?
> Any other ideas on how to avoid the reboot lockup?
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

You should get rid of this by changing spin_lock/unlock() in fsl_sata_set_i=
rq_coalescing() to spin_lock_irqsave/restore()

-Bharat


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
> A full set of kernel messages from a hanging (fails to reboot) session is=
 here:
>=20
>   http://scrye.com/~tkil/linux/fsl-sata-lockdep-201308/hang-log.txt
>=20
> And a full set of messages for a boot that reboots successfully:
>=20
>   http://scrye.com/~tkil/linux/fsl-sata-lockdep-201308/no-hang-log.txt
>=20
> The associated config file:
>=20
>   http://scrye.com/~tkil/linux/fsl-sata-lockdep-201308/config.txt
>=20
> The only addition I've made to this section of the kernel is my "SATA spe=
ed
> limit patch", discussed a few weeks back:
>=20
>   http://permalink.gmane.org/gmane.linux.ports.ppc.embedded/58969
>=20
> That patch does touch sata_fsl_probe, but it just sets a value -- it does=
n't do
> any locking (for better or for worse), nor does it call any other functio=
ns (and
> it seems that it's a function further down the stack that is triggering
> lockdep).
>=20
> I took a quick look at the diffs between 3.9.7 (both upstream and my
> variant) and the current head of linux-stable, and didn't see anything th=
at
> looked relevant.  The two main changes I saw were switching from dev_get_=
drvdata
> to platform_get_drvdata and adding the rx_watermark.
> I did see that dev_set_drvdata was removed from sata_fsl_probe's exit pat=
h; not
> sure if that could cause this sort of error.
>=20
> If anyone has ideas on how to avoid the reboot lockup, I would greatly
> appreciate it.
>=20
> Thank you for your time!
>=20
> Best regards,
> Anthony Foiani
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
