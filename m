Return-Path: <bhumirks@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6dWz2JqDzDqJ4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 04:26:23 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 75so14207443pgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 09:26:23 -0800 (PST)
From: Bhumika Goyal <bhumirks@gmail.com>
To: julia.lawall@lip6.fr, balbi@kernel.org, gregkh@linuxfoundation.org,
 leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] usb: gadget: udc: constify usb_ep_ops structures
Date: Mon, 23 Jan 2017 22:56:04 +0530
Message-Id: <1485192364-2840-1-git-send-email-bhumirks@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Declare usb_ep_ops structures as const as they are only stored in the
ops field of an usb_ep structure. This field is of type const, so
usb_ep_ops structures having this property can be made const too.
Done using Coccinelle( A smaller version of the script)

@r disable optional_qualifier@
identifier i;
position p;
@@
static struct usb_ep_ops i@p={...};

@ok@
identifier r.i;
position p;
struct mv_ep a;
struct mv_u3d_ep b;
struct omap_ep c;

@@
(
a.ep.ops=&i@p;
|
b.ep.ops=&i@p;
|
c.ep.ops=&i@p;

)

@bad@
position p!={r.p,ok.p};
identifier r.i;
@@
i@p

@depends on !bad disable optional_qualifier@
identifier r.i;
@@
+const
struct usb_ep_ops i;

File size details before and after applying  the patch.
First line of every .o file shows the file size before patching and
second line shows the file size after patching.

  text	   data	    bss	    dec	    hex	filename

   7782	    384	      8	   8174	   1fee	usb/gadget/udc/fotg210-udc.o
   7878	    296	      8	   8182	   1ff6	usb/gadget/udc/fotg210-udc.o

  17866	    992	     40	  18898	   49d2	usb/gadget/udc/fsl_udc_core.o
  17954	    896	     40	  18890	   49ca	usb/gadget/udc/fsl_udc_core.o

   9646	    288	      8	   9942	   26d6	usb/gadget/udc/fusb300_udc.o
   9742	    192	      8	   9942	   26d6	usb/gadget/udc/fusb300_udc.o

  12752	    416	      8	  13176	   3378	drivers/usb/gadget/udc/goku_udc.o
  12832	    328	      8	  13168	   3370	drivers/usb/gadget/udc/goku_udc.o

  16541	   1696	      8	  18245	   4745	drivers/usb/gadget/udc/gr_udc.o
  16637	   1600	      8	  18245	   4745	drivers/usb/gadget/udc/gr_udc.o

  15798	    288	     16	  16102	   3ee6	drivers/usb/gadget/udc/m66592-udc.o
  15894	    192	     16	  16102	   3ee6	drivers/usb/gadget/udc/m66592-udc.o

  17751	   3808	     16	  21575	   5447	usb/gadget/udc/mv_u3d_core.o
  17839	   3712	     16	  21567	   543f	usb/gadget/udc/mv_u3d_core.o

  17348	   1112	     24	  18484	   4834	usb/gadget/udc/mv_udc_core.o
  17436	   1016	     24	  18476	   482c	usb/gadget/udc/mv_udc_core.o

  25990	   2620	     13	  28623	   6fcf	drivers/usb/gadget/udc/net2272.o
  26086	   2524	     13	  28623	   6fcf	drivers/usb/gadget/udc/net2272.o

  18409	   7312	      8	  25729	   6481	drivers/usb/gadget/udc/pxa27x_udc.o
  18505	   7208	      8	  25721	   6479	drivers/usb/gadget/udc/pxa27x_udc.o

  18644	    288	     16	  18948	   4a04	usb/gadget/udc/r8a66597-udc.o
  18740	    192	     16	  18948	   4a04	usb/gadget/udc/r8a66597-udc.o

Files: drivers/usb/gadget/udc/{s3c-hsudc.o/omap_udc.o/fsl_qe_udc.o} did
not complie.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/usb/gadget/udc/fotg210-udc.c  | 2 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c   | 2 +-
 drivers/usb/gadget/udc/fsl_udc_core.c | 2 +-
 drivers/usb/gadget/udc/fusb300_udc.c  | 2 +-
 drivers/usb/gadget/udc/goku_udc.c     | 2 +-
 drivers/usb/gadget/udc/gr_udc.c       | 2 +-
 drivers/usb/gadget/udc/m66592-udc.c   | 2 +-
 drivers/usb/gadget/udc/mv_u3d_core.c  | 2 +-
 drivers/usb/gadget/udc/mv_udc_core.c  | 2 +-
 drivers/usb/gadget/udc/net2272.c      | 4 ++--
 drivers/usb/gadget/udc/omap_udc.c     | 2 +-
 drivers/usb/gadget/udc/pxa27x_udc.c   | 2 +-
 drivers/usb/gadget/udc/r8a66597-udc.c | 2 +-
 drivers/usb/gadget/udc/s3c-hsudc.c    | 2 +-
 14 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/gadget/udc/fotg210-udc.c b/drivers/usb/gadget/udc/fotg210-udc.c
