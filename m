Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id E5290DDF4B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Mar 2007 02:37:47 +1000 (EST)
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E264947@aquib01a>
References: <F1F6EC0C8B75034F9E3A79FC85122E8E264947@aquib01a>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D7A8A821-67BD-480C-8832-BCD49F6D1735@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Accessng phy registers
Date: Tue, 27 Mar 2007 11:37:41 -0500
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
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


On Mar 26, 2007, at 15:55, DI BACCO ANTONIO - technolabs wrote:

>
> I saw that both in phy,c and mii.c (linux 2.6.19) there is support  
> to handle ioctls to read PHY registers. Why? And what should be  
> used from a user application? I have both CONFIG_MII and  
> CONFIG_PHYLIB set to y.


mii.c provides some generic support for reading and writing PHYs and  
reporting their status.  Many drivers provide support for the MII  
ioctl.  The PHY Lib provides somewhat more robust support for PHYs,  
allowing for PHY-specific drivers, and sharing PHY access between  
multiple controllers (useful for embedded applications).  The PHY Lib  
provides its own mii ioctl implementation so that you can support the  
mii ioctl while using the PHY Lib.  The two don't conflict, nor are  
they completely redundant, but there is a lot of overlap.

As for user applications...I'm not sure what's best, here.  The PHY  
Lib doesn't provide its own mechanism, currently, for manipulating  
PHYs from user space.  The mii ioctl provides the necessary  
functionality, and if your ethernet driver supports it, then that  
will work.  The PHY Lib's mii ioctl implementation isn't well tested,  
and if you aren't using the extra functionality, there's no reason to  
use the PHY Lib.
