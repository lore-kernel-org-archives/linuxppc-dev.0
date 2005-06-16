Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 1930167A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 03:58:23 +1000 (EST)
In-Reply-To: <ecc06b51023e6ebd23d075aa3948749e@onz.com>
References: <ecc06b51023e6ebd23d075aa3948749e@onz.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1278c2c53202b80080519cca60bb438f@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 16 Jun 2005 12:58:20 -0500
To: "Allen Curtis" <acurtis@onz.com>
Cc: Ppc Embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC cpm2_devices DPRAM resource
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 16, 2005, at 12:45 PM, Allen Curtis wrote:

> Slightly different question than the current thread:
>
> Should the DPRAM appear as it's own platform_device?
> Option 1) Specify the portion of the DPRAM used by each device with
> that platform_device definition. (current)
>
> Option 2) Define the whole DPRAM region as its own platform_device
> entry. Move the device DPRAM information to the device specific
> platform structure.
>
> Would this help with a general dpalloc() implementation? It would
> reduce the number of ioremap() regions.

Well, we already have an allocator for general dpram memory.  I'm not 
really sure how this would help beyond reducing the fact that we may 
ioremap() regions more than once.  I think the better solution there is 
to look at the patches that have been made to ioremap() to return the 
same virtual addresses if you are remapping a region of physical memory 
that already has a mapping.

- kumar
