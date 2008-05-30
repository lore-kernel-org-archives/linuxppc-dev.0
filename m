Return-Path: <dgibson@ozlabs.org>
Date: Fri, 30 May 2008 11:34:18 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Add support for binary includes.
Message-ID: <20080530013418.GC26816@yookeroo.seuss>
References: <20080220191941.GA2062@ld0162-tx32.am.freescale.net>
	<20080226003955.GA24382@localhost.localdomain>
	<7BF8FE6B-8BDD-4DC3-953E-E023C38EBA87@kernel.crashing.org>
	<483C4C04.9020408@freescale.com>
	<20080528235859.GA10260@yookeroo.seuss>
	<483EB7ED.2010909@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <483EB7ED.2010909@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org, jdl@jdl.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 29, 2008 at 09:04:29AM -0500, Jon Loeliger wrote:
> David Gibson wrote:
>
>> A while back I sent out a spiel explaining more clearly why I didn't
>> like it, and where I thought we should go with this, but I don't think
>> anyone noticed it at the time.  I'll resend.
>
> Thanks.

Actually realised that spiel was in the same mail as by "I like this
even less" comment - same one I sent a pointer to an archive for.  I'd
been hoping for some kind of response from you.

>> I started working towards a version of this I liked, but was
>> sidetracked by a combination of my own other work, and the fact that
>> Jon's been busy meaning there's a rather large lag on merging dtc
>> patches.
>
> I believe I am fully caught up at this point.

Not quite, this one slipped through the cracks:

dtc: Fix some printf() format warnings when compiling 64-bit

Currently, dtc generates a few gcc build warnings if built for a
64-bit target, due to the altered type of uint64_t and size_t.  This
patch fixes the warnings (without generating new warnings for 32-bit).

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/tests/dtbs_equal_ordered.c
===================================================================
--- dtc.orig/tests/dtbs_equal_ordered.c	2008-05-20 13:06:50.000000000 +1000
+++ dtc/tests/dtbs_equal_ordered.c	2008-05-20 13:07:41.000000000 +1000
@@ -49,7 +49,10 @@ void compare_mem_rsv(const void *fdt1, c
 		if ((addr1 != addr2) || (size1 != size2))
 			FAIL("Mismatch in reserve entry %d: "
 			     "(0x%llx, 0x%llx) != (0x%llx, 0x%llx)", i,
-			     addr1, size1, addr2, size2);
+			     (unsigned long long)addr1,
+			     (unsigned long long)size1,
+			     (unsigned long long)addr2,
+			     (unsigned long long)size2);
 	}
 }
 
Index: dtc/tests/references.c
===================================================================
--- dtc.orig/tests/references.c	2008-05-20 13:05:21.000000000 +1000
+++ dtc/tests/references.c	2008-05-20 13:05:53.000000000 +1000
@@ -38,7 +38,7 @@ void check_ref(const void *fdt, int node
 	if (!p)
 		FAIL("fdt_getprop(%d, \"ref\"): %s", node, fdt_strerror(len));
 	if (len != sizeof(*p))
-		FAIL("'ref' in node at %d has wrong size (%d instead of %d)",
+		FAIL("'ref' in node at %d has wrong size (%d instead of %zd)",
 		     node, len, sizeof(*p));
 	ref = fdt32_to_cpu(*p);
 	if (ref != checkref)
@@ -49,7 +49,7 @@ void check_ref(const void *fdt, int node
 	if (!p)
 		FAIL("fdt_getprop(%d, \"lref\"): %s", node, fdt_strerror(len));
 	if (len != sizeof(*p))
-		FAIL("'lref' in node at %d has wrong size (%d instead of %d)",
+		FAIL("'lref' in node at %d has wrong size (%d instead of %zd)",
 		     node, len, sizeof(*p));
 	ref = fdt32_to_cpu(*p);
 	if (ref != checkref)


-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
