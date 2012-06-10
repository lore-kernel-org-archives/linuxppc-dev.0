Return-Path: <festevam@gmail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9F694B6FD9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2012 04:41:23 +1000 (EST)
Received: by bkcjg15 with SMTP id jg15so2817704bkc.38
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2012 11:41:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1338809853.3371.31.camel@mars>
References: <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
 <20120513225126.GA3683@lovely.krouter>
 <20120514042142.GD9750@kroah.com> <20120520231724.GA7941@mars>
 <F281D0F91ED19E4D8E63A7504E8A649803BB1E25@039-SN2MPN1-023.039d.mgd.msft.net>
 <1337583221.3394.21.camel@mars> <20120521065722.GA4363@mars>
 <20120521190450.GA27492@arwen.pp.htv.fi>
 <1338809424.3371.20.camel@mars> <1338809853.3371.31.camel@mars>
Date: Sun, 10 Jun 2012 15:41:19 -0300
Message-ID: <CAOMZO5B7+Qy06m7O=v1M3vt7to7ciKOhQOihVgAEf+utntvw4w@mail.gmail.com>
Subject: Re: [PATCH v2] usb: fsl_udc: errata - postpone freeing current dTD
From: Fabio Estevam <festevam@gmail.com>
To: Christoph Fritz <chf.fritz@googlemail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Ben Dooks <ben-linux@fluff.org>, Chen Peter-B29397 <B29397@freescale.com>,
 Nicolas Ferre <nicolas.ferre@atmel.com>, "Hans J. Koch" <hjk@hansjkoch.de>,
 Kukjin Kim <kgene.kim@samsung.com>, Russell King <linux@arm.linux.org.uk>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Sascha Hauer <s.hauer@pengutronix.de>, Christian Hemp <c.hemp@phytec.de>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, Daniel Mack <daniel@caiaq.de>,
 Neil Zhang <zhangwm@marvell.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Oliver Neukum <oneukum@suse.de>, Eric Miao <eric.y.miao@gmail.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Felipe Balbi <balbi@ti.com>, Ido Shayevitz <idos@codeaurora.org>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Christoph,

On Mon, Jun 4, 2012 at 8:37 AM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> After that, I stumbled upon this dmesg:
>
> Freescale High-Speed USB SOC Device Controller driver (Apr 20, 2007)
> fsl-usb2-udc fsl-usb2-udc: clk_get("usb") failed
> fsl-usb2-udc: probe of fsl-usb2-udc failed with error -2
>
> Sascha, could you give me a hint?

Does the patch below fix your problem?

 drivers/usb/gadget/fsl_mxc_udc.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/fsl_mxc_udc.c b/drivers/usb/gadget/fsl_mxc_udc.c
index dcbc0a2..c3ade6b 100644
--- a/drivers/usb/gadget/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/fsl_mxc_udc.c
@@ -36,21 +36,21 @@ int fsl_udc_clk_init(struct platform_device *pdev)
 	pdata = pdev->dev.platform_data;

 	if (!cpu_is_mx35() && !cpu_is_mx25()) {
-		mxc_ahb_clk = clk_get(&pdev->dev, "usb_ahb");
+		mxc_ahb_clk = clk_get(&pdev->dev, "ipg");
 		if (IS_ERR(mxc_ahb_clk))
 			return PTR_ERR(mxc_ahb_clk);

-		ret = clk_enable(mxc_ahb_clk);
+		ret = clk_prepare_enable(mxc_ahb_clk);
 		if (ret < 0) {
-			dev_err(&pdev->dev, "clk_enable(\"usb_ahb\") failed\n");
+			dev_err(&pdev->dev, "clk_enable(\"ipg\") failed\n");
 			goto eenahb;
 		}
 	}

 	/* make sure USB_CLK is running at 60 MHz +/- 1000 Hz */
-	mxc_usb_clk = clk_get(&pdev->dev, "usb");
+	mxc_usb_clk = clk_get(&pdev->dev, "per");
 	if (IS_ERR(mxc_usb_clk)) {
-		dev_err(&pdev->dev, "clk_get(\"usb\") failed\n");
+		dev_err(&pdev->dev, "clk_get(\"per\") failed\n");
 		ret = PTR_ERR(mxc_usb_clk);
 		goto egusb;
 	}
@@ -65,7 +65,7 @@ int fsl_udc_clk_init(struct platform_device *pdev)
 		}
 	}

-	ret = clk_enable(mxc_usb_clk);
+	ret = clk_prepare_enable(mxc_usb_clk);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "clk_enable(\"usb_clk\") failed\n");
 		goto eenusb;
@@ -79,7 +79,7 @@ eclkrate:
 	mxc_usb_clk = NULL;
 egusb:
 	if (!cpu_is_mx35())
-		clk_disable(mxc_ahb_clk);
+		clk_disable_unprepare(mxc_ahb_clk);
 eenahb:
 	if (!cpu_is_mx35())
 		clk_put(mxc_ahb_clk);
@@ -104,7 +104,7 @@ void fsl_udc_clk_finalize(struct platform_device *pdev)

 	/* ULPI transceivers don't need usbpll */
 	if (pdata->phy_mode == FSL_USB2_PHY_ULPI) {
-		clk_disable(mxc_usb_clk);
+		clk_disable_unprepare(mxc_usb_clk);
 		clk_put(mxc_usb_clk);
 		mxc_usb_clk = NULL;
 	}
@@ -113,11 +113,11 @@ void fsl_udc_clk_finalize(struct platform_device *pdev)
 void fsl_udc_clk_release(void)
 {
 	if (mxc_usb_clk) {
-		clk_disable(mxc_usb_clk);
+		clk_disable_unprepare(mxc_usb_clk);
 		clk_put(mxc_usb_clk);
 	}
 	if (!cpu_is_mx35()) {
-		clk_disable(mxc_ahb_clk);
+		clk_disable_unprepare(mxc_ahb_clk);
 		clk_put(mxc_ahb_clk);
 	}
 }
--
