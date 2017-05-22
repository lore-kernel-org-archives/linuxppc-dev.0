Return-Path: <srs0=ejaj=44=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wWYSC0vwLzDqNc
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 19:35:55 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wWYSC096pz8tD8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 May 2017 19:35:55 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wWYSB32dkz9rvt
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 19:35:54 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4M9Z5dq120467
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 05:35:51 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2akwfv81dd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 05:35:50 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Mon, 22 May 2017 19:35:48 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4M9ZaWH52953330
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 19:35:44 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4M9ZB8Y016039
 for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2017 19:35:12 +1000
Subject: [PATCH 2/2] powerpc/fadump: update about offset where fadump is
 reserved
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Prarit Bhargava <prarit@redhat.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Ankit Kumar <ankit@linux.vnet.ibm.com>, Dave Young <dyoung@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 22 May 2017 15:04:47 +0530
In-Reply-To: <149544566391.16888.187413825827689513.stgit@hbathini.in.ibm.com>
References: <149544566391.16888.187413825827689513.stgit@hbathini.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149544568763.16888.16656118217496342159.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With commit f6e6bedb7731 ("powerpc/fadump: Reserve memory at an offset
closer to bottom of RAM"), memory for fadump is no longer reserved at
the top of RAM. But there are still a few places which say so. Change
them appropriately.

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
---
 Documentation/powerpc/firmware-assisted-dump.txt |    4 ++--
 arch/powerpc/kernel/fadump.c                     |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/powerpc/firmware-assisted-dump.txt b/Documentation/powerpc/firmware-assisted-dump.txt
index 9cabaf8..bdd344a 100644
--- a/Documentation/powerpc/firmware-assisted-dump.txt
+++ b/Documentation/powerpc/firmware-assisted-dump.txt
@@ -61,8 +61,8 @@ as follows:
          boot successfully. For syntax of crashkernel= parameter,
          refer to Documentation/kdump/kdump.txt. If any offset is
          provided in crashkernel= parameter, it will be ignored
-         as fadump reserves memory at end of RAM for boot memory
-         dump preservation in case of a crash.
+         as fadump uses a predefined offset to reserve memory
+         for boot memory dump preservation in case of a crash.
 
 -- After the low memory (boot memory) area has been saved, the
    firmware will reset PCI and other hardware state.  It will
diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index c0db844..63c4281 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -218,8 +218,8 @@ static inline unsigned long fadump_calculate_reserve_size(void)
 
 	/*
 	 * Check if the size is specified through crashkernel= cmdline
-	 * option. If yes, then use that but ignore base as fadump
-	 * reserves memory at end of RAM.
+	 * option. If yes, then use that but ignore base as fadump reserves
+	 * memory at a predefined offset.
 	 */
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&size, &base);
