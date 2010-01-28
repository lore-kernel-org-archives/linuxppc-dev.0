Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8AEBB7CF8
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jan 2010 19:55:50 +1100 (EST)
In-Reply-To: <20100127170536.23634cdf.akpm@linux-foundation.org>
References: <20100112022150.GE12666@kryten>	<20100112140136.c8ccc357.sfr@canb.auug.org.au>
	<OFF0BABDB9.D573B5F9-ONC12576A9.0041BA69-C12576A9.0041D76A@transmode.se>	<FB3DFBD5-9976-4D03-828A-EB4E6E08DAA4@kernel.crashing.org>
	<1263412963.724.223.camel@pasglop>	<OF20873087.ECC43BEB-ONC12576AB.0029EA9A-C12576AB.002AC5CA@transmode.se>
	<1263459431.724.352.camel@pasglop>	<OF0311C7C7.F02F52A9-ONC12576B6.002D4A11-C12576B6.002DC689@transmode.se>
	<20100127170536.23634cdf.akpm@linux-foundation.org>
Subject: Re: [PATCH]: powerpc: Fix build breakage due to incorrect location of
	autoconf.h
To: Andrew Morton <akpm@linux-foundation.org>
Message-ID: <OF871F5B59.C2574563-ONC12576B9.00300E39-C12576B9.0030C51C@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Thu, 28 Jan 2010 09:52:41 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Roel Kluin <roel.kluin@gmail.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Richard Purdie <rpurdie@rpsys.net>, Anton Blanchard <anton@samba.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrew Morton <akpm@linux-foundation.org> wrote on 2010/01/28 02:05:36:
>
> On Mon, 25 Jan 2010 09:19:59 +0100
> Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>
> > Commit 6846ee5ca68d81e6baccf0d56221d7a00c1be18b made the
> > new optimized inflate only available on arch's that
> > define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS. This
> > fixes it by defining our own endian independent versions
> > of unaligned access.
>
> (I hope I picked up the right version of
> whatever-it-was-i-was-supposed-to-pick-up - I wasn't paying attention).

It was the right one.

>
> The changelog sucks.  You say the patch fixes "it", but what is "it"?
> Is "it" a build error?  If so, what?  Or is "it" a
> make-optimized-inflate-available-on-ppc patch, in which case it's a
> "feature"?

Here is a new version with a somewhat better commit msg and
checkpatch fixes.

   Jocke

BTW, I get duplicate mails from your patch handling tools,
one to Joakim.Tjernlund@transmode.se and one to joakim.tjernlund@transmode.se


>From 612bfb4cc6cc55243c2a4f536ae2ae71065b57b0 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Date: Sun, 24 Jan 2010 11:12:56 +0100
Subject: [PATCH] zlib: Make new optimized inflate endian independent

Commit 6846ee5ca68d81e6baccf0d56221d7a00c1be18b made the
new optimized inflate only available on arch's that
define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS. This
will again enable the optimization for all arch's by
by defining our own endian independent version
of unaligned access. As an added bonus, arch's that
define CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS do a
plain load instead.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
  v2:
    - fix checkpatch complaints.
    - Improve commit msg.

 lib/zlib_inflate/inffast.c |   70 +++++++++++++++++++-------------------------
 1 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
index 215447c..fa62fc7 100644
--- a/lib/zlib_inflate/inffast.c
+++ b/lib/zlib_inflate/inffast.c
@@ -8,21 +8,6 @@
 #include "inflate.h"
 #include "inffast.h"

-/* Only do the unaligned "Faster" variant when
- * CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set
- *
- * On powerpc, it won't be as we don't include autoconf.h
- * automatically for the boot wrapper, which is intended as
- * we run in an environment where we may not be able to deal
- * with (even rare) alignment faults. In addition, we do not
- * define __KERNEL__ for arch/powerpc/boot unlike x86
- */
-
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-#include <asm/unaligned.h>
-#include <asm/byteorder.h>
-#endif
-
 #ifndef ASMINF

 /* Allow machine dependent optimization for post-increment or pre-increment.
@@ -36,14 +21,31 @@
    - Pentium III (Anderson)
    - M68060 (Nikl)
  */
+union uu {
+	unsigned short us;
+	unsigned char b[2];
+};
+
+/* Endian independed version */
+static inline unsigned short
+get_unaligned16(const unsigned short *p)
+{
+	union uu  mm;
+	unsigned char *b = (unsigned char *)p;
+
+	mm.b[0] = b[0];
+	mm.b[1] = b[1];
+	return mm.us;
+}
+
 #ifdef POSTINC
 #  define OFF 0
 #  define PUP(a) *(a)++
-#  define UP_UNALIGNED(a) get_unaligned((a)++)
+#  define UP_UNALIGNED(a) get_unaligned16((a)++)
 #else
 #  define OFF 1
 #  define PUP(a) *++(a)
-#  define UP_UNALIGNED(a) get_unaligned(++(a))
+#  define UP_UNALIGNED(a) get_unaligned16(++(a))
 #endif

 /*
@@ -256,7 +258,6 @@ void inflate_fast(z_streamp strm, unsigned start)
                     }
                 }
                 else {
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
 		    unsigned short *sout;
 		    unsigned long loops;

@@ -274,7 +275,11 @@ void inflate_fast(z_streamp strm, unsigned start)
 			sfrom = (unsigned short *)(from - OFF);
 			loops = len >> 1;
 			do
+#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
+			    PUP(sout) = PUP(sfrom);
+#else
 			    PUP(sout) = UP_UNALIGNED(sfrom);
+#endif
 			while (--loops);
 			out = (unsigned char *)sout + OFF;
 			from = (unsigned char *)sfrom + OFF;
@@ -282,14 +287,13 @@ void inflate_fast(z_streamp strm, unsigned start)
 			unsigned short pat16;

 			pat16 = *(sout-2+2*OFF);
-			if (dist == 1)
-#if defined(__BIG_ENDIAN)
-			    pat16 = (pat16 & 0xff) | ((pat16 & 0xff) << 8);
-#elif defined(__LITTLE_ENDIAN)
-			    pat16 = (pat16 & 0xff00) | ((pat16 & 0xff00) >> 8);
-#else
-#error __BIG_ENDIAN nor __LITTLE_ENDIAN is defined
-#endif
+			if (dist == 1) {
+				union uu mm;
+				/* copy one char pattern to both bytes */
+				mm.us = pat16;
+				mm.b[0] = mm.b[1];
+				pat16 = mm.us;
+			}
 			loops = len >> 1;
 			do
 			    PUP(sout) = pat16;
@@ -298,20 +302,6 @@ void inflate_fast(z_streamp strm, unsigned start)
 		    }
 		    if (len & 1)
 			PUP(out) = PUP(from);
-#else /* CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
-                    from = out - dist;          /* copy direct from output */
-                    do {                        /* minimum length is three */
-			 PUP(out) = PUP(from);
-			 PUP(out) = PUP(from);
-			 PUP(out) = PUP(from);
-			 len -= 3;
-                    } while (len > 2);
-                    if (len) {
-			 PUP(out) = PUP(from);
-			 if (len > 1)
-			     PUP(out) = PUP(from);
-                    }
-#endif /* !CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS */
                 }
             }
             else if ((op & 64) == 0) {          /* 2nd level distance code */
--
1.6.4.4
