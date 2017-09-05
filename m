Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0058.outbound.protection.outlook.com [104.47.37.58])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmgCX6FMtzDqXn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Sep 2017 18:40:40 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "scottwood@freescale.com" <scottwood@freescale.com>, "york.sun@nxp.com"
 <york.sun@nxp.com>
Subject: Re: Machine Check in P2010(e500v2)
Date: Tue, 5 Sep 2017 08:40:33 +0000
Message-ID: <1504600831.27247.20.camel@infinera.com>
References: <1504265576.20777.61.camel@infinera.com>
In-Reply-To: <1504265576.20777.61.camel@infinera.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So after some debugging I found this bug:
@@ -996,7 +998,7 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
        if (is_in_pci_mem_space(addr)) {
                if (user_mode(regs)) {
                        pagefault_disable();
-                       ret =3D get_user(regs->nip, &inst);
+                       ret =3D get_user(inst, (__u32 __user *)regs->nip);
                        pagefault_enable();
                } else {
                        ret =3D probe_kernel_address(regs->nip, inst);

However, the kernel still locked up after fixing that.
Now I wonder why this fixup is there in the first place? The routine
will not really fixup the insn, just return 0xffffffff for the failing
read and then advance the process NIP.

Removing the fixup does not help either, kernel still locks up:
[   28.170532] Machine check in kernel mode.
[   28.174538] Caused by (from MCSR=3D10008):
[   28.182804] Bus - Read Data Bus Error: DAR:b7013000
[   28.197079] Oops: Machine check, sig: 7 [#1]
[   28.201343] P1010 RDB
[   28.203608] Modules linked in: linux_bcm_knet(PO) linux_user_bde(PO) lin=
ux_kernel_bde(PO)
[   28.211796] CPU: 0 PID: 470 Comm: emxp2_hw_bl Tainted: P           O    =
4.1.38+ #201
[   28.219540] task: db16ed10 ti: df122000 task.ti: df122000
[   28.224935] NIP: 10a4e2f4 LR: 10a4e404 CTR: 10046c38
[   28.229896] REGS: df123f10 TRAP: 0204   Tainted: P           O     (4.1.=
38+)
[   28.236942] MSR: 0002d000 <CE,EE,PR,ME>  CR: 44002428  XER: 00000000
[   28.243306] DEAR: b7013000 ESR: 00000000
GPR00: 10a4e404 bfab2730 b7b354a0 132f9fa8 07006000 07000000 00000000 132f9=
fd8
GPR08: b6fd5000 b6fe5000 0003e000 bfab2720 24004424 11d6cf7c 00000000 00000=
000
GPR16: 10f6e29c 10f6c872 10f6db01 0000b541 0000b541 11d92fcc 00000011 00000=
001
GPR24: 01a5bd3e 132ffbf0 11d60000 00000000 07006000 00000000 132f9fa8 00000=
000
[   28.275547] NIP [10a4e2f4] 0x10a4e2f4
[   28.279204] LR [10a4e404] 0x10a4e404
[   28.282772] Call Trace:
[   28.285213] ---[ end trace 9f8b64ab1e83f449 ]---
[   28.289825]


 Jocke=20

On Fri, 2017-09-01 at 13:32 +0200, Joakim Tjernlund wrote:
> I am trying to debug a Machine Check for a P2010 (e500v2) CPU:
>=20
> [   28.111816] Caused by (from MCSR=3D10008): Bus - Read Data Bus Error
> [   28.117998] Oops: Machine check, sig: 7 [#1]
> [   28.122263] P1010 RDB
> [   28.124529] Modules linked in: linux_bcm_knet(PO) linux_user_bde(PO) l=
inux_kernel_bde(PO)
> [   28.132718] CPU: 0 PID: 470 Comm: emxp2_hw_bl Tainted: P           O  =
  4.1.38+ #49
> [   28.140376] task: db16cd10 ti: df128000 task.ti: df128000
> [   28.145770] NIP: 00000000 LR: 10a4e404 CTR: 10046c38
> [   28.150730] REGS: df129f10 TRAP: 0204   Tainted: P           O     (4.=
1.38+)
> [   28.157776] MSR: 0002d000 <CE,EE,PR,ME>  CR: 44002428  XER: 00000000
> [   28.164140] DEAR: b7187000 ESR: 00000000
> GPR00: 10a4e404 bf86ea30 b7ca94a0 132f9fa8 07006000 07000000 00000000 132=
f9fd8
> GPR08: b7149000 b7159000 0003e000 bf86ea20 24004424 11d6cf7c 00000000 000=
00000
> GPR16: 10f6e29c 10f6c872 10f6db01 0000b541 0000b541 11d92fcc 00000011 000=
00001
> GPR24: 01a4d12d 132ffbf0 11d60000 00000000 07006000 00000000 132f9fa8 000=
00000
> [   28.196375] NIP [00000000]   (null)
> [   28.199859] LR [10a4e404] 0x10a4e404
> [   28.203426] Call Trace:
> [   28.205866] ---[ end trace f456255ddf9bee83 ]---
>=20
> I cannot figure out why NIP is NULL ? It LOOKs like NIP is set to
> MCSRR0 early on but maybe it is lost somehow?
>=20
> Anyhow, looking at entry_32.S:
> 	.globl	mcheck_transfer_to_handler
> mcheck_transfer_to_handler:
> 	mfspr	r0,SPRN_DSRR0
> 	stw	r0,_DSRR0(r11)
> 	mfspr	r0,SPRN_DSRR1
> 	stw	r0,_DSRR1(r11)
> 	/* fall through */
>=20
> 	.globl	debug_transfer_to_handler
> debug_transfer_to_handler:
> 	mfspr	r0,SPRN_CSRR0
> 	stw	r0,_CSRR0(r11)
> 	mfspr	r0,SPRN_CSRR1
> 	stw	r0,_CSRR1(r11)
> 	/* fall through */
>=20
> 	.globl	crit_transfer_to_handler
> crit_transfer_to_handler:
>=20
> It looks odd that DSRRx is assigned in mcheck and CSRRx in debug and
> crit has none. Should not this assigment be shifted down one level?
>=20
>   Jocke
