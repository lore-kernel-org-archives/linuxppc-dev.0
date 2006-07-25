Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D9A1B679FB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jul 2006 04:45:52 +1000 (EST)
In-Reply-To: <200607241139.02128.laurent.pinchart@tbox.biz>
References: <200607241139.02128.laurent.pinchart@tbox.biz>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1465B4C7-CDE6-4E67-A219-47FBCC774EDA@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Endless "Trying 100/HALF" messages using FCC ethernet on MPC8248
Date: Tue, 25 Jul 2006 13:46:29 -0500
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 24, 2006, at 04:39, Laurent Pinchart wrote:

> Hi everybody,
>
> I'm not sure if this issue is ppc-specific, so forgive me if it  
> should have
> been reported to the drivers/net/phy maintainer.
>
> When using the MPC8248 FCC ethernet ports, the following messages  
> are printed
> by the kernel on the console when a link is down (ethernet cable  
> unplugged):
>
> Trying 100/FULL
> Trying 100/HALF
> Trying 100/HALF
> Trying 100/HALF
> ...
>
> This goes on forever, with a new message every 5 or 10 seconds. The  
> message is
> printed by drivers/net/phy/phy.c at line 463.
>
> Those messages are pretty annoying. Commenting the pr_info() call  
> gave me some
> rest, but a proper fix is probably needed.
>
> For the record, I'm using FCC1 and FCC2 with an LXT973 phy in bit- 
> banging
> mode.


There are two bugs at play, here.  One of which has been solved by a  
patch, which hasn't been accepted yet.  However, there's still a bug,  
in that the PHY layer assumes that autonegotiation will complete if  
the link is down.  I  believe you only see the message if you bring  
up the interface while the link is down.

I'm working on a fix for this.

Andy
