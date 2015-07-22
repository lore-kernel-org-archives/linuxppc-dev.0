Return-Path: <sam.mj@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43F431A1BF2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 15:51:26 +1000 (AEST)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 197421402C4
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:51:26 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.mj@au1.ibm.com>;
 Wed, 22 Jul 2015 15:51:25 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B1FCD2BB0057
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:51:21 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6M5pDx446727290
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:51:21 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6M5omNx015095
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Jul 2015 15:50:49 +1000
From: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: Samuel Mendoza-Jonas <sam.mj@au1.ibm.com>, benh@kernel.crashing.org,
 mpe@ellerman.id.au
Subject: [PATCH V4 0/2] powerpc/kexec: Reset endianess before kexec
Date: Wed, 22 Jul 2015 15:50:49 +1000
Message-Id: <1437544251-19016-1-git-send-email-sam.mj@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Older ppc64 kernels, namely those missing FIXUP_ENDIAN or opal_reinit_cpus,
will fail to boot if started via kexec from a little-endian kernel.
The following two patches make sure that the current endianess is reset to
big-endian just before entering the target kernel, and are accompanied by
a separate patch to kexec-lite that resets the endianess of the boot cpu.

Changes in v4:
As pointed out by Ben since interrupts are already disabled before checking
that all secondaries are in OPAL, we can make the call to opal_reinit_cpus
in C, in pnv_kexec_cpu_down().

Changes in v3: 
Move the call to opal_reinit_cpus into kexec_sequence so we can call it in
real mode with interrupts disabled. Update the kexec_sequence prototype so
that we can check if OPAL is present.
Fix the !CONFIG_PPC_BOOK3S_64 case in kexec_wait to correctly branch to 0x60

Changes in v2:
Add an #ifdef for subarch-specific code
Neaten the endian check (and extra call to mfmsr!) by modifying the msr and
branching to the target kernel in the same call to rfid.


Samuel Mendoza-Jonas (2):
  powerpc/kexec: Reset secondary cpu endianess before kexec
  powerpc/kexec: Reset HILE before kexec_sequence

 arch/powerpc/kernel/misc_64.S          | 13 +++++++++++--
 arch/powerpc/platforms/powernv/setup.c |  7 +++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.4.6
