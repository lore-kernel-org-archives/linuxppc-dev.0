Return-Path: <rashika.kheria@gmail.com>
Received: from mail-pb0-x22e.google.com (mail-pb0-x22e.google.com
 [IPv6:2607:f8b0:400e:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AE2452C00AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 22:01:47 +1100 (EST)
Received: by mail-pb0-f46.google.com with SMTP id md12so5343416pbc.33
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Dec 2013 03:01:39 -0800 (PST)
Date: Mon, 16 Dec 2013 16:31:28 +0530
From: Rashika Kheria <rashika.kheria@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drivers: tty: Mark the function hvc_poll_init() as
 static in hvc_console.c
Message-ID: <0dc41f5b30bf9b5c94e658387ffaf092736c26b2.1387191158.git.rashika.kheria@gmail.com>
References: <0d40902c95942d272a70b1d85b4e311d0cc7afa4.1387191158.git.rashika.kheria@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <0d40902c95942d272a70b1d85b4e311d0cc7afa4.1387191158.git.rashika.kheria@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, josh@joshtriplett.org,
 Rashika Kheria <rashika.kheria@gmail.com>,
 Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Slaby <jslaby@suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark the function hvc_poll_init() as static in hvc/hvc_console.c because
it is not used outside this file.

This eliminates the following warning in hvc/hvc_console.c:
drivers/tty/hvc/hvc_console.c:791:5: warning: no previous prototype for ‘hvc_poll_init’ [-Wmissing-prototypes]

Signed-off-by: Rashika Kheria <rashika.kheria@gmail.com>
---
 drivers/tty/hvc/hvc_console.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 9eba119..50b4688 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -788,7 +788,7 @@ static int hvc_tiocmset(struct tty_struct *tty,
 }
 
 #ifdef CONFIG_CONSOLE_POLL
-int hvc_poll_init(struct tty_driver *driver, int line, char *options)
+static int hvc_poll_init(struct tty_driver *driver, int line, char *options)
 {
 	return 0;
 }
-- 
1.7.9.5
