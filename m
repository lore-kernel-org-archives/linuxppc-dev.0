Return-Path: <anton@samba.org>
Date: Tue, 8 Feb 2011 08:16:00 +1100
From: Anton Blanchard <anton@samba.org>
To: Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH 21/23] hvc_console: Fix race between hvc_close and
	hvc_remove
Message-ID: <20110208081600.1a816af5@kryten>
In-Reply-To: <20110206232253.421321729@pcw.home.local>
References: <4beed4da27f06efb2c13d6ed48850634@local>
	<20110206232253.421321729@pcw.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	linuxppc-dev@ozlabs.org, Amit Shah <amit.shah@redhat.com>,
	stable-review@kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> From: Amit Shah <amit.shah@redhat.com>
> 
> commit e74d098c66543d0731de62eb747ccd5b636a6f4c upstream.
> 
> Alan pointed out a race in the code where hvc_remove is invoked. The
> recent virtio_console work is the first user of hvc_remove().

I faintly remember this bug caused boot issues and the following patch
must be applied to fix it.

Anton
--

commit 320718ee074acce5ffced6506cb51af1388942aa
Author: Anton Blanchard <anton@samba.org>
Date:   Tue Apr 6 21:42:38 2010 +1000

    hvc_console: Fix race between hvc_close and hvc_remove
    
    I don't claim to understand the tty layer, but it seems like hvc_open and
    hvc_close should be balanced in their kref reference counting.
    
    Right now we get a kref every call to hvc_open:
    
            if (hp->count++ > 0) {
                    tty_kref_get(tty); <----- here
                    spin_unlock_irqrestore(&hp->lock, flags);
                    hvc_kick();
                    return 0;
            } /* else count == 0 */
    
            tty->driver_data = hp;
    
            hp->tty = tty_kref_get(tty); <------ or here if hp->count was 0
    
    But hvc_close has:
    
            tty_kref_get(tty);
    
            if (--hp->count == 0) {
    ...
                    /* Put the ref obtained in hvc_open() */
                    tty_kref_put(tty);
    ...
            }
    
            tty_kref_put(tty);
    
    Since the outside kref get/put balance we only do a single kref_put when
    count reaches 0.
    
    The patch below changes things to call tty_kref_put once for every
    hvc_close call, and with that my machine boots fine.
    
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Acked-by: Amit Shah <amit.shah@redhat.com>
    Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>

diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
index d3890e8..35cca4c 100644
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -368,16 +368,12 @@ static void hvc_close(struct tty_struct *tty, struct file * filp)
 	hp = tty->driver_data;
 
 	spin_lock_irqsave(&hp->lock, flags);
-	tty_kref_get(tty);
 
 	if (--hp->count == 0) {
 		/* We are done with the tty pointer now. */
 		hp->tty = NULL;
 		spin_unlock_irqrestore(&hp->lock, flags);
 
-		/* Put the ref obtained in hvc_open() */
-		tty_kref_put(tty);
-
 		if (hp->ops->notifier_del)
 			hp->ops->notifier_del(hp, hp->data);
 
