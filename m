Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45EE0DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 04:09:46 +1000 (EST)
In-Reply-To: <BD261180E6D35F4D9D32F3E44FD3D90108BE44C2@EMPBEDEX.empirix.com>
References: <BD261180E6D35F4D9D32F3E44FD3D90108BE44C2@EMPBEDEX.empirix.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3A76C14A-4A1C-48FA-9BEA-39020A131084@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: Trying to use Device Tree...and getting continuous interrupts
	from attached 88e1145
Date: Mon, 6 Aug 2007 13:09:35 -0500
To: "Morrison, Tom" <tmorrison@empirix.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 3, 2007, at 17:54, Morrison, Tom wrote:

> All,
>
> Connected to eth1 (etsec2) of my mpc8548 cpu is a 88E1145 and I
> am trying to get the core functionality running with the device tree
> paradigm - I know the sense of the 88E1145 is active-low for my
> mpc8548 board and have it working with an older 2.6.11++ kernel.
>
> I built this new kernel with the marvell driver - it seemingly
> does all the same things we did in the 2.6.11 kernel in separate
> spots...
>
> Here is the appropriate parts of my device tree for this part of the
> core...
>
>>> 		mdio@24520 {
>>> 			#address-cells = <1>;
>>> 			#size-cells = <0>;
>>> 			device_type = "mdio";
>>> 			compatible = "gianfar";	
>>> 			reg = <24520 20>;
>>> 			phy1: ethernet-phy@1 {
>>> 				interrupt-parent = <&mpic>;
>>> 				interrupts = <37 1>;


How recent of a kernel are you using?  The current kernel assigns the  
external interrupts to be the low 12 interrupts, which would make  
your interrupt assignment wrong.

>
> Now, that looks OK! Those are what I would expect. And when the
> mdio/phy are probed, configured, and the 88E1145 interrupt (EXT7
> (0x37H)) is enabled, the interrupt never (seemingly) gets cleared,
> and basically hangs the entire box up and eventually it panics!


Can you determine where it's hanging.  Or whether it is calling  
phy_interrupt() at all?  phy_interrupt should be disabling the  
interrupt at the PIC, and then the interrupt should be handled in a  
work queue.

Andy
