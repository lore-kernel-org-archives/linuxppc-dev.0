Return-Path: <srs0=hqze=5g=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdvK00gDTzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 03:21:39 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wdvJz5BZNz8t85
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 03:21:39 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wdvJz1Bf2z9s78
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Jun 2017 03:21:38 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v51HJLWG122310
 for <linuxppc-dev@ozlabs.org>; Thu, 1 Jun 2017 13:21:35 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2atntsm1fv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 01 Jun 2017 13:21:35 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 2 Jun 2017 03:21:32 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v51HLLS965077362
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2017 03:21:29 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v51HKvb7024471
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Jun 2017 03:20:57 +1000
Subject: [PATCH v3 1/3] powerpc/fadump: avoid duplicates in crash memory ranges
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michal =?utf-8?b?U3VjaMOhbmVr?= <msuchanek@suse.de>,
 Pingfan Liu <piliu@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 01 Jun 2017 22:50:38 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149633761543.6229.12888040793158845755.stgit@hbathini.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

fadump sets up crash memory ranges to be used for creating PT_LOAD
program headers in elfcore header. Memory chunk RMA_START through
boot memory area size is added as the first memory range because
firmware, at the time of crash, moves this memory chunk to different
location specified during fadump registration making it necessary to
create a separate program header for it with the correct offset.
This memory chunk is skipped while setting up the remaining memory
ranges. But currently, there is possibility that some of this memory
may have duplicate entries like when it is hot-removed and added
again. Ensure that no two memory ranges represent the same memory.

When 5 lmbs are hot-removed and then hot-plugged before registering
fadump, here is how the program headers in /proc/vmcore exported by
fadump look like

without this change:

  Program Headers:
    Type           Offset             VirtAddr           PhysAddr
                   FileSiz            MemSiz              Flags  Align
    NOTE           0x0000000000010000 0x0000000000000000 0x0000000000000000
                   0x0000000000001894 0x0000000000001894         0
    LOAD           0x0000000000021020 0xc000000000000000 0x0000000000000000
                   0x0000000040000000 0x0000000040000000  RWE    0
    LOAD           0x0000000040031020 0xc000000000000000 0x0000000000000000
                   0x0000000010000000 0x0000000010000000  RWE    0
    LOAD           0x0000000050040000 0xc000000010000000 0x0000000010000000
                   0x0000000050000000 0x0000000050000000  RWE    0
    LOAD           0x00000000a0040000 0xc000000060000000 0x0000000060000000
                   0x000000019ffe0000 0x000000019ffe0000  RWE    0

and with this change:

  Program Headers:
    Type           Offset             VirtAddr           PhysAddr
                   FileSiz            MemSiz              Flags  Align
    NOTE           0x0000000000010000 0x0000000000000000 0x0000000000000000
                   0x0000000000001894 0x0000000000001894         0
    LOAD           0x0000000000021020 0xc000000000000000 0x0000000000000000
                   0x0000000040000000 0x0000000040000000  RWE    0
    LOAD           0x0000000040030000 0xc000000040000000 0x0000000040000000
                   0x0000000020000000 0x0000000020000000  RWE    0
    LOAD           0x0000000060030000 0xc000000060000000 0x0000000060000000
                   0x000000019ffe0000 0x000000019ffe0000  RWE    0

Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
---

Changes since v2:
* Added BUILD_BUG_ON for RAM_START.


 arch/powerpc/kernel/fadump.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 466569e..f7ba0dc 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -831,8 +831,19 @@ static void fadump_setup_crash_memory_ranges(void)
 	for_each_memblock(memory, reg) {
 		start = (unsigned long long)reg->base;
 		end = start + (unsigned long long)reg->size;
-		if (start == RMA_START && end >= fw_dump.boot_memory_size)
-			start = fw_dump.boot_memory_size;
+
+		/*
+		 * skip the first memory chunk that is already added (RMA_START
+		 * through boot_memory_size). This logic needs a relook if and
+		 * when RMA_START changes to a non-zero value.
+		 */
+		BUILD_BUG_ON(RMA_START != 0);
+		if (start < fw_dump.boot_memory_size) {
+			if (end > fw_dump.boot_memory_size)
+				start = fw_dump.boot_memory_size;
+			else
+				continue;
+		}
 
 		/* add this range excluding the reserved dump area. */
 		fadump_exclude_reserved_area(start, end);
