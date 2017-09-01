Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on0064.outbound.protection.outlook.com [104.47.36.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xkHDK01vvzDqbZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Sep 2017 21:33:05 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Machine Check in P2010(e500v2)
Date: Fri, 1 Sep 2017 11:32:57 +0000
Message-ID: <1504265576.20777.61.camel@infinera.com>
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

I am trying to debug a Machine Check for a P2010 (e500v2) CPU:

[   28.111816] Caused by (from MCSR=3D10008): Bus - Read Data Bus Error
[   28.117998] Oops: Machine check, sig: 7 [#1]
[   28.122263] P1010 RDB
[   28.124529] Modules linked in: linux_bcm_knet(PO) linux_user_bde(PO) lin=
ux_kernel_bde(PO)
[   28.132718] CPU: 0 PID: 470 Comm: emxp2_hw_bl Tainted: P           O    =
4.1.38+ #49
[   28.140376] task: db16cd10 ti: df128000 task.ti: df128000
[   28.145770] NIP: 00000000 LR: 10a4e404 CTR: 10046c38
[   28.150730] REGS: df129f10 TRAP: 0204   Tainted: P           O     (4.1.=
38+)
[   28.157776] MSR: 0002d000 <CE,EE,PR,ME>  CR: 44002428  XER: 00000000
[   28.164140] DEAR: b7187000 ESR: 00000000
GPR00: 10a4e404 bf86ea30 b7ca94a0 132f9fa8 07006000 07000000 00000000 132f9=
fd8
GPR08: b7149000 b7159000 0003e000 bf86ea20 24004424 11d6cf7c 00000000 00000=
000
GPR16: 10f6e29c 10f6c872 10f6db01 0000b541 0000b541 11d92fcc 00000011 00000=
001
GPR24: 01a4d12d 132ffbf0 11d60000 00000000 07006000 00000000 132f9fa8 00000=
000
[   28.196375] NIP [00000000]   (null)
[   28.199859] LR [10a4e404] 0x10a4e404
[   28.203426] Call Trace:
[   28.205866] ---[ end trace f456255ddf9bee83 ]---

I cannot figure out why NIP is NULL ? It LOOKs like NIP is set to
MCSRR0 early on but maybe it is lost somehow?

Anyhow, looking at entry_32.S:
	.globl	mcheck_transfer_to_handler
mcheck_transfer_to_handler:
	mfspr	r0,SPRN_DSRR0
	stw	r0,_DSRR0(r11)
	mfspr	r0,SPRN_DSRR1
	stw	r0,_DSRR1(r11)
	/* fall through */

	.globl	debug_transfer_to_handler
debug_transfer_to_handler:
	mfspr	r0,SPRN_CSRR0
	stw	r0,_CSRR0(r11)
	mfspr	r0,SPRN_CSRR1
	stw	r0,_CSRR1(r11)
	/* fall through */

	.globl	crit_transfer_to_handler
crit_transfer_to_handler:

It looks odd that DSRRx is assigned in mcheck and CSRRx in debug and
crit has none. Should not this assigment be shifted down one level?

  Jocke=
