Return-Path: <npiggin@gmail.com>
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 424qX26s85zF373
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 13:52:02 +1000 (AEST)
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so2748768pfo.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Sep 2018 20:52:02 -0700 (PDT)
Date: Wed, 5 Sep 2018 13:51:56 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>
Subject: Re: Regression from patch 'tty: hvc: hvc_poll() break hv read loop'
Message-ID: <20180905135156.7ac7727b@roar.ozlabs.ibm.com>
In-Reply-To: <20180904211635.GD335@mellanox.com>
References: <20180904174808.GS335@mellanox.com>
 <20180905071529.3b7a09c4@roar.ozlabs.ibm.com>
 <20180904211635.GD335@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 4 Sep 2018 15:16:35 -0600
Jason Gunthorpe <jgg@mellanox.com> wrote:

> On Wed, Sep 05, 2018 at 07:15:29AM +1000, Nicholas Piggin wrote:
> > On Tue, 4 Sep 2018 11:48:08 -0600
> > Jason Gunthorpe <jgg@mellanox.com> wrote:
> >   
> > > Hi Nicholas,
> > > 
> > > I am testing 4.19-rc2 and I see bad behavior with my qemu hvc0
> > > console..
> > > 
> > > Running interactive with qemu (qemu-2.11.2-1.fc28) on the console
> > > providing hvc0, using options like:
> > > 
> > >         -nographic
> > >         -chardev stdio,id=stdio,mux=on,signal=off
> > >         -mon chardev=stdio
> > > 	-device isa-serial,chardev=stdio
> > >         -device virtio-serial-pci
> > > 	-device virtconsole,chardev=stdio
> > > 
> > > I see the hvc0 console hang regularly, ie doing something like 'up
> > > arrow' in bash causes the hvc0 console to hang. Prior kernels worked
> > > OK.
> > > 
> > > Any ideas? I'm not familiar with this code.. Thanks!  
> > 
> > Yes I have had another report, I'm working on a fix. Sorry it has taken
> > a while and thank you for the report.  
> 
> Okay, let me know when you have a fix and I will be able to test it
> for you!

Can you try this?

diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
index 5414c4a87bea..f5fc3ba49130 100644
--- a/drivers/tty/hvc/hvc_console.c
+++ b/drivers/tty/hvc/hvc_console.c
@@ -49,6 +49,8 @@
 #define N_OUTBUF	16
 #define N_INBUF		16
 
+#define HVC_ATOMIC_READ_MAX	128
+
 #define __ALIGNED__ __attribute__((__aligned__(sizeof(long))))
 
 static struct tty_driver *hvc_driver;
@@ -522,6 +524,8 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 		return -EIO;
 
 	while (count > 0) {
+		int ret;
+
 		spin_lock_irqsave(&hp->lock, flags);
 
 		rsize = hp->outbuf_size - hp->n_outbuf;
@@ -537,10 +541,13 @@ static int hvc_write(struct tty_struct *tty, const unsigned char *buf, int count
 		}
 
 		if (hp->n_outbuf > 0)
-			hvc_push(hp);
+			ret = hvc_push(hp);
 
 		spin_unlock_irqrestore(&hp->lock, flags);
 
+		if (!ret)
+			break;
+
 		if (count) {
 			if (hp->n_outbuf > 0)
 				hvc_flush(hp);
@@ -669,8 +676,8 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 	if (!hp->irq_requested)
 		poll_mask |= HVC_POLL_READ;
 
+ read_again:
 	/* Read data if any */
-
 	count = tty_buffer_request_room(&hp->port, N_INBUF);
 
 	/* If flip is full, just reschedule a later read */
@@ -717,9 +724,23 @@ static int __hvc_poll(struct hvc_struct *hp, bool may_sleep)
 #endif /* CONFIG_MAGIC_SYSRQ */
 		tty_insert_flip_char(&hp->port, buf[i], 0);
 	}
-	if (n == count)
-		poll_mask |= HVC_POLL_READ;
-	read_total = n;
+	read_total += n;
+
+	if (may_sleep) {
+		/* Keep going until the flip is full */
+		spin_unlock_irqrestore(&hp->lock, flags);
+		cond_resched();
+		spin_lock_irqsave(&hp->lock, flags);
+		goto read_again;
+	} else if (read_total < HVC_ATOMIC_READ_MAX) {
+		/* Break and defer if it's a large read in atomic */
+		goto read_again;
+	}
+
+	/*
+	 * Latency break, schedule another poll immediately.
+	 */
+	poll_mask |= HVC_POLL_READ;
 
  out:
 	/* Wakeup write queue if necessary */