index 6ba122c..966637d 100644
--- a/drivers/usb/gadget/udc/fotg210-udc.c
+++ b/drivers/usb/gadget/udc/fotg210-udc.c
@@ -527,7 +527,7 @@ static void fotg210_ep_fifo_flush(struct usb_ep *_ep)
 {
 }
 
-static struct usb_ep_ops fotg210_ep_ops = {
+static const struct usb_ep_ops fotg210_ep_ops = {
 	.enable		= fotg210_ep_enable,
 	.disable	= fotg210_ep_disable,
 
diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 4fff51b..303328ce 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -1847,7 +1847,7 @@ static int qe_ep_set_halt(struct usb_ep *_ep, int value)
 	return status;
 }
 
-static struct usb_ep_ops qe_ep_ops = {
+static const struct usb_ep_ops qe_ep_ops = {
 	.enable = qe_ep_enable,
 	.disable = qe_ep_disable,
 
diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 71094e4..f518727 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1118,7 +1118,7 @@ static void fsl_ep_fifo_flush(struct usb_ep *_ep)
 	} while (fsl_readl(&dr_regs->endptstatus) & bits);
 }
 
-static struct usb_ep_ops fsl_ep_ops = {
+static const struct usb_ep_ops fsl_ep_ops = {
 	.enable = fsl_ep_enable,
 	.disable = fsl_ep_disable,
 
diff --git a/drivers/usb/gadget/udc/fusb300_udc.c b/drivers/usb/gadget/udc/fusb300_udc.c
index 42ff308..e0c1b00 100644
--- a/drivers/usb/gadget/udc/fusb300_udc.c
+++ b/drivers/usb/gadget/udc/fusb300_udc.c
@@ -518,7 +518,7 @@ static void fusb300_fifo_flush(struct usb_ep *_ep)
 {
 }
 
-static struct usb_ep_ops fusb300_ep_ops = {
+static const struct usb_ep_ops fusb300_ep_ops = {
 	.enable		= fusb300_enable,
 	.disable	= fusb300_disable,
 
diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index 5107987..8433c22 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -968,7 +968,7 @@ static void goku_fifo_flush(struct usb_ep *_ep)
 		command(regs, COMMAND_FIFO_CLEAR, ep->num);
 }
 
-static struct usb_ep_ops goku_ep_ops = {
+static const struct usb_ep_ops goku_ep_ops = {
 	.enable		= goku_ep_enable,
 	.disable	= goku_ep_disable,
 
diff --git a/drivers/usb/gadget/udc/gr_udc.c b/drivers/usb/gadget/udc/gr_udc.c
index b16f8af..1f99411 100644
--- a/drivers/usb/gadget/udc/gr_udc.c
+++ b/drivers/usb/gadget/udc/gr_udc.c
@@ -1841,7 +1841,7 @@ static void gr_fifo_flush(struct usb_ep *_ep)
 	spin_unlock(&ep->dev->lock);
 }
 
-static struct usb_ep_ops gr_ep_ops = {
+static const struct usb_ep_ops gr_ep_ops = {
 	.enable		= gr_ep_enable,
 	.disable	= gr_ep_disable,
 
diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
index de3e034..46ce7bc 100644
--- a/drivers/usb/gadget/udc/m66592-udc.c
+++ b/drivers/usb/gadget/udc/m66592-udc.c
@@ -1436,7 +1436,7 @@ static void m66592_fifo_flush(struct usb_ep *_ep)
 	spin_unlock_irqrestore(&ep->m66592->lock, flags);
 }
 
-static struct usb_ep_ops m66592_ep_ops = {
+static const struct usb_ep_ops m66592_ep_ops = {
 	.enable		= m66592_enable,
 	.disable	= m66592_disable,
 
diff --git a/drivers/usb/gadget/udc/mv_u3d_core.c b/drivers/usb/gadget/udc/mv_u3d_core.c
index 8d726bd..d365449 100644
--- a/drivers/usb/gadget/udc/mv_u3d_core.c
+++ b/drivers/usb/gadget/udc/mv_u3d_core.c
@@ -995,7 +995,7 @@ static int mv_u3d_ep_set_wedge(struct usb_ep *_ep)
 	return mv_u3d_ep_set_halt_wedge(_ep, 1, 1);
 }
 
-static struct usb_ep_ops mv_u3d_ep_ops = {
+static const struct usb_ep_ops mv_u3d_ep_ops = {
 	.enable		= mv_u3d_ep_enable,
 	.disable	= mv_u3d_ep_disable,
 
diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
index d82a91b..27ebb0d 100644
--- a/drivers/usb/gadget/udc/mv_udc_core.c
+++ b/drivers/usb/gadget/udc/mv_udc_core.c
@@ -946,7 +946,7 @@ static int mv_ep_set_wedge(struct usb_ep *_ep)
 	return mv_ep_set_halt_wedge(_ep, 1, 1);
 }
 
-static struct usb_ep_ops mv_ep_ops = {
+static const struct usb_ep_ops mv_ep_ops = {
 	.enable		= mv_ep_enable,
 	.disable	= mv_ep_disable,
 
diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 078c91d..7dc0102 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -181,7 +181,7 @@ static void net2272_dequeue_all(struct net2272_ep *);
 static int net2272_kick_dma(struct net2272_ep *, struct net2272_request *);
 static int net2272_fifo_status(struct usb_ep *);
 
-static struct usb_ep_ops net2272_ep_ops;
+static const struct usb_ep_ops net2272_ep_ops;
 
 /*---------------------------------------------------------------------------*/
 
@@ -1067,7 +1067,7 @@ net2272_fifo_flush(struct usb_ep *_ep)
 	net2272_ep_write(ep, EP_STAT1, 1 << BUFFER_FLUSH);
 }
 
-static struct usb_ep_ops net2272_ep_ops = {
+static const struct usb_ep_ops net2272_ep_ops = {
 	.enable        = net2272_enable,
 	.disable       = net2272_disable,
 
diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index a8709f9..f05ba68 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -1112,7 +1112,7 @@ static int omap_ep_set_halt(struct usb_ep *_ep, int value)
 	return status;
 }
 
-static struct usb_ep_ops omap_ep_ops = {
+static const struct usb_ep_ops omap_ep_ops = {
 	.enable		= omap_ep_enable,
 	.disable	= omap_ep_disable,
 
diff --git a/drivers/usb/gadget/udc/pxa27x_udc.c b/drivers/usb/gadget/udc/pxa27x_udc.c
index 7fa60f5..e1335ad 100644
--- a/drivers/usb/gadget/udc/pxa27x_udc.c
+++ b/drivers/usb/gadget/udc/pxa27x_udc.c
@@ -1473,7 +1473,7 @@ static int pxa_ep_disable(struct usb_ep *_ep)
 	return 0;
 }
 
-static struct usb_ep_ops pxa_ep_ops = {
+static const struct usb_ep_ops pxa_ep_ops = {
 	.enable		= pxa_ep_enable,
 	.disable	= pxa_ep_disable,
 
diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index f2c8862..118ad70 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1706,7 +1706,7 @@ static void r8a66597_fifo_flush(struct usb_ep *_ep)
 	spin_unlock_irqrestore(&ep->r8a66597->lock, flags);
 }
 
-static struct usb_ep_ops r8a66597_ep_ops = {
+static const struct usb_ep_ops r8a66597_ep_ops = {
 	.enable		= r8a66597_enable,
 	.disable	= r8a66597_disable,
 
diff --git a/drivers/usb/gadget/udc/s3c-hsudc.c b/drivers/usb/gadget/udc/s3c-hsudc.c
index 82a9e2a..42587b7 100644
--- a/drivers/usb/gadget/udc/s3c-hsudc.c
+++ b/drivers/usb/gadget/udc/s3c-hsudc.c
@@ -954,7 +954,7 @@ static int s3c_hsudc_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 	return 0;
 }
 
-static struct usb_ep_ops s3c_hsudc_ep_ops = {
+static const struct usb_ep_ops s3c_hsudc_ep_ops = {
 	.enable = s3c_hsudc_ep_enable,
 	.disable = s3c_hsudc_ep_disable,
 	.alloc_request = s3c_hsudc_alloc_request,
-- 
2.7.4
