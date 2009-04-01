Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E8ACADDE07
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 20:22:51 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/de01egw02-8.14.3) with ESMTP id
	n319MlPw022319
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 02:22:47 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id n319MikI025056
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 04:22:46 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Subject: RE: USB does not work on mpc8347
Date: Wed, 1 Apr 2009 17:22:44 +0800
Message-ID: <3A45394FD742FA419B760BB8D398F9ED2FAE0B@zch01exm26.fsl.freescale.net>
In-Reply-To: <20090401180230.04BE.YAMAZAKI.SEIJI@kk.jp.panasonic.com>
References: <20090401180230.04BE.YAMAZAKI.SEIJI@kk.jp.panasonic.com>
From: "Li Yang-R58472" <LeoLi@freescale.com>
To: =?iso-2022-jp?B?GyRCOzM6aiEhQDpGcxsoQg==?=
	<yamazaki.seiji@kk.jp.panasonic.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org 
> [mailto:linuxppc-dev-bounces+leoli=freescale.com@ozlabs.org] 
> On Behalf Of 山崎　精二
> Sent: Wednesday, April 01, 2009 5:14 PM
> To: linuxppc-dev@ozlabs.org
> Subject: USB does not work on mpc8347
> 
> Hi all,
> 
> I am running the Linux kernel 2.6.28.7 on my PPC8347 BRD.
> I have some problem.
> 
> One is USB does not work on mpc8347.
> platform_driver_probe(&udc_driver, fsl_udc_probe) is failed.
> struct is
> static struct platform_driver udc_driver = {
> 	.probe = fsl_udc_probe,
> 	.remove  = __exit_p(fsl_udc_remove),
> 	/* these suspend and resume are not usb suspend and resume */
> 	.suspend = fsl_udc_suspend,
> 	.resume  = fsl_udc_resume,
> 	.driver  = {
> //		.name = (char *)driver_name,
> 		.name		= "fsl-usb2-mph",

Why are you changing this?  Mph module can only be host, not the device mode supported by this driver.

> 		.owner = THIS_MODULE,
> 	},
> };
> I do not know why it fails.
> Do i have to do something ?

So what function did you try to test?  Host or device?  For host mode, you should look into the drivers/usb/host/ehci-fsl.c file.

- Leo
