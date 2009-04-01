Return-Path: <yamazaki.seiji@kk.jp.panasonic.com>
Received: from smtp.mei.co.jp (smtp.mei.co.jp [133.183.100.20])
	by ozlabs.org (Postfix) with ESMTP id 60FBFDDDFA
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 20:13:39 +1100 (EST)
Received: from mail-gw.jp.panasonic.com ([157.8.1.145])
	by smtp.mei.co.jp (8.12.11.20060614/3.7W/kc-maile14) with ESMTP id
	n319DbIm022880
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 18:13:37 +0900 (JST)
Received: by mail-gw.jp.panasonic.com (8.11.6p2/3.7W/somlb1) with ESMTP id
	n319Dco00273
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 18:13:38 +0900 (JST)
Received: from epochmail.jp.panasonic.com (localhost [127.0.0.1])
	by mail.jp.panasonic.com (8.11.6p2/3.7W/kc-maili06) with ESMTP id
	n319Dac15313
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 18:13:36 +0900 (JST)
Received: by epochmail.jp.panasonic.com (8.12.11.20060308/3.7W/somla8) id
	n319Db8J028688
	for linuxppc-dev@ozlabs.org; Wed, 1 Apr 2009 18:13:37 +0900 (JST)
Received: from [10.74.116.86]
	by somla8.jp.panasonic.com (8.12.11.20060308/3.7W) with ESMTP id
	n319DbJo028664
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Apr 2009 18:13:37 +0900 (JST)
Date: Wed, 01 Apr 2009 18:13:37 +0900
From: =?ISO-2022-JP?B?GyRCOzM6aiEhQDpGcxsoQg==?=
	<yamazaki.seiji@kk.jp.panasonic.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: USB does not work on mpc8347
Message-Id: <20090401180230.04BE.YAMAZAKI.SEIJI@kk.jp.panasonic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-2022-JP"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

I am running the Linux kernel 2.6.28.7 on my PPC8347 BRD.
I have some problem.

One is USB does not work on mpc8347.
platform_driver_probe(&udc_driver, fsl_udc_probe) is failed.
struct is 
static struct platform_driver udc_driver = {
	.probe = fsl_udc_probe,
	.remove  = __exit_p(fsl_udc_remove),
	/* these suspend and resume are not usb suspend and resume */
	.suspend = fsl_udc_suspend,
	.resume  = fsl_udc_resume,
	.driver  = {
//		.name = (char *)driver_name,
		.name		= "fsl-usb2-mph",
		.owner = THIS_MODULE,
	},
};
I do not know why it fails.
Do i have to do something ?

-Seiji  

-- 
yamazaki seiji <yamazaki.seiji@kk.jp.panasonic.com>
