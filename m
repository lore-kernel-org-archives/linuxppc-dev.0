Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3EAEADDFE6
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 16:37:27 +1100 (EST)
Message-Id: <E601679F-F6E5-4DE0-A6AB-B7191F496C49@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Andrew Klossner <andrew@cesa.opbu.xerox.com>
In-Reply-To: <200901271813.n0RIDBHq023872@pogo.cesa.opbu.xerox.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] Restore PCI IO space behind Freescale pseudo-bridge 
Date: Tue, 27 Jan 2009 23:37:09 -0600
References: <200901271813.n0RIDBHq023872@pogo.cesa.opbu.xerox.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 27, 2009, at 12:13 PM, Andrew Klossner wrote:

> Kumar, you wrote:
>
>> Any resolution to all this.. Not exactly sure what change impacts
>> things and what part of our screwy HW is causing issues.
>
> The change in question is commit  
> b556151110ff003ce77d84597400c84824690ccf.
>
> The fundamental problem is that the "PCI Bus Command" register, the 16
> bits at offset 4 in config space for both the PCI and PCI-Express bus
> interfaces, does not populate PCI_COMMAND_IO, the least-significant
> bit.  The PCI bridge standard says that software must set this bit to
> 1 before the bridge can respond as a slave to I/O space access,
> including access to devices on the subordinate bus.  The FSL parts
> ignore this requirement and control response to I/O space with the
> (vendor-specific) outbound window attributes registers (POWARn.)
> 2.6.28 differs from 2.6.27 in that it examines this bit and sees that
> it's set to 0, then observes that the I/O space window starts at
> offset 0 and concludes that no I/O space resource should be allocated
> for the bridge.
>
> We are using the patch I emailed.  It's ugly in that it hard-codes the
> Freescale vendor ID, but it works for us.

I guess I'm confused what the actual breakage is beyond some printk  
messages.

We "fixup" the resources in fsl_pcibios_fixup_bus() so Ben's change  
shouldn't have an impact.  Does something actually stop functioning?

> Another option would have been to configure our I/O space window to
> start at an offset other than 0.  This would take me some time to
> achieve, and it feels ugly.


agreed, that's not the right solution.

- k
