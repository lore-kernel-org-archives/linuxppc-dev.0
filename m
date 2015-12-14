Return-Path: <alistair@popple.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A206F1A010A
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 14:36:21 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@ozlabs.org,
	mpe@ellerman.id.au
Cc: ivan@ru.ibm.com,
	Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/476fpe: Add support for kexec
Date: Mon, 14 Dec 2015 14:31:24 +1100
Message-Id: <1450063884-19728-1-git-send-email-alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PPC476FPE has a different PVR from previous PPC476 processors. The
kexec code checks the PVR in order to correctly setup the MMU. When
the initial support for 476FPE processors was added the corresponding
change in the kexec code was missed. This patch simply adds the check
and solves the following bug on kexec:

kexec: Starting new kernel
Bye!
Unable to handle kernel paging request for instruction fetch
Faulting instruction address: 0xee9a50f8
cpu 0x0: Vector: 400 (Instruction Access) at [ee9d7d20]
    pc: ee9a50f8
    lr: ee9a50e4
    sp: ee9d7dd0
    msr: 21020
    current = 0xee40f000
    pid   = 960, comm = kexec
enter ? for help
[link register   ] ee9a50e4
[ee9d7dd0] c0013748 default_machine_kexec+0x58/0x70 (unreliable)
[ee9d7df0] c0012f04 machine_kexec+0x34/0x40
[ee9d7e00] c00aa1ec kernel_kexec+0x9c/0xb0
[ee9d7e20] c005d704 SyS_reboot+0x1f4/0x220
[ee9d7f40] c000db68 ret_from_syscall+0x0/0x3c
--- Exception: c01 (System Call) at b77b69f4
SP (bfc4a670) is in userspace
0:mon>

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Reported-by: Ivan Mikhaylov <ivan@ru.ibm.com>
---
 arch/powerpc/kernel/misc_32.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index ed3ab50..be8edd6 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -743,6 +743,8 @@ relocate_new_kernel:
 	/* Check for 47x cores */
 	mfspr	r3,SPRN_PVR
 	srwi	r3,r3,16
+	cmplwi	cr0,r3,PVR_476FPE@h
+	beq	setup_map_47x
 	cmplwi	cr0,r3,PVR_476@h
 	beq	setup_map_47x
 	cmplwi	cr0,r3,PVR_476_ISS@h
-- 
2.1.4
