Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id D604ADDE1C
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 08:38:40 +1000 (EST)
Received: from pd3mr4so.prod.shaw.ca
	(pd3mr4so-qfe3.prod.shaw.ca [10.0.141.180]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JQC005JX487G4C0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 22 Oct 2007 16:38:31 -0600 (MDT)
Received: from pn2ml6so.prod.shaw.ca ([10.0.121.150])
	by pd3mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JQC0036F487XI40@pd3mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 22 Oct 2007 16:38:31 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JQC00JO9486DNA0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 22 Oct 2007 16:38:30 -0600 (MDT)
Date: Mon, 22 Oct 2007 16:38:32 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] Bugfix to commit 4f9a58d75bfe82ab2b8ba5b8506dfb190a267834
To: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Message-id: <20071022223737.21679.23812.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Commit 4f9a58d75bfe82ab2b8ba5b8506dfb190a267834 changes the size of
AT_VECTOR_SIZE from hard coded '44' to a calculation based on the value
of AT_VECTOR_SIZE_ARCH and AT_VECTOR_SIZE_BASE.  The change works for
arch/powerpc, but it breaks arch/ppc because the needed
AT_VECTOR_SIZE_ARCH is not present in include/asm-ppc/system.h and a
default value of 0 is used instead.  This results in AT_VECTOR_SIZE
being too small and it causes a kernel crash on loading init.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

I think this bug fix needs to go in ASAP.  I cannot boot my Virtex ppc405
platform without it.

Olaf, do I have the correct solution here?

Thanks,
g.

 include/asm-ppc/system.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/asm-ppc/system.h b/include/asm-ppc/system.h
index cc45780..51df94c 100644
--- a/include/asm-ppc/system.h
+++ b/include/asm-ppc/system.h
@@ -33,6 +33,7 @@
 
 #define set_mb(var, value)	do { var = value; mb(); } while (0)
 
+#define AT_VECTOR_SIZE_ARCH 6 /* entries in ARCH_DLINFO */
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()
 #define smp_rmb()	rmb()
