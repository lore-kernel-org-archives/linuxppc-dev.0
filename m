Return-Path: <paulus@ozlabs.org>
Date: Wed, 14 Nov 2012 19:15:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: jslaby@suse.cz, benh@kernel.crashing.org, anton@samba.org,
 gregkh@linuxfoundation.org, alan@linux.intel.com
Subject: [PATCH] TTY: hvc_console, fix port reference count going to zero
 prematurely
Message-ID: <20121114081547.GA573@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit bdb498c20040 "TTY: hvc_console, add tty install" took the port
refcounting out of hvc_open()/hvc_close(), but failed to remove the
kref_put() and tty_kref_put() calls in hvc_hangup() that were there to
remove the extra references that hvc_open() had taken.

The result was that doing a vhangup() when the current terminal was
a hvc_console, then closing the current terminal, would end up calling
destroy_hvc_struct() and making the port disappear entirely.  This
meant that Fedora 17 systems would boot up but then not display the
login prompt on the console, and attempts to open /dev/hvc0 would
give a "No such device" error.

This fixes it by removing the extra kref_put() and tty_kref_put() calls.

Signed-off-by: Paul Mackerras <paulus@samba.org>
Cc: stable@vger.kernel.org
---
 drivers/tty/hvc/hvc_console.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index a5dec1c..13ee53b 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -424,7 +424,6 @@ static void hvc_hangup(struct tty_struct *tty)
 {
 	struct hvc_struct *hp = tty->driver_data;
 	unsigned long flags;
-	int temp_open_count;
 
 	if (!hp)
 		return;
@@ -444,7 +443,6 @@ static void hvc_hangup(struct tty_struct *tty)
 		return;
 	}
 
-	temp_open_count = hp->port.count;
 	hp->port.count = 0;
 	spin_unlock_irqrestore(&hp->port.lock, flags);
 	tty_port_tty_set(&hp->port, NULL);
@@ -453,11 +451,6 @@ static void hvc_hangup(struct tty_struct *tty)
 
 	if (hp->ops->notifier_hangup)
 		hp->ops->notifier_hangup(hp, hp->data);
-
-	while(temp_open_count) {
-		--temp_open_count;
-		tty_port_put(&hp->port);
-	}
 }
 
 /*
-- 
1.7.10.rc3.219.g53414
