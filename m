Return-Path: <srs0=8qzd=4r=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wP31c31xCzDqZw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 05:23:48 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wP31c299Lz8sx7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 05:23:48 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wP31b5BDrz9s3s
 for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2017 05:23:46 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4BJIsSP145439
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 15:23:44 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2acucupqem-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 15:23:44 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 12 May 2017 05:23:41 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4BJNVfh1048950
 for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2017 05:23:39 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4BJN6FO012722
 for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2017 05:23:06 +1000
Subject: [PATCH v2 1/3] powerpc/fadump: avoid duplicates in crash memory ranges
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Pingfan Liu <piliu@redhat.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 12 May 2017 00:52:47 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <149453053109.32468.3382678673815454269.stgit@hbathini.in.ibm.com>
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

When 10 lmbs are hot-removed and then hot-plugged before registering
fadump, here is how the program headers in /proc/vmcore exported by
fadump look like

without this change:

  Program Headers:
    Type           Offset             VirtAddr           PhysAddr
                   FileSiz            MemSiz              Flags  Align
    NOTE           0x0000000000010000 0x0000000000000000 0x0000000000000000
                   0x0000000000001890 0x0000000000001890         0
    LOAD           0x0000000000021020 0xc000000000000000 0x0000000000000000
                   0x0000000080000000 0x0000000080000000  RWE    0
    LOAD           0x0000000080031020 0xc000000000000000 0x0000000000000000
                   0x0000000020000000 0x0000000020000000  RWE    0
    LOAD           0x00000000a0040000 0xc000000020000000 0x0000000020000000
                   0x0000000050000000 0x0000000050000000  RWE    0
    LOAD           0x00000000f0040000 0xc000000070000000 0x0000000070000000
                   0x0000000010000000 0x0000000010000000  RWE    0
    LOAD           0x0000000100040000 0xc000000100020000 0x0000000100020000
                   0x000000000ffe0000 0x000000000ffe0000  RWE    0
    LOAD           0x0000000110020000 0xc000000110000000 0x0000000110000000
                   0x00000000b0000000 0x00000000b0000000  RWE    0
    LOAD           0x00000001c0020000 0xc0000001c0000000 0x00000001c0000000
                   0x0000000080000000 0x0000000080000000  RWE    0

and with this change:

  Program Headers:
    Type           Offset             VirtAddr           PhysAddr
                   FileSiz            MemSiz              Flags  Align
    NOTE           0x0000000000010000 0x0000000000000000 0x0000000000000000
                   0x0000000000001890 0x0000000000001890         0
    LOAD           0x0000000000021020 0xc000000000000000 0x0000000000000000
                   0x0000000080000000 0x0000000080000000  RWE    0
    LOAD           0x0000000080030000 0xc000000100020000 0x0000000100020000
                   0x000000000ffe0000 0x000000000ffe0000  RWE    0
    LOAD           0x0000000090010000 0xc000000110000000 0x0000000110000000
                   0x0000000060000000 0x0000000060000000  RWE    0
    LOAD           0x00000000f0010000 0xc000000170000000 0x0000000170000000
                   0x00000000d0000000 0x00000000d0000000  RWE    0


Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
---

Changes since v1:
* Changelog updated based on data from latest kerenl.
* Updated comment with the assumption involved.


 arch/powerpc/kernel/fadump.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index 466569e..e4e1a14 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -831,8 +831,18 @@ static void fadump_setup_crash_memory_ranges(void)
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
+		if (start < fw_dump.boot_memory_size) {
+			if (end > fw_dump.boot_memory_size)
+				start = fw_dump.boot_memory_size;
+			else
+				continue;
+		}
 
 		/* add this range excluding the reserved dump area. */
 		fadump_exclude_reserved_area(start, end);
