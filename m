Return-Path: <SRS0=XpNt=SF=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 6E97DDDE43
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 17:39:54 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] MTD for Taco
Date: Tue, 15 Jan 2008 07:39:38 +0100
References: <477F12D1.2070109@pikatech.com> <200801150615.19910.sr@denx.de>
	<478C5309.7040805@pikatech.com>
In-Reply-To: <478C5309.7040805@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801150739.39095.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 January 2008, Sean MacLennan wrote:
> Stefan Roese wrote:
> > Right. One thing I noticed though is, that you map the NAND to
> > 0xd0000000, which is reserved for PCI in the 440EP address space. I
> > suggest you map it to 0x90000000 as done on Bamboo. Please give it a try
> > and let me know if this changes the 32bit access behavior.
>
> I think I changed it right. The following code is obviously a hack:
>
> static int warp_setup_nand_flash(void)
> {
> 	unsigned data;
>
> 	mfebc(0x1, data);
> 	printk("EBC0_B1CR %x\n", data); // SAM DBG
>
> 	data = 0x9001c000;
> 	mtebc(0x1, data);
>
> 	mfebc(0x1, data);
> 	printk("after EBC0_B1CR %x\n", data); // SAM DBG
>
> 	mfebc(0x11, data);
> 	printk("EBC0_B1AP %x\n", data); // SAM DBG
>
> 	platform_device_register(&warp_ndfc_device);
> 	platform_device_register(&warp_nand_device);
>
> 	return 0;
> }
> device_initcall(warp_setup_nand_flash);
>
>
> Then change the NAND base offset to 90000000. This change made no
> difference. It still works with 8-bit access and fails with 32-bit. The
> mtebc and mfebc macros where taken from u-boot.

Bummer! Was worth a try though. I still don't see why this should fail on your 
platform. What error/exception do you get upon 32bit access btw?

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
