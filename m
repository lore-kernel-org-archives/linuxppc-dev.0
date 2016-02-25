Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F6251A0570
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 15:55:57 +1100 (AEDT)
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1BF1F140322
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:55:57 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 25 Feb 2016 14:55:55 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id E1FA93578052
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:55:51 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1P4thj07340294
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:55:51 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1P4tJkx019977
 for <linuxppc-dev@ozlabs.org>; Thu, 25 Feb 2016 15:55:19 +1100
Subject: [PATCH 2/3] powernv: Rename pSeries to powenv from
 machine_check_pSeries_early.
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Date: Thu, 25 Feb 2016 10:25:00 +0530
Message-ID: <20160225045447.6543.89882.stgit@mars.in.ibm.com>
In-Reply-To: <20160225045420.6543.55495.stgit@mars.in.ibm.com>
References: <20160225045420.6543.55495.stgit@mars.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

The routine machine_check_pSeries_early() is only used on powernv, not
pseries. Hence rename machine_check_pSeries_early to
machine_check_powernv_early.

Reported-by: Paul Mackerras <paulus@samba.org>
Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/exceptions-64s.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0607ae9..d4c99f0 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -189,7 +189,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 #endif /* CONFIG_PPC_P7_NAP */
 	EXCEPTION_PROLOG_0(PACA_EXMC)
 BEGIN_FTR_SECTION
-	b	machine_check_pSeries_early
+	b	machine_check_powernv_early
 FTR_SECTION_ELSE
 	b	machine_check_pSeries_0
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE)
@@ -443,7 +443,7 @@ denorm_exception_hv:
 
 	.align	7
 	/* moved from 0x200 */
-machine_check_pSeries_early:
+machine_check_powernv_early:
 BEGIN_FTR_SECTION
 	EXCEPTION_PROLOG_1(PACA_EXMC, NOTEST, 0x200)
 	/*
