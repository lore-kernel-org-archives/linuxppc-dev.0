Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 666F2B71A3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 22 Jun 2009 18:04:24 +1000 (EST)
Date: Mon, 22 Jun 2009 18:04:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Linus <torvalds@linux-foundation.org>
Subject: [PATCH] fbdev: work around old compiler bug
Message-Id: <20090622180420.2e0424e4.sfr@canb.auug.org.au>
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
 scripts/pnmtologo.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/scripts/pnmtologo.c b/scripts/pnmtologo.c
index 64f5ddb..d10c389 100644
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
 
-- 
1.6.3.1


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
