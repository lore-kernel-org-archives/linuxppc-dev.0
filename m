Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 22906DDEAB
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 21:16:21 +1000 (EST)
Subject: Re: random code execution - kernel oops
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <1182171859.21013.3.camel@johannes.berg>
References: <1182171859.21013.3.camel@johannes.berg>
Content-Type: text/plain
Date: Tue, 19 Jun 2007 18:06:52 +0200
Message-Id: <1182269212.3714.1.camel@johannes.berg>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-18 at 15:04 +0200, Johannes Berg wrote:
> unsigned long hx = 0x4bfcc50c;
> int main()
> {
>   asm("bl hx");
> }

The net result of which is trying to execute code in a region without
access permissions.

Segher dug into the problem and suggested the patch below which does
indeed fix the problem:

---
 arch/powerpc/mm/fault.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- wireless-dev.orig/arch/powerpc/mm/fault.c	2007-06-19 16:12:16.080612233 +0200
+++ wireless-dev/arch/powerpc/mm/fault.c	2007-06-19 16:12:27.480612233 +0200
@@ -279,14 +279,13 @@ good_area:
 #endif /* CONFIG_8xx */
 
 	if (is_exec) {
-#ifdef CONFIG_PPC64
+#if !(defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 		/* protection fault */
 		if (error_code & DSISR_PROTFAULT)
 			goto bad_area;
 		if (!(vma->vm_flags & VM_EXEC))
 			goto bad_area;
-#endif
-#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#else
 		pte_t *ptep;
 		pmd_t *pmdp;
 
