Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 18 Apr 2006 20:55:29 +0200
Subject: [PATCH] powerpc: Make rtas console _much_ faster
Message-Id: <20060418185534.B1ADF679F0@ozlabs.org>
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently the hvc_rtas driver is painfully slow to use. Our "benchmark" is
ls -R /etc, which spits out about 27866 characters. The theoretical maximum
speed would be about 2.2 seconds, the current code takes ~50 seconds.

The core of the problem is that sometimes when the tty layer asks us to push
characters the firmware isn't able to handle some or all of them, and so
returns an error. The current code sees this and just returns to the tty code
with the buffer half sent.

There's the khvcd thread which will eventually wake up and try to push more
characters, that will usually work because the firmware's had time to push
the characters out. But the thread only wakes up every 10 milliseconds, which
isn't fast enough.

There's already code in the hvc_console driver to make the khvcd thread do
a "quick" loop, where it just calls yield() instead of sleeping. The only code
that triggered that behaviour was recently removed though, which I don't
quite understand.

Still, if we set HVC_POLL_QUICK whenever the push hvc_push() doesn't push all
characters (ie. RTAS blocks), we can get good performance out of the hvc_rtas
backend. With this patch the "benchmark" takes ~2.8 seconds.

I'll test this on P5 LPAR, is there anyone else that uses hvc_console?
Thoughts?

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 drivers/char/hvc_console.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: cell/drivers/char/hvc_console.c
===================================================================
--- cell.orig/drivers/char/hvc_console.c
+++ cell/drivers/char/hvc_console.c
@@ -570,7 +570,7 @@ static int hvc_poll(struct hvc_struct *h
 		hvc_push(hp);
 	/* Reschedule us if still some write pending */
 	if (hp->n_outbuf > 0)
-		poll_mask |= HVC_POLL_WRITE;
+		poll_mask |= HVC_POLL_WRITE | HVC_POLL_QUICK;
 
 	/* No tty attached, just skip */
 	tty = hp->tty;
