Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D97C5DDE31
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Jun 2007 04:47:54 +1000 (EST)
In-Reply-To: <466D6DEB.1030405@aimsys.nl>
References: <466D6DEB.1030405@aimsys.nl>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <15C3AB0E-E037-459A-96F2-F15AC088174E@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: ioctl on 870 FEC causes "badness in local_bh_enable at
	kernel/softirq.c"
Date: Mon, 11 Jun 2007 13:47:59 -0500
To: "N. van Bolhuis" <nvbolhuis@aimsys.nl>
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

>
> This is because drivers/net/fs_enet/fs_enet-main.c:fs_ioctl
> disables the interrupts with spin_lock_irqsave after which it calls
> phy_mii_ioctl. This leads to drivers/net/phy/phy.c:phy_read
> being called which does spin_lock_bh/spin_unlock_bh.
> Obviously the spin_unlock_bh enables softirqs and it is correctly
> complaining irqs are disabled.

That's a programming error.  The PHY Layer's functions must not be  
called with interrupts disabled.


Andy
