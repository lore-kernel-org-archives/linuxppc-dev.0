Return-Path: <clg@fr.ibm.com>
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 168781400F6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 17:48:15 +1000 (EST)
Received: from /spool/local
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 14 Apr 2014 08:48:12 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com
 (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id CEA3A1B08069
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 08:48:11 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s3E7mAVx65667140
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 07:48:10 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s3E7m89w022527
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 01:48:09 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH v2 06/15] powerpc/boot: rework of_claim() to make it 64bit
 friendly
Date: Mon, 14 Apr 2014 09:47:05 +0200
Message-Id: <1397461634-20949-7-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
References: <1397461634-20949-1-git-send-email-clg@fr.ibm.com>
In-Reply-To: <1395651884.30488.10.camel@pasglop>
References: <1395651884.30488.10.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch fixes 64bit compile warnings and updates the wrapper code
to converge the kernel code in prom_init.

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---

Changes since v1:

 - use PROM_ERROR to test return addr

 arch/powerpc/boot/of.c    |    4 ++--
 arch/powerpc/boot/of.h    |    3 ++-
 arch/powerpc/boot/oflib.c |   15 ++++++++-------
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/of.c b/arch/powerpc/boot/of.c
index 62e2f43ec1df..7ca910cb2fc6 100644
--- a/arch/powerpc/boot/of.c
+++ b/arch/powerpc/boot/of.c
@@ -40,8 +40,8 @@ static void *of_try_claim(unsigned long size)
 #ifdef DEBUG
 		printf("    trying: 0x%08lx\n\r", claim_base);
 #endif
-		addr = (unsigned long)of_claim(claim_base, size, 0);
-		if ((void *)addr != (void *)-1)
+		addr = (unsigned long) of_claim(claim_base, size, 0);
+		if (addr != PROM_ERROR)
 			break;
 	}
 	if (addr == 0)
diff --git a/arch/powerpc/boot/of.h b/arch/powerpc/boot/of.h
index 0f058ef69521..504a0a31b685 100644
--- a/arch/powerpc/boot/of.h
+++ b/arch/powerpc/boot/of.h
@@ -6,7 +6,8 @@ typedef void *ihandle;
 
 void of_init(void *promptr);
 int of_call_prom(const char *service, int nargs, int nret, ...);
-void *of_claim(unsigned long virt, unsigned long size, unsigned long align);
+unsigned int of_claim(unsigned long virt, unsigned long size,
+	unsigned long align);
 void *of_vmlinux_alloc(unsigned long size);
 void of_exit(void);
 void *of_finddevice(const char *name);
diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
index 7f61f2eb5653..329437d0e943 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -147,7 +147,8 @@ static int check_of_version(void)
 	return 1;
 }
 
-void *of_claim(unsigned long virt, unsigned long size, unsigned long align)
+unsigned int of_claim(unsigned long virt, unsigned long size,
+		      unsigned long align)
 {
 	int ret;
 	prom_arg_t result;
@@ -155,32 +156,32 @@ void *of_claim(unsigned long virt, unsigned long size, unsigned long align)
 	if (need_map < 0)
 		need_map = check_of_version();
 	if (align || !need_map)
-		return (void *) of_call_prom("claim", 3, 1, virt, size, align);
+		return of_call_prom("claim", 3, 1, virt, size, align);
 
 	ret = of_call_prom_ret("call-method", 5, 2, &result, "claim", memory,
 			       align, size, virt);
 	if (ret != 0 || result == -1)
-		return (void *) -1;
+		return  -1;
 	ret = of_call_prom_ret("call-method", 5, 2, &result, "claim", chosen_mmu,
 			       align, size, virt);
 	/* 0x12 == coherent + read/write */
 	ret = of_call_prom("call-method", 6, 1, "map", chosen_mmu,
 			   0x12, size, virt, virt);
-	return (void *) virt;
+	return virt;
 }
 
 void *of_vmlinux_alloc(unsigned long size)
 {
 	unsigned long start = (unsigned long)_start, end = (unsigned long)_end;
-	void *addr;
+	unsigned long addr;
 	void *p;
 
 	/* With some older POWER4 firmware we need to claim the area the kernel
 	 * will reside in.  Newer firmwares don't need this so we just ignore
 	 * the return value.
 	 */
-	addr = of_claim(start, end - start, 0);
-	printf("Trying to claim from 0x%lx to 0x%lx (0x%lx) got %p\r\n",
+	addr = (unsigned long) of_claim(start, end - start, 0);
+	printf("Trying to claim from 0x%lx to 0x%lx (0x%lx) got %lx\r\n",
 	       start, end, end - start, addr);
 
 	p = malloc(size);
-- 
1.7.10.4
