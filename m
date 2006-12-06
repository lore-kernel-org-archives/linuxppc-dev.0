Return-Path: <linas@austin.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E80667BEB
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 05:29:57 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6ITsNg003013
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 13:29:54 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6ITiGa186996
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 13:29:44 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6IThBR021302
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 13:29:44 -0500
Date: Wed, 6 Dec 2006 12:29:22 -0600
To: paulus@samba.org
Subject: [PATCH]: powerpc documentation: Clarify why twi appears in the i/o
	macros.
Message-ID: <20061206182922.GA17931@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul,
Please apply. This atch resulted from an email discussion
back in Sept.

--linas

Clarify why twi appears in the i/o macros.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

----
 include/asm-powerpc/io.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-2.6.19-git7/include/asm-powerpc/io.h
===================================================================
--- linux-2.6.19-git7.orig/include/asm-powerpc/io.h	2006-12-05 17:11:02.000000000 -0600
+++ linux-2.6.19-git7/include/asm-powerpc/io.h	2006-12-06 11:48:43.000000000 -0600
@@ -78,6 +78,17 @@ extern unsigned long pci_dram_offset;
  * Note: I might drop the _ns suffix on the stream operations soon as it is
  * simply normal for stream operations to not swap in the first place.
  *
+ * Read operations have additional twi & isync to make sure the read
+ * is actually performed (i.e. the data has come back) before we start
+ * executing any following instructions.
+ *
+ * A data-dependent branch followed by an isync ensures that no
+ * instructions after the isync in program order will be
+ * (speculatively) executed before the isync has completed, and
+ * the isync won't complete until the branch is resolved. The
+ * the load that the twi depends on has to complete before
+ * anything else is executed; in particular, it's a barrier to
+ * keep MMIO reads ordered before main-storage accesses.
  */
 
 #ifdef CONFIG_PPC64
