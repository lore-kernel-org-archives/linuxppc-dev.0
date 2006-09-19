Return-Path: <linas@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 943BE67B5A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 05:30:24 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8JJULMe009080
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 15:30:21 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8JJULUi206758
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 13:30:21 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8JJUKO9008703
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 13:30:21 -0600
Date: Tue, 19 Sep 2006 14:30:20 -0500
To: paulus@samba.org
Subject: [PATCH]: powerpc: clarify use of twi/isync in io macros
Message-ID: <20060919193020.GN29167@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Paul, please apply.

Clarify why twi appears in the i/o macros.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>

----
 include/asm-powerpc/io.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-2.6.18-rc7-git1/include/asm-powerpc/io.h
===================================================================
--- linux-2.6.18-rc7-git1.orig/include/asm-powerpc/io.h	2006-09-14 13:38:48.000000000 -0500
+++ linux-2.6.18-rc7-git1/include/asm-powerpc/io.h	2006-09-19 14:26:26.000000000 -0500
@@ -278,6 +278,17 @@ static inline void iosync(void)
  * These routines do not perform EEH-related I/O address translation,
  * and should not be used directly by device drivers.  Use inb/readb
  * instead.
+ *
+ * Read operations have additional twi & isync to make sure the read
+ * is actually performed (i.e. the data has come back) before we start
+ * executing any following instructions.
+ *
+ * A data-dependent branch followed by an isync ensures that no
+ * instructions after the isync in program order will be
+ * (speculatively) executed, so the load that the twi depends
+ * on has to complete before anything else is executed; in
+ * particular, it's a barrier to keep MMIO reads ordered before
+ * main-storage accesses.
  */
 static inline int in_8(const volatile unsigned char __iomem *addr)
 {
