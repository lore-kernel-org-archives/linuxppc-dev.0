Date: Wed, 1 Aug 2001 13:45:41 +0200
From: Olaf Hering <olh@suse.de>
To: Romain Dolbeau <dolbeau@irisa.fr>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: `planb' doesn't compile on recent BenH kernel.
Message-ID: <20010801134541.B2050@suse.de>
References: <3B67E741.50A66F26@irisa.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
In-Reply-To: <3B67E741.50A66F26@irisa.fr>; from dolbeau@irisa.fr on Wed, Aug 01, 2001 at 01:25:53PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 01, Romain Dolbeau wrote:

>
> Hello,
>
> the `planb' module won't comiple on any recent BenH kernel
> (from rsync penguinppc.org::linux-2.4-benh).
>
> 2.4.6pre3 works fine. No 2.4.7* or 2.4.8* work for me.
> I think some newer 2.4.6pre* didn't work either.
>
> Apparently a locking mechanism was changed but
> not all instance updated:

The attached patch allows the compile. Do you have hardware to test? I
have a 7500 but no video hardware around.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="70__01_00_2.4.6-pre8-fixes"

--- ../tree/linux-2.4.6-pre6/drivers/media/video/planb.c	Thu Jun 28 10:39:31 2001
+++ linux/drivers/media/video/planb.c	Thu Jun 28 12:25:23 2001
@@ -82,7 +82,6 @@
 static int planb_open(struct video_device *, int);
 static void planb_close(struct video_device *);
 static int planb_ioctl(struct video_device *, unsigned int, void *);
-static int planb_init_done(struct video_device *);
 static int planb_mmap(struct video_device *, const char *, unsigned long);
 static void planb_irq(int, void *, struct pt_regs *);
 static void release_planb(void);
@@ -2071,7 +2070,6 @@
 #endif
 	pb->tab_size = PLANB_MAXLINES + 40;
 	pb->suspend = 0;
-	pb->lock = 0;
 	init_MUTEX(&pb->lock);
 	pb->ch1_cmd = 0;
 	pb->ch2_cmd = 0;

--5vNYLRcllDrimb99--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
