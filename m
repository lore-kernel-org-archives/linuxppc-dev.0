Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3B3FA67B56
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Sep 2006 06:10:57 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k8JKAsJZ007361
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 16:10:54 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k8JKAsCd344268
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 14:10:54 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k8JKArlV018912
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 14:10:53 -0600
Date: Tue, 19 Sep 2006 15:10:53 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH]: powerpc: clarify use of twi/isync in io macros
Message-ID: <20060919201053.GP29167@austin.ibm.com>
References: <20060919193020.GN29167@austin.ibm.com>
	<72674737-8325-48FA-B04F-C4ADCA2E2BF9@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <72674737-8325-48FA-B04F-C4ADCA2E2BF9@kernel.crashing.org>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 19, 2006 at 09:57:11PM +0200, Segher Boessenkool wrote:
> ..."before the isync has completed, and it won't complete until
> the branch is resolved;"...

New improved patch attched.

> You shouldn't post my test and put your signed-off on it, esp.
> if I forgot to type half a sentence :-)  Here, have one though:

My moral fiber did twinge before I hit the send button,
but I confused it with a muscle spasm.

> Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

--------

Clarify why twi appears in the i/o macros.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

----
 include/asm-powerpc/io.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

Index: linux-2.6.18-rc7-git1/include/asm-powerpc/io.h
===================================================================
--- linux-2.6.18-rc7-git1.orig/include/asm-powerpc/io.h	2006-09-14 13:38:48.000000000 -0500
+++ linux-2.6.18-rc7-git1/include/asm-powerpc/io.h	2006-09-19 15:04:30.000000000 -0500
@@ -278,6 +278,18 @@ static inline void iosync(void)
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
+ * (speculatively) executed before the isync has completed, and
+ * the isync won't complete until the branch is resolved. The
+ * the load that the twi depends on has to complete before
+ * anything else is executed; in particular, it's a barrier to
+ * keep MMIO reads ordered before main-storage accesses.
  */
 static inline int in_8(const volatile unsigned char __iomem *addr)
 {
