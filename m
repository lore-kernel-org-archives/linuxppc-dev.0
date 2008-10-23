Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E2795DDF04
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 17:29:42 +1100 (EST)
Date: Thu, 23 Oct 2008 17:29:38 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: linux-next: ttydev tree build failure
Message-Id: <20081023172938.0460b191.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-next@vger.kernel.org,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Alan,

Today's linux-next build (powerpc ppc64_defconfig) failed like this:

drivers/char/hvc_console.c: In function 'hvc_set_winsz':
drivers/char/hvc_console.c:532: warning: passing argument 2 of 'tty_do_resize' from incompatible pointer type
drivers/char/hvc_console.c:532: error: too many arguments to function 'tty_do_resize'

Caused by commit eb6ab2d361a49470ca9785c70482772c19e49bec
("pty-simplify-resize") from the ttydev tree interacting with commit
febde3711992a64ea83a47a719f68a90c4b0927a ("hvc_console: Add support for
tty window resizing").

The former added another call to the function that the latter changed.

I applied the following patch.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 23 Oct 2008 17:26:51 +1100
Subject: [PATCH] hvc_console: fallout from tty_do_resize change

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/hvc_console.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index 5b819b1..65f88ef 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -529,7 +529,7 @@ static void hvc_set_winsz(struct work_struct *work)
 	tty = tty_kref_get(hp->tty);
 	spin_unlock_irqrestore(&hp->lock, hvc_flags);
 
-	tty_do_resize(tty, tty, &ws);
+	tty_do_resize(tty, &ws);
 	tty_kref_put(tty);
 }
 
-- 
1.5.6.5
