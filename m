Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1CCF32C01D3
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 22:54:19 +1000 (EST)
Received: from mail42-co1 (localhost [127.0.0.1])	by mail42-co1-R.bigfish.com
 (Postfix) with ESMTP id 9AF485C02C6	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 12:51:58 +0000 (UTC)
Received: from CO1EHSMHS006.bigfish.com (unknown [10.243.78.231])	by
 mail42-co1.bigfish.com (Postfix) with ESMTP id 076D56C0530	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Jul 2012 12:51:38 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q69CrpVU010132	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 9 Jul 2012 05:53:51 -0700
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <agraf@suse.de>, <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <linuxppc-dev@lists.ozlabs.org>, <kvm-ppc@vger.kernel.org>
Subject: [PATCH 0/4] powerpc/booke: Modifications to fsl booke cpu setup code
Date: Mon, 9 Jul 2012 18:22:37 +0530
Message-ID: <1341838357-16887-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modifications are aimed specifically at the e500mc/e5500 cpu setup code.
Following modifications are introduced by this patchset:
1. Move the E.HV check to the cpu setup code. Based on this check we manipulte the
   CPU_FTR_EMB_HV flag (added as a part of e500mc KVM support) in the cpu_spec 
   structure. We determine the presence of this feature based on the MMUCFG[LPIDSIZE]
   check and decide if we can setup the E.HV mode ivors.
2. Merge the 32 bit cpu setup code for e500mc/e5500 and define the "cpu_restore"
   routine (for e5500/e6500) only for the 64 bit case. The cpu_restore routine
   is used in the 64 bit case for setting up the secondary cores.
3. For the 64 bit case separate out e5500 cpu_setup and cpu_restore functions.
   The cpu_setup function (for the primary core) is passed the cpu_spec pointer,
   which is not there in case of the cpu_restore function. Also, in our case
   we will have to manipulate the CPU_FTR_EMB_HV flag on the the primary core.  
4. Added CPU_FTR_EMB_HV check for e5500.

Varun Sethi (4):
  Separate out E.HV check and ivor setup code.
  Merge the PPC 32 e5500 setup code with e500mc setup and don't define
  a restore routine for PPC 32.
  Separate out restore_e5500/setup_e5500 routines and check for E.HV
  mode before setting ivor setting code.
  Add CPU_FTR_EMB_HV check for e5500.

 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   74 +++++++++++++++++++++++++----
 arch/powerpc/kernel/cputable.c            |    4 ++
 arch/powerpc/kernel/exceptions-64e.S      |   18 +------
 arch/powerpc/kernel/head_fsl_booke.S      |   18 ++-----
 4 files changed, 75 insertions(+), 39 deletions(-)

-- 
1.7.4.1
