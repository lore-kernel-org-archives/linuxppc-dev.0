Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 9B024DDFF0
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:42:08 +1100 (EST)
Message-ID: <45CB28A6.3050607@freescale.com>
Date: Thu, 08 Feb 2007 07:41:58 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Li Yang-r58472 <LeoLi@freescale.com>
Subject: Re: Discussion about iopa()
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
In-Reply-To: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
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

Li Yang-r58472 wrote:

> Do you think we should remove iopa?

It's not used very much any more.  If you do a grep of the code, I think 
only some legacy drivers use it.

As long as ioremap'd memory is both physically and virtually contiguous, 
I think iopa() is unnecessary.

> The information is often not so obvious.  The most case of using iopa is
> that we allocate memory from MURAM using rheap, and then get the
> physical address of it.  We can calculate phy_addr by using:  virt_addr
> - virt_muram_base + phy_muram_base, but it is not as straightforward as
> just using the page table, let alone we need to keep track of
> virt_muram_base and phy_muram_base.

Walking the page table is slower than using pointer math, so you want to 
avoid iopa() if you can.

I think in general, the driver that calls ioremap() should store the 
physical address along with the virtual address of the base pointer.
