Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 08850B7112
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 23 Jun 2009 15:44:31 +1000 (EST)
Date: Tue, 23 Jun 2009 15:44:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@linux-foundation.org>
Subject: [PATCH v2] fbdev: work around old compiler bug
Message-Id: <20090623154428.e2f4ddc9.sfr@canb.auug.org.au>
In-Reply-To: <20090622183415.46fa786b.sfr@canb.auug.org.au>
References: <20090622180420.2e0424e4.sfr@canb.auug.org.au>
	<20090622183415.46fa786b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: James Simmons <jsimmons@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Krzysztof Helt <krzysztof.h1@poczta.fm>,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When building with a 4.1.x compiler on powerpc64 (at least) we get
this error:

drivers/video/logo/logo_linux_mono.c:81: error: logo_linux_mono causes a section type conflict

This was introduced by commit ae52bb2384f721562f15f719de1acb8e934733cb
("fbdev: move logo externs to header file").  This is a partial revert
of that commit sufficient to not hit the compiler bug.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 scripts/pnmtologo.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

v2: also convert _clut arrays from __initconst to __initdata.

diff --git a/scripts/pnmtologo.c b/scripts/pnmtologo.c
index 64f5ddb..5c11312 100644
--- a/scripts/pnmtologo.c
+++ b/scripts/pnmtologo.c
@@ -237,7 +237,7 @@ static void write_header(void)
     fprintf(out, " *  Linux logo %s\n", logoname);
     fputs(" */\n\n", out);
     fputs("#include <linux/linux_logo.h>\n\n", out);
-    fprintf(out, "static const unsigned char %s_data[] __initconst = {\n",
+    fprintf(out, "static unsigned char %s_data[] __initdata = {\n",
 	    logoname);
 }
 
@@ -374,7 +374,7 @@ static void write_logo_clut224(void)
     fputs("\n};\n\n", out);
 
     /* write logo clut */
-    fprintf(out, "static const unsigned char %s_clut[] __initconst = {\n",
+    fprintf(out, "static unsigned char %s_clut[] __initdata = {\n",
 	    logoname);
     write_hex_cnt = 0;
     for (i = 0; i < logo_clutsize; i++) {
-- 
1.6.3.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
