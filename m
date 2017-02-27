Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX3wQ5P8HzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 01:28:22 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1REKgQt035350
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 09:28:20 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28vm1qwykd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 09:28:19 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Mon, 27 Feb 2017 07:28:18 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 8FE4719D8026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 07:27:26 -0700 (MST)
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1RESFlM7864684
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 07:28:15 -0700
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0BAF6A041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 07:28:14 -0700 (MST)
Received: from oc5780617838.ibm.com.rchland.ibm.com (unknown [9.10.86.187])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP id C38E16A03C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 07:28:14 -0700 (MST)
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/1] Add ASCII dump to d1,d2,d4,d8 commands.
Date: Mon, 27 Feb 2017 08:28:14 -0600
Message-Id: <1488205694-13337-1-git-send-email-dougmill@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The reason debuggers add an ASCII dump to other types of memory dumps
is to give the user visual reference points in the case that ASCII
strings are adjacent to other structures or element.  For example,
when examining the task_struct structure one can look for the comm[]
string and use it to locate other important elements.

ASCII strings do not have endianess, they exist in memory in the same
order regardless of CPU endianess. ASCII strings are, by definition,
human readable and so should be presented in a human readable format.

For these reasons, the supplemental ASCII dump does not re-order
the strings from memory to match the endianess of the corresponding
16, 32, or 64 bit words. That would make the ASCII dump much less
useful.

Signed-off-by: Douglas Miller <dougmill@linux.vnet.ibm.com>
---
 arch/powerpc/xmon/xmon.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 57503cd..f8f0f35 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2366,7 +2366,12 @@ static void dump_by_size(unsigned long addr, long count, int size)
 
 			printf("%0*lx", size * 2, val);
 		}
-		printf("\n");
+		printf("  |");
+		for (j = 0; j < 16; ++j) {
+			val = temp[j];
+			putchar(' ' <= val && val <= '~' ? val : '.');
+		}
+		printf("|\n");
 	}
 }
 
-- 
1.7.1
