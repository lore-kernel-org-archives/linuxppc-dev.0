Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sfmbF47p8zDsgc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 16:21:13 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8M6Ksom071002
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 02:21:11 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25kkb7a7wd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 02:21:10 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 22 Sep 2016 11:51:07 +0530
Received: from d28relay08.in.ibm.com (d28relay08.in.ibm.com [9.184.220.159])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id CB517394004E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 11:51:03 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay08.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8M6Kss828835880
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 11:50:54 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8M6L2s0008952
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 11:51:03 +0530
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH] Work around for enabling CONFIG_CMDLINE on ppc64le
Date: Thu, 22 Sep 2016 11:50:45 +0530
Message-Id: <1474525245-10739-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Observed that boot arguments (passed as CONFIG_CMDLINE)  are not being
picked up by kernel while using gcc-ppc64-linux-gnu v5.4.0 and v6.1.1.
While it works as expected with v5.3.1 .

Found that in init/main.c in  setup_command_line() the pointers passed to
strcpy() is messed up.

source for setup_command_line from init/main.c:
void setup_command_line(char *command_line)
{
        saved_command_line =
                memblock_virt_alloc(strlen(boot_command_line) + 1, 0);
        initcall_command_line =
                memblock_virt_alloc(strlen(boot_command_line) + 1, 0);
        static_command_line = memblock_virt_alloc(strlen(command_line) + 1, 0);
        strcpy(saved_command_line, boot_command_line);
        strcpy(static_command_line, command_line);
}

Following is the asm dump for strcpy:

char *strcpy(char *dest, const char *src)
{
c000000000161408:       ff ff 84 38     addi    r4,r4,-1
c00000000016140c:       ff ff 43 39     addi    r10,r3,-1
                char *tmp = dest;

                while ((*dest++ = *src++) != '\0')
c000000000161410:       01 00 24 8d     lbzu    r9,1(r4)
c000000000161414:       00 00 a9 2f     cmpdi   cr7,r9,0
c000000000161418:       01 00 2a 9d     stbu    r9,1(r10)
c00000000016141c:       f4 ff 9e 40     bne     cr7,c000000000161410
<strcpy+0x8>
                                /* nothing */;
                return tmp;
}

Following are the asm dump for the working and non working binaries which
concluded that the argument for the second strcpy() is not loaded into r3 and
is getting clobbered with the return value of previous strcpy().

Not Working asm dump :

c0000000003308d8:       38 c4 6a f8     std     r3,-15304(r10)
                strcpy(saved_command_line, boot_command_line);
c0000000003308dc:       06 00 62 3c     addis   r3,r2,6
c0000000003308e0:       28 c4 63 e8     ld      r3,-15320(r3)
c0000000003308e4:       25 0b e3 4b     bl      c000000000161408
<strcpy>
c0000000003308e8:       00 00 00 60     nop
                strcpy(static_command_line, command_line);
c0000000003308ec:       78 f3 c4 7f     mr      r4,r30
c0000000003308f0:       19 0b e3 4b     bl      c000000000161408
<strcpy>
c0000000003308f4:       00 00 00 60     nop

Working asm dump :

c0000000003308d4:       38 c4 c3 fb     std     r30,-15304(r3)
        strcpy(saved_command_line, boot_command_line);
c0000000003308d8:       06 00 62 3c     addis   r3,r2,6
c0000000003308dc:       28 c4 63 e8     ld      r3,-15320(r3)
c0000000003308e0:       6d 08 e3 4b     bl      c00000000016114c
<strcpy>
c0000000003308e4:       00 00 00 60     nop
        strcpy(static_command_line, command_line);
c0000000003308e8:       78 eb a4 7f     mr      r4,r29
c0000000003308ec:       78 f3 c3 7f     mr      r3,r30
c0000000003308f0:       5d 08 e3 4b     bl      c00000000016114c
<strcpy>
c0000000003308f4:       00 00 00 60     nop

The problem goes away when compiler optimization is restricted to -O1.

Reported-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 init/main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index a8a58e2..4259c42 100644
--- a/init/main.c
+++ b/init/main.c
@@ -358,7 +358,13 @@ static inline void smp_prepare_cpus(unsigned int maxcpus) { }
  * parsing is performed in place, and we should allow a component to
  * store reference of name/value for future reference.
  */
-static void __init setup_command_line(char *command_line)
+static void __init
+#ifdef CONFIG_PPC64
+	#if  GCC_VERSION > 50301
+		__attribute__((optimize("-O1")))
+	#endif
+#endif
+		setup_command_line(char *command_line)
 {
 	saved_command_line =
 		memblock_virt_alloc(strlen(boot_command_line) + 1, 0);
-- 
2.5.5
