Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id B5BB0DDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 09:26:45 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: Peter Korsgaard <jacmet@sunsite.dk>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/6] [C67x00] Fix calculation of frame bandwidth
Date: Tue, 12 Jun 2007 17:02:17 -0600
Message-Id: <11816893492706-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11816893494143-git-send-email-grant.likely@secretlab.ca>
References: <11816893411272-git-send-email-grant.likely@secretlab.ca>
	<11816893494143-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Use the correct formulas and values for calculating the bittime within
a frame.
Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/usb/c67x00/c67x00-hcd.h   |   10 ++++++--
 drivers/usb/c67x00/c67x00-sched.c |   42 +++++++++++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-hcd.h b/drivers/usb/c67x00/c67x00-hcd.h
index 8f8eff1..94ce7ec 100644
--- a/drivers/usb/c67x00/c67x00-hcd.h
+++ b/drivers/usb/c67x00/c67x00-hcd.h
@@ -46,12 +46,16 @@
  * The current implementation switches between _STD (default) and _ISO (when
  * isochronous transfers are scheduled), in order to optimize the throughput
  * in normal cicrumstances, but also provide good isochronous behaviour.
+ *
+ * Bandwidth is described in bit time so with a 12MHz USB clock and 1ms
+ * frames; there are 12000 bit times per frame.
  */
 
-#define MAX_FRAME_BW_STD	4000
-#define MAX_FRAME_BW_ISO	2400
+#define TOTAL_FRAME_BW		12000
+#define DEFAULT_EOT		2250
 
-#define DEFAULT_EOT		6500
+#define MAX_FRAME_BW_STD	(TOTAL_FRAME_BW - DEFAULT_EOT)
+#define MAX_FRAME_BW_ISO	2400
 
 /*
  * Periodic transfers may only use 90% of the full frame, but as
diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index 952bdab..0d08af7 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -520,11 +520,45 @@ static inline void giveback_urb(struct c67x00_hcd *c67x00, struct urb *urb,
 
 /* -------------------------------------------------------------------------- */
 
-static int claim_frame_bw(struct c67x00_hcd *c67x00, int len, int periodic)
+static int claim_frame_bw(struct c67x00_hcd *c67x00, struct urb *urb,
+			  int len, int periodic)
 {
-	int bit_time = len * 8;
+	struct urb_priv *urbp = urb->hcpriv;
+	int bit_time;
+
+	/* According to the C67x00 BIOS user manual, page 3-18,19, the
+	 * following calculations provide the full speed bit times for
+	 * a transaction.
+	 *
+	 * FS(in)	= 112.5 +  9.36*BC + HOST_DELAY
+	 * FS(in,iso)	=  90.5 +  9.36*BC + HOST_DELAY
+	 * FS(out)	= 112.5 +  9.36*BC + HOST_DELAY
+	 * FS(out,iso)	=  78.4 +  9.36*BC + HOST_DELAY
+	 * LS(in)	= 802.4 + 75.78*BC + HOST_DELAY
+	 * LS(out)	= 802.6 + 74.67*BC + HOST_DELAY
+	 *
+	 * HOST_DELAY == 106 for the c67200 and c67300.
+	 */
+
+	/* make calculations in 1/100 bit times to maintain resolution */
+	if (urbp->ep_data->dev->speed == USB_SPEED_LOW) {
+		/* Low speed pipe */
+		if (usb_pipein(urb->pipe))
+			bit_time = 80240 + 7578*len;
+		else
+			bit_time = 80260 + 7467*len;
+	} else {
+		/* FS pipes */
+		if (usb_pipeisoc(urb->pipe))
+			bit_time = usb_pipein(urb->pipe) ? 9050 : 7840;
+		else
+			bit_time = 11250;
+		bit_time += 936*len;
+	}
 
-	/* TODO don't we need to take low speed into regards? */
+	/* Scale back down to integer bit times.  Use a host delay of 106.
+	 * (this is the only place it is used) */
+	bit_time = ((bit_time+50) / 100) + 106;
 
 	if (unlikely(bit_time + c67x00->bandwidth_allocated >=
 		     c67x00->max_frame_bw))
@@ -565,7 +599,7 @@ static int create_td(struct c67x00_hcd *c67x00,
 	__u8 cmd = 0;
 	int tt = 0;
 
-	if (claim_frame_bw(c67x00, len,
+	if (claim_frame_bw(c67x00, urb, len,
 			   usb_pipeisoc(urb->pipe) || usb_pipeint(urb->pipe)))
 		return -EMSGSIZE;	/* Not really an error, but expected */
 
-- 
1.4.4.2
