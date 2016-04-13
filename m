Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlDnH6WTLzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Apr 2016 16:44:51 +1000 (AEST)
Date: Wed, 13 Apr 2016 09:44:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anton Blanchard <anton@samba.org>
Cc: Jiri Slaby <jslaby@suse.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Peter Hurley <peter@hurleysoftware.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] tty: hvc_console: silence unintialized variable warning
Message-ID: <20160413064431.GF8092@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If ->get_char() returns a negative error code and that can mean that
"ch" is uninitialized.  The callers of this function expect NO_POLL_CHAR
on error so let's return that.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index e46d628..325747a 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -814,7 +814,7 @@ static int hvc_poll_get_char(struct tty_driver *driver, int line)
 
 	n = hp->ops->get_chars(hp->vtermno, &ch, 1);
 
-	if (n == 0)
+	if (n <= 0)
 		return NO_POLL_CHAR;
 
 	return ch;
