Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 9F795B6F76
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 12 Mar 2011 19:06:19 +1100 (EST)
Date: Sat, 12 Mar 2011 09:00:02 +0100
From: Anatolij Gustschin <agust@denx.de>
To: "Matthew L. Creech" <mlcreech@gmail.com>
Subject: Re: fsl_udc_core not initializing properly?
Message-ID: <20110312090002.7b703e61@wker>
In-Reply-To: <AANLkTi=B4O7u3S3qsa_zfDKWp33hXw3Yp5j6szRXDgfJ@mail.gmail.com>
References: <AANLkTikaH6=8JgX6wfqLu0fCFBO0A1hHDTpw7Xb64uKS@mail.gmail.com>
	<20110219095253.39540a57@wker>
	<AANLkTikvPOak6mamoeBrDBS5j_M3KuPmQi6DR5Ng6vki@mail.gmail.com>
	<AANLkTi=B4O7u3S3qsa_zfDKWp33hXw3Yp5j6szRXDgfJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/lS8Kk.KfLExdqiyBRZGRYUk"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--MP_/lS8Kk.KfLExdqiyBRZGRYUk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Matthew,

On Thu, 10 Mar 2011 13:46:29 -0500
"Matthew L. Creech" <mlcreech@gmail.com> wrote:
...
> I tracked the problem down to a change made in September, which
> happens to be yours:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=126512e3f274802ca65ebeca8660237f0361ad48
> 
> When I roll this back, everything works fine again.
> 
> First of all, I noticed that fsl-mph-dr-of.c isn't even compiling for
> me (even though I have the option enabled in my .config), because it's
> been placed in "usb/host/", and I'm only using device/gadget-mode USB.
> 
> I edited the top-level Makefile to just force it into "usb/host/", and
> that makes sure that your driver gets built (and it's probed just fine
> at runtime).  But that still didn't solve the problem - as before,
> fsl_udc_probe() is never being called.
> 
> Did you test this change in device mode?  I'm wondering if there's
> something different about my configuration that prevents it from
> working.  My config is uploaded here if it helps:
> 
> http://mcreech.com/work/linux.config

Can you please apply the attached patch, then build with your
linux.config and send me the kernel boot log? It will help to
fix the issue.

Thanks,

Anatolij
--MP_/lS8Kk.KfLExdqiyBRZGRYUk
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=usb-mph-dr-cfg.diff

diff --git a/drivers/Makefile b/drivers/Makefile
index f3ebb30..bf1ad90 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_UWB)		+= uwb/
 obj-$(CONFIG_USB_OTG_UTILS)	+= usb/otg/
 obj-$(CONFIG_USB)		+= usb/
 obj-$(CONFIG_USB_MUSB_HDRC)	+= usb/musb/
+obj-$(CONFIG_USB_FSL_MPH_DR_OF)	+= usb/host/
 obj-$(CONFIG_PCI)		+= usb/
 obj-$(CONFIG_USB_GADGET)	+= usb/gadget/
 obj-$(CONFIG_SERIO)		+= input/serio/
diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index 4c55eda..a3ba374 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -2240,6 +2240,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	unsigned int i;
 	u32 dccparams;
 
+	printk("%s\n", __func__);
 	if (strcmp(pdev->name, driver_name)) {
 		VDBG("Wrong device");
 		return -ENODEV;
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index 574b99e..b8b3070 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -130,6 +130,7 @@ static int __devinit fsl_usb2_mph_dr_of_probe(struct platform_device *ofdev)
 	static unsigned int idx;
 	int i;
 
+	printk("%s\n", __func__);
 	if (!of_device_is_available(np))
 		return -ENODEV;
 

--MP_/lS8Kk.KfLExdqiyBRZGRYUk--
