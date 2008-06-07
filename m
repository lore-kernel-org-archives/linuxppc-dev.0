Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 073B2DDEDD
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Jun 2008 03:57:16 +1000 (EST)
Date: Sat, 7 Jun 2008 21:57:14 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH -mm] watchdog: mpc8xxx_wdt: fix build
Message-ID: <20080607175713.GA27793@polina.dev.rtsoft.ru>
References: <20080602173726.GA24556@polina.dev.rtsoft.ru>
	<20080603164830.32457962.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080603164830.32457962.akpm@linux-foundation.org>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	wim@iguana.be, scottwood@freescale.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  CC      drivers/watchdog/mpc8xxx_wdt.o
drivers/watchdog/mpc8xxx_wdt.c: In function 'mpc8xxx_wdt_ioctl':
drivers/watchdog/mpc8xxx_wdt.c:156: error: 'cmd' undeclared (first use in this function)
drivers/watchdog/mpc8xxx_wdt.c:156: error: (Each undeclared identifier is reported only once
drivers/watchdog/mpc8xxx_wdt.c:156: error: for each function it appears in.)
drivers/watchdog/mpc8xxx_wdt.c: At top level:
drivers/watchdog/mpc8xxx_wdt.c:176: warning: initialization from incompatible pointer type

This patch ought to be folded into
mpc8xxx_wdt-various-renames-mostly-s-mpc83xx-mpc8xxx-g.patch

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Tue, Jun 03, 2008 at 04:48:30PM -0700, Andrew Morton wrote:
> On Mon, 2 Jun 2008 21:37:26 +0400
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > No comments on the previous version for two weeks... resending once
> > again.
> 
> I did all the rework to make the patches apply on top of all the
> pending watchdog work in Wim's tree and in -mm.  I haven't build tested
> it yet.

Well, only one hunk is mis-merged, in
mpc8xxx_wdt-various-renames-mostly-s-mpc83xx-mpc8xxx-g.patch.

Here is the patch to fix it.

I also run-time tested it, everything seem to work great.

p.s. Would be very handy if linux-trees.git would track mmotm snapshots.

 drivers/watchdog/mpc8xxx_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 8b82b91..3c5ed9e 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -142,7 +142,7 @@ static int mpc8xxx_wdt_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static long mpc8xxx_wdt_ioctl(struct inode *inode, struct file *file,
+static long mpc8xxx_wdt_ioctl(struct file *file, unsigned int cmd,
 							unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
-- 
1.5.5.1
