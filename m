Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [194.196.100.161])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 821A4B6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  6 Jul 2011 00:28:52 +1000 (EST)
Received: from d06nrmr1707.portsmouth.uk.ibm.com
	(d06nrmr1707.portsmouth.uk.ibm.com [9.149.39.225])
	by mtagate1.uk.ibm.com (8.13.1/8.13.1) with ESMTP id p65ESkne019013
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2011 14:28:46 GMT
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
	[9.149.37.247])
	by d06nrmr1707.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id p65ESk1N2089010
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2011 15:28:46 +0100
Received: from d06av12.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av12.portsmouth.uk.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with
	ESMTP id p65ESjsg015086
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2011 08:28:45 -0600
Date: Tue, 5 Jul 2011 16:28:44 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC] [PATCH] hvc_console: improve tty/console put_chars handling
Message-ID: <20110705142844.GA2514@linux.vnet.ibm.com>
References: <20110704205738.742e56d0@kryten>
	<1309787787.14501.268.camel@pasglop>
	<20110704142429.GA2147@linux.vnet.ibm.com>
	<CAOZdJXW0Lota0ZuEnOHhsU93v7WmvYztEMyfg+UsMKxFdoXNXQ@mail.gmail.com>
	<1309846963.14501.270.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309846963.14501.270.camel@pasglop>
Cc: "borntraeger@de.ibm.com" <borntraeger@de.ibm.com>,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	Tabi Timur-B04825 <B04825@freescale.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks,

On Tue, Jul 05, 2011 at 04:22:43PM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2011-07-05 at 04:17 +0000, Tabi Timur-B04825 wrote:
> > On Mon, Jul 4, 2011 at 9:24 AM, Hendrik Brueckner
> > <brueckner@linux.vnet.ibm.com> wrote:
> > 
> > I started that thread.  After much soul searching, we came to the
> > conclusion that HVC is not compatible with hypervisors that return
> > BUSY on writes. 
> 
> That is a fun conclusion considering that hvc has been written for the
> pseries hypervisor which ... can return BUSY on writes :-)
> 
> We just need to fix HVC properly.

So I took initiative and looked again into this issue.  Below you can
find a patch that is based on Ben's -EAGAIN idea.  The hvc console layer
takes care of retrying depending on the backend's return code.

However, the main issue is that from a backend perspective, there is no
difference between tty and console output.  Because consoles, especially
the preferred console, behave different than a simple tty.  Blocked write
to a preferred console can stop the system.

So with the patch below, the backend can now indirectly control the way
console output is handled for it.  I still have to think if this solution
is ok or if it is better to introduce a new callback to console output only
(and might provide a default implemenatation similar to the patch below).

NOTE: I did not yet test this patch but will do.. I just want to share it
      early to get feedback from you.

-->8---------------------------------------------------------------------

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
---
 drivers/tty/hvc/hvc_console.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
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
