Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D721E67B5B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 05:14:27 +1000 (EST)
In-Reply-To: <016001c6f16d$44d707b0$1267a8c0@Jocke>
References: <016001c6f16d$44d707b0$1267a8c0@Jocke>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E86BE632-0841-4572-BE65-C308B0E0BF78@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Slight refactor of interrupt mapping for FSL parts
Date: Thu, 19 Oct 2006 14:14:18 -0500
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev@ozlabs.org, 'Jeff Garzik' <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 16, 2006, at 16:51, Joakim Tjernlund wrote:

>>> -#define PHY_POLL		-1
>>> +#define PHY_POLL		NO_IRQ
>>>  #define PHY_IGNORE_INTERRUPT	-2
>
> What does PHY_IGNORE_INTERRUPT mean? Can I use that in a dummy PHY
> driver that just pretends that all is well? Got a ethernet port that
> is connect to a switch directly over MII.
> How do I express -2 in a dts file?


PHY_IGNORE_INTERRUPT means that the PHY Lib will not poll the  
interface, nor will it register for the interrupt.  Actually, it  
would be best for a dummy PHY driver.  Take a look at the driver in  
drivers/phy/fixed.c.  It's there to provide that kind of interface.   
It looks like it uses -1, which is a problem, but my revision of this  
patch will fix that.

(Sorry for the odd delay.  I was sure I had clicked "send" on this one)
