Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id B2D85DDDF8
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 14:31:16 +1000 (EST)
Date: Tue, 21 Aug 2007 14:30:59 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Check for PPC32 in imsttfb
Message-Id: <20070821143059.1ccc7f4b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-fbdev-devel@lists.sourceforge.net,
	"Antonino A. Daplas" <adaplas@gmail.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org,
	lethal@chaoticdreams.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/video/imsttfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

This is the correct fix according to Paul Mackerras and allows an
allyesconfig on PPC64 to build.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index 5715b8a..94f4511 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -1391,7 +1391,7 @@ init_imstt(struct fb_info *info)
 		}
 	}
 
-#if USE_NV_MODES && defined(CONFIG_PPC)
+#if USE_NV_MODES && defined(CONFIG_PPC32)
 	{
 		int vmode = init_vmode, cmode = init_cmode;
 
-- 
1.5.2.4
