From: "Petr Vandrovec Ing. VTEI" <VANDROVE@vc.cvut.cz>
To: Owen Waller <O.Waller@ee.qub.ac.uk>
Date: Mon, 1 Feb 1999 17:38:06 MET-1
MIME-Version: 1.0
Content-type: Multipart/Mixed; boundary=Message-Boundary-6663
Subject: Re: matroxfb, anybody? (More details...)
CC: linuxppc-dev@lists.linuxppc.org
Message-ID: <1F2ACA229B9@vcnet.vc.cvut.cz>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--Message-Boundary-6663
Content-type: text/plain; charset=US-ASCII
Content-description: Mail message body
Content-Transfer-Encoding: 7BIT

On  1 Feb 99 at 15:30, Owen Waller wrote:
> o.k. well the x86 board definelty doesn't... So we now have a more general
> problem:
> If I have two idential video boards in my Mac one "mac" specific which
> shows up in the OF tree, and one that is x86 sourced and doesn't show up
> under OF how can we initialise both boards correctly.
If you have at least one matrox in your OF tree, driver will initialize
all matroxes from offb. If you have no matrox in OF tree, driver will
initialize them from matrox_init.
> im my case matroxfb will become my primary head, but I'd still like access
> to the internal (control) video in case soemthing in a new kernel dies
> before matroxfb is initialised.
Without offb you can set order by
video=control: video=matrox:
to get control first (or vice versa to get matrox first). With offb I do not
know.

So, attached patch adds back that matrox_init is called unless you
specify `video=matrox:off' on command line. In this case, matrox can
be still initialized through offb. If you specify `video=matrox:disabled',
driver will be unavailable for offb too.
Also, driver still does not use device_node passed to driver by offb
because of no-one told me what I can expect in that variable... Driver
uses nvram_read_byte(NV_VMODE & NV_CMODE) to set initial resolution if
offb is enabled.
                                    Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz

P.S.: I hope that your list survive this 890 bytes long attachment.
P.P.S.: As usual, cc-me if you have comments/question/...
P.P.P.S.: If patch will not apply cleanly, apply Geert's scr_readw()
patches first.

--Message-Boundary-6663
Content-type: text/plain; charset=US-ASCII
Content-description: Text from file 'OW'
Content-Transfer-Encoding: 7BIT

--- linux-2.2.1.dist/drivers/video/matroxfb.c	Fri Jan 15 22:56:49 1999
+++ linux/drivers/video/matroxfb.c	Mon Feb  1 16:55:56 1999
@@ -4,7 +4,7 @@
  *
  * (c) 1998,1999 Petr Vandrovec <vandrove@vc.cvut.cz>
  *
- * Version: 1.9 1999/01/04
+ * Version: 1.13 1999/02/01
  *
  * MTRR stuff: 1998 Tom Rini <tmrini@ntplx.net>
  *
@@ -5743,20 +5748,26 @@
 }
 
 #ifndef MODULE
+static int __init initialized = 0;
+
 __initfunc(void matroxfb_init(void))
 {
 	DBG("matroxfb_init")
-#if defined(CONFIG_FB_OF)
-/* Nothing to do, must be called from offb */
-#else	
-	matrox_init();
-#endif
+	
+	if (!initialized) {
+		initialized = 1;
+		matrox_init();
+	}
 }
 
 #if defined(CONFIG_FB_OF)
 __initfunc(int matrox_of_init(struct device_node *dp)) {
 	DBG("matrox_of_init");
-	matrox_init();
+	
+	if (!initialized) {
+		initialized = 1;
+		matrox_init();
+	}
 	if (!fb_list) return -ENXIO;
 	return 0;
 }

--Message-Boundary-6663--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
