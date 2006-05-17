Return-Path: <xenidis@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.231])
	by ozlabs.org (Postfix) with ESMTP id DBB10679FB
	for <linuxppc-dev@ozlabs.org>; Thu, 18 May 2006 01:11:11 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i4so246712wra
	for <linuxppc-dev@ozlabs.org>; Wed, 17 May 2006 08:11:10 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v750)
Message-Id: <4025245D-6BAB-41D3-ADB6-2748741F223E@watson.ibm.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-dev@ozlabs.org
Subject: [patch] udb_printf() formatting attribute
Date: Wed, 17 May 2006 11:04:56 -0400
From: Jimi Xenidis <jimix@pobox.com>
Sender: Jimi Xenidis <xenidis@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch allows the compiler to catch any printf-like mismatches  
for udbg_printf().
After some brute force building I've only found issues with my own  
code and lparcfg.c
It could break some developers, but IMHO that would be goodness.

Signed-off-by: Jimi Xenidis <jimix@watson.ibm.com>
---
diff -r 0163968f7fce arch/powerpc/kernel/lparcfg.c
--- a/arch/powerpc/kernel/lparcfg.c	Tue May 16 15:55:19 2006 -0400
+++ b/arch/powerpc/kernel/lparcfg.c	Wed May 17 10:43:55 2006 -0400
@@ -521,10 +521,10 @@ static ssize_t lparcfg_write(struct file
	current_weight = (resource >> 5 * 8) & 0xFF;
-	pr_debug("%s: current_entitled = %lu, current_weight = %lu\n",
+	pr_debug("%s: current_entitled = %lu, current_weight = %u\n",
		 __FUNCTION__, current_entitled, current_weight);
-	pr_debug("%s: new_entitled = %lu, new_weight = %lu\n",
+	pr_debug("%s: new_entitled = %lu, new_weight = %u\n",
		 __FUNCTION__, *new_entitled_ptr, *new_weight_ptr);
	retval = plpar_hcall_norets(H_SET_PPP, *new_entitled_ptr,
diff -r 0163968f7fce include/asm-powerpc/udbg.h
--- a/include/asm-powerpc/udbg.h	Tue May 16 15:55:19 2006 -0400
+++ b/include/asm-powerpc/udbg.h	Wed May 17 10:43:55 2006 -0400
@@ -23,7 +23,8 @@ extern int udbg_read(char *buf, int bufl
extern int udbg_read(char *buf, int buflen);
extern void register_early_udbg_console(void);
-extern void udbg_printf(const char *fmt, ...);
+extern void udbg_printf(const char *fmt, ...)
+	__attribute__ ((format (printf, 1, 2)));
extern void udbg_progress(char *s, unsigned short hex);
extern void udbg_init_uart(void __iomem *comport, unsigned int speed,
