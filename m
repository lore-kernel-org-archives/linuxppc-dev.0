Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E3D3467C5A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 09:22:57 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id kB6MMrOO027264
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 17:22:53 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	kB6MMqZj537438
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 15:22:52 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	kB6MMq68009518
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Dec 2006 15:22:52 -0700
Date: Wed, 6 Dec 2006 16:22:47 -0600
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>, paulus@samba.org
Subject: Re: [PATCH]: powerpc documentation: Clarify why twi appears in the
	i/o	macros.
Message-ID: <20061206222246.GG17931@austin.ibm.com>
References: <20061206182922.GA17931@austin.ibm.com>
	<45770E44.30000@ru.mvista.com>
	<20061206194516.GD17931@austin.ibm.com>
	<45772700.2080708@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45772700.2080708@ru.mvista.com>
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

Please apply.

On Wed, Dec 06, 2006 at 11:24:32PM +0300, Sergei Shtylyov wrote:
> >>  A minor type here -- double "the".
>    And here as well. :-)

I forgot to say "quilt refresh" !? My quality control mechanism
broke.

So again ... 

--linas

Clarify why twi appears in the i/o macros. Shorten some over-length
lines, while we're at it.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>

----
 include/asm-powerpc/io.h |   33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

Index: linux-2.6.19-git7/include/asm-powerpc/io.h
===================================================================
--- linux-2.6.19-git7.orig/include/asm-powerpc/io.h	2006-12-06 16:11:31.000000000 -0600
+++ linux-2.6.19-git7/include/asm-powerpc/io.h	2006-12-06 16:19:40.000000000 -0600
@@ -62,22 +62,33 @@ extern unsigned long pci_dram_offset;
  *
  * Low level MMIO accessors
  *
- * This provides the non-bus specific accessors to MMIO. Those are PowerPC
- * specific and thus shouldn't be used in generic code. The accessors
- * provided here are:
+ * This provides the non-bus specific accessors to MMIO. Those are 
+ * PowerPC specific and thus shouldn't be used in generic code. The 
+ * accessors provided here are:
  *
  *	in_8, in_le16, in_be16, in_le32, in_be32, in_le64, in_be64
  *	out_8, out_le16, out_be16, out_le32, out_be32, out_le64, out_be64
  *	_insb, _insw_ns, _insl_ns, _outsb, _outsw_ns, _outsl_ns
  *
- * Those operate directly on a kernel virtual address. Note that the prototype
- * for the out_* accessors has the arguments in opposite order from the usual
- * linux PCI accessors. Unlike those, they take the address first and the value
- * next.
- *
- * Note: I might drop the _ns suffix on the stream operations soon as it is
- * simply normal for stream operations to not swap in the first place.
- *
+ * Those operate directly on a kernel virtual address. Note that the 
+ * prototype for the out_* accessors has the arguments in opposite 
+ * order from the usual linux PCI accessors. Unlike those, they take 
+ * the address first and the value next.
+ *
+ * Note: I might drop the _ns suffix on the stream operations soon as it
+ * is simply normal for stream operations to not swap in the first place.
+ *
+ * Read operations have additional twi & isync to make sure the read
+ * is actually performed (i.e. the data has come back) before we start
+ * executing any following instructions.
+ *
+ * A data-dependent branch followed by an isync ensures that no
+ * instructions after the isync in program order will be 
+ * (speculatively) executed before the isync has completed, and the 
+ * isync won't complete until the branch is resolved. The load that 
+ * the twi depends on has to complete before anything else is 
+ * executed; in particular, it's a barrier to keep MMIO reads ordered 
+ * before main-storage accesses.
  */
 
 #ifdef CONFIG_PPC64
