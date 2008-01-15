Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 7248ADDE43
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 17:30:35 +1100 (EST)
Message-ID: <478C5309.7040805@pikatech.com>
Date: Tue, 15 Jan 2008 01:30:33 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] MTD for Taco
References: <477F12D1.2070109@pikatech.com> <200801142042.56847.sr@denx.de>
	<478BC05C.2080007@pikatech.com> <200801150615.19910.sr@denx.de>
In-Reply-To: <200801150615.19910.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
>
> Right. One thing I noticed though is, that you map the NAND to 0xd0000000, 
> which is reserved for PCI in the 440EP address space. I suggest you map it to 
> 0x90000000 as done on Bamboo. Please give it a try and let me know if this 
> changes the 32bit access behavior.
>   
I think I changed it right. The following code is obviously a hack:

static int warp_setup_nand_flash(void)
{
	unsigned data;

	mfebc(0x1, data);
	printk("EBC0_B1CR %x\n", data); // SAM DBG

	data = 0x9001c000;
	mtebc(0x1, data);

	mfebc(0x1, data);
	printk("after EBC0_B1CR %x\n", data); // SAM DBG

	mfebc(0x11, data);
	printk("EBC0_B1AP %x\n", data); // SAM DBG

	platform_device_register(&warp_ndfc_device);
	platform_device_register(&warp_nand_device);

	return 0;
}
device_initcall(warp_setup_nand_flash);


Then change the NAND base offset to 90000000. This change made no 
difference. It still works with 8-bit access and fails with 32-bit. The 
mtebc and mfebc macros where taken from u-boot.

Cheers,
    Sean
