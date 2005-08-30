Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5287F681D6
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Aug 2005 02:50:00 +1000 (EST)
Date: Tue, 30 Aug 2005 09:49:58 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-dev@ozlabs.org
Message-ID: <20050830164958.GD27899@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH] ppc32: export cacheable_memcpy()
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add declaration and cacheable_memcpy(). I'll be needing this 
function in new 4xx EMAC driver I'm going to submit to netdev soon.

IMHO, the better place for the declaration would be 
asm-powerpc/string.h, unfortunately, ppc64 doesn't have this function, 
so asm-ppc/system.h is the next best place.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>
---

 arch/ppc/kernel/ppc_ksyms.c |    1 +
 include/asm-ppc/system.h    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -263,6 +263,7 @@ EXPORT_SYMBOL(__ashrdi3);
 EXPORT_SYMBOL(__ashldi3);
 EXPORT_SYMBOL(__lshrdi3);
 EXPORT_SYMBOL(memcpy);
+EXPORT_SYMBOL(cacheable_memcpy);
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memscan);
diff --git a/include/asm-ppc/system.h b/include/asm-ppc/system.h
--- a/include/asm-ppc/system.h
+++ b/include/asm-ppc/system.h
@@ -84,6 +84,7 @@ extern void cvt_fd(float *from, double *
 extern void cvt_df(double *from, float *to, unsigned long *fpscr);
 extern int call_rtas(const char *, int, int, unsigned long *, ...);
 extern void cacheable_memzero(void *p, unsigned int nb);
+extern void *cacheable_memcpy(void *, const void *, unsigned int);
 extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
 extern void die(const char *, struct pt_regs *, long);
