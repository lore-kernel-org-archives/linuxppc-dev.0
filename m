Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7524EDDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 02:22:06 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 235371C00174
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 18:22:02 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 57D239009B
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 18:22:04 +0200 (CEST)
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new,
	port 10024) with ESMTP id rxow9C4uCgPl for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Apr 2009 18:22:03 +0200 (CEST)
Received: from igel.home (DSL01.83.171.182.115.ip-pool.NEFkom.net
	[83.171.182.115]) by mail.mnet-online.de (Postfix) with ESMTP
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 18:22:03 +0200 (CEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: linuxppc-dev@ozlabs.org
Subject: ppc32: Don't clobber personality flags on exec
Date: Thu, 16 Apr 2009 18:22:01 +0200
Message-ID: <m27i1k8t7a.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that ppc32 implements address randomization it also wants to inherit
personality flags like ADDR_NO_RANDOMIZE across exec, for things like
`setarch ppc -R' to work.  But the ppc32 version of SET_PERSONALITY
forcefully sets PER_LINUX, clearing all personality flags.  So be
careful about preserving the flags.

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>

---
 arch/powerpc/include/asm/elf.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.30-rc1/arch/powerpc/include/asm/elf.h
===================================================================
--- linux-2.6.30-rc1.orig/arch/powerpc/include/asm/elf.h	2009-04-08 12:45:56.000000000 +0200
+++ linux-2.6.30-rc1/arch/powerpc/include/asm/elf.h	2009-04-12 14:24:06.000000000 +0200
@@ -258,7 +258,8 @@ do {								\
 # define elf_read_implies_exec(ex, exec_stk) (test_thread_flag(TIF_32BIT) ? \
 		(exec_stk != EXSTACK_DISABLE_X) : 0)
 #else 
-# define SET_PERSONALITY(ex) set_personality(PER_LINUX)
+# define SET_PERSONALITY(ex) \
+  set_personality(PER_LINUX | (current->personality & (~PER_MASK)))
 #endif /* __powerpc64__ */
 
 extern int dcache_bsize;

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
