Return-Path: <g.jaeger@sysgo.com>
Received: from mailgate.sysgo.de (ns.sysgo.de [213.68.67.98])
	by ozlabs.org (Postfix) with ESMTP id 99A452BDA1
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2004 23:53:23 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mailgate.sysgo.de (Postfix) with ESMTP id 9FE3947B82
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2004 15:26:24 +0200 (CEST)
Received: from donald.sysgo.com (unknown [172.20.1.30])
	by mailgate.sysgo.de (Postfix) with ESMTP id 8776347B82
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2004 15:26:24 +0200 (CEST)
Received: from kah.ulm.sysgo.com (firewall.sysgo.com [172.20.1.35])
	by donald.sysgo.com (Postfix) with ESMTP id 61C15C2BDE
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Oct 2004 15:29:13 +0200 (CEST)
Received: from gja.ulm.sysgo.com (gja.ulm.sysgo.com [172.40.1.130])
	by kah.ulm.sysgo.com (8.9.3/8.8.8) with ESMTP id PAA29053
	for <linuxppc-dev@ozlabs.org>; Thu, 7 Oct 2004 15:30:30 +0200
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Date: Thu, 7 Oct 2004 15:29:12 +0200
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oSUZBQ2BN7iT8dO"
Message-Id: <200410071529.12909.g.jaeger@sysgo.com>
Subject: [BUG][PPC32] Preemption patch for 2.4 Kernels
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Boundary-00=_oSUZBQ2BN7iT8dO
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Robert,

maybe the 2.4 series is somewhat outdatet, but nevertheless used in
several embedded systems and also with your preemption patches.
During some investigations, we found out that the patches found on 
http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/
contain a severe bug, when using the patches on PPC systems. 
The affected function is get_pgd_fast() which is buried in
include/asm-ppc/pgalloc.h

While the original function looks like:
extern __inline__ pgd_t *get_pgd_fast(void)
{
        unsigned long *ret;

        if ((ret = pgd_quicklist) != NULL) {
                pgd_quicklist = (unsigned long *)(*ret);
                ret[0] = 0;
                pgtable_cache_size--;
        } else
                ret = (unsigned long *)get_pgd_slow();
        return (pgd_t *)ret;
}

the patched one is:
extern __inline__ pgd_t *get_pgd_fast(void)
{
        unsigned long *ret;

        preempt_disable();
        if ((ret = pgd_quicklist) != NULL) {
                pgd_quicklist = (unsigned long *)(*ret);
                ret[0] = 0;
                pgtable_cache_size--;
                preempt_enable();
        } else 
                preempt_enable();
                ret = (unsigned long *)get_pgd_slow();
        return (pgd_t *)ret;
}

And exactly the "else" path causes the problems ;) I guess it should be

       } else {
                preempt_enable();
                ret = (unsigned long *)get_pgd_slow();
       }

The attached patch will do it the right way, and you might want to correct
the patches on your web-space.

Best regards,
  Gerhard Jaeger

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com

--Boundary-00=_oSUZBQ2BN7iT8dO
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="pgalloc.h.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pgalloc.h.diff"

--- pgalloc.h.orig	2003-11-28 19:26:21.000000000 +0100
+++ pgalloc.h	2004-10-07 14:41:28.000000000 +0200
@@ -72,20 +72,26 @@ extern __inline__ pgd_t *get_pgd_fast(vo
 {
         unsigned long *ret;
 
+	preempt_disable();
         if ((ret = pgd_quicklist) != NULL) {
                 pgd_quicklist = (unsigned long *)(*ret);
                 ret[0] = 0;
                 pgtable_cache_size--;
-        } else
+		preempt_enable();
+        } else {
+		preempt_enable();
                 ret = (unsigned long *)get_pgd_slow();
+        }
         return (pgd_t *)ret;
 }
 
 extern __inline__ void free_pgd_fast(pgd_t *pgd)
 {
+	preempt_disable();
         *(unsigned long **)pgd = pgd_quicklist;
         pgd_quicklist = (unsigned long *) pgd;
         pgtable_cache_size++;
+	preempt_enable();
 }
 
 extern __inline__ void free_pgd_slow(pgd_t *pgd)
@@ -124,19 +130,23 @@ static inline pte_t *pte_alloc_one_fast(
 {
         unsigned long *ret;
 
+	preempt_disable();
         if ((ret = pte_quicklist) != NULL) {
                 pte_quicklist = (unsigned long *)(*ret);
                 ret[0] = 0;
                 pgtable_cache_size--;
 	}
+	preempt_enable();
         return (pte_t *)ret;
 }
 
 extern __inline__ void pte_free_fast(pte_t *pte)
 {
+	preempt_disable();
         *(unsigned long **)pte = pte_quicklist;
         pte_quicklist = (unsigned long *) pte;
         pgtable_cache_size++;
+	preempt_enable();
 }
 
 extern __inline__ void pte_free_slow(pte_t *pte)

--Boundary-00=_oSUZBQ2BN7iT8dO--
