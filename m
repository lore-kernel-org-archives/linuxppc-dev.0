Return-Path: <anton@samba.org>
Date: Wed, 6 Jul 2011 17:50:18 +1000
From: Anton Blanchard <anton@samba.org>
To: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH 1/2]: hvc_console: improve tty/console put_chars handling
Message-ID: <20110706175018.0c85873b@kryten>
In-Reply-To: <20110705142844.GA2514@linux.vnet.ibm.com>
References: <20110704205738.742e56d0@kryten>
	<1309787787.14501.268.camel@pasglop>
	<20110704142429.GA2147@linux.vnet.ibm.com>
	<CAOZdJXW0Lota0ZuEnOHhsU93v7WmvYztEMyfg+UsMKxFdoXNXQ@mail.gmail.com>
	<1309846963.14501.270.camel@pasglop>
	<20110705142844.GA2514@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Tabi Timur-B04825 <B04825@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"borntraeger@de.ibm.com" <borntraeger@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

Currently, the hvc_console_print() function drops console output if the
hvc backend's put_chars() returns 0.  This patch changes this behavior
to allow a retry through returning -EAGAIN.

This change also affects the hvc_push() function.  Both functions are
changed to handle -EAGAIN and to retry the put_chars() operation.

If a hvc backend returns -EAGAIN, the retry handling differs:

  - hvc_console_print() spins to write the complete console output.
  - hvc_push() behaves the same way as for returning 0.

Now hvc backends can indirectly control the way how console output is
handled through the hvc console layer.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Acked-by: Anton Blanchard <anton@samba.org>
Cc: <stable@kernel.org>
---

Index: linux-powerpc/drivers/tty/hvc/hvc_console.c
===================================================================
--- linux-powerpc.orig/drivers/tty/hvc/hvc_console.c	2011-07-06 17:10:51.288360541 +1000
+++ linux-powerpc/drivers/tty/hvc/hvc_console.c	2011-07-06 17:11:16.398794913 +1000
@@ -163,8 +163,10 @@ static void hvc_console_print(struct con
 		} else {
 			r = cons_ops[index]->put_chars(vtermnos[index], c, i);
 			if (r <= 0) {
-				/* throw away chars on error */
-				i = 0;
+				/* throw away characters on error
+				 * but spin in case of -EAGAIN */
+				if (r != -EAGAIN)
+					i = 0;
 			} else if (r > 0) {
 				i -= r;
 				if (i > 0)
@@ -448,7 +450,7 @@ static int hvc_push(struct hvc_struct *h
 
 	n = hp->ops->put_chars(hp->vtermno, hp->outbuf, hp->n_outbuf);
 	if (n <= 0) {
-		if (n == 0) {
+		if (n == 0 || n == -EAGAIN) {
 			hp->do_wakeup = 1;
 			return 0;
 		}
