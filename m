Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C5941A0806
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 10:06:49 +1100 (AEDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linux-kernel@vger.kernel.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Thierry Reding
 <thierry.reding@gmail.com>,
 <linux-serial@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] tty: disable unbind for old 74xx based serial/mpsc console
 port
Date: Tue, 13 Oct 2015 19:06:30 -0400
Message-ID: <1444777590-15674-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We recently got rid of some modular code in this driver and also
got rid of the unused ".remove" function at the same time.  Thierry
noted that it was however possible to force the remove through the
bind/unbind interface.

Since this is a console device used on 2005 vintage 74xx based
powerpc embedded targets, and is essentially always used in
conjunction with SERIAL_MPSC_CONSOLE=y -- there is no sane reason
anyone would ever want to unbind the builtin driver and lose the
console.  So we just explicitly block bind/unbind operations and
prevent root from shooting themselves in the foot.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-serial@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/tty/serial/mpsc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mpsc.c b/drivers/tty/serial/mpsc.c
index 2f43a58cb392..cadfd1cfae2b 100644
--- a/drivers/tty/serial/mpsc.c
+++ b/drivers/tty/serial/mpsc.c
@@ -2109,7 +2109,8 @@ static int mpsc_drv_probe(struct platform_device *dev)
 static struct platform_driver mpsc_driver = {
 	.probe	= mpsc_drv_probe,
 	.driver	= {
-		.name	= MPSC_CTLR_NAME,
+		.name			= MPSC_CTLR_NAME,
+		.suppress_bind_attrs	= true,
 	},
 };
 
-- 
2.6.1
