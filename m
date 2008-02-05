Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 721E2DDEF3
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Feb 2008 11:40:33 +1100 (EST)
In-Reply-To: <000001c862fe$5ff16550$6405a8c0@absolut>
References: <mailman.1.1201309203.24413.linuxppc-embedded@ozlabs.org>
	<000601c85fc5$41e48330$6405a8c0@absolut>
	<D71D9F25-4724-487E-AD07-E848B4608B97@freescale.com>
	<000001c862fe$5ff16550$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <BA49FE2F-0416-49E6-A9EA-63FB157773C4@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: 83xx HDLC Driver Dev - Multiple PHYs?
Date: Mon, 4 Feb 2008 18:39:24 -0600
To: <rmcguire@videopresence.com>
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


On Jan 29, 2008, at 23:10, Russell McGuire wrote:

>
> All,
>
> I have gotten my HDLC driver up to the point where it can register  
> itself
> with the Linux kernel. However now I am faced with a dilemma and style
> question, that is probably best answered by you driver developers  
> that have
> more experience.
>
> I am putting support for multiple PHY's into the HDLC driver, but  
> after
> converting it to use the of_device tree, and inserting a UCC@5000  
> for a
> single UCC HDLC driver, it occurred to me that if I insert more  
> devices
> (UCC@6000, UCC@7000, UCC@8000) that the driver will attempt to load  
> multiple
> times.

There is already a mechanism to ensure modules aren't loaded again  
when a new device is found.  Look at the gianfar support again.  The  
mpc8548 CDS has 4 eTSEC devices and one driver which handles them all  
(gianfar).  The driver is initialized once.  The probe function will  
be called for each instance of the device.  You need to make sure  
your driver's probe function can be called once per device.

>
> Solution 3:
> Have phy-count=4; defined in the driver header, or a module  
> parameter, and
> have a single module instance of the driver itself responsible for  
> creating
> a single private data structure and setting up multiple UCC's and  
> PHY's?

No, please.  If the PHYs aren't discoverable, you might need  
something like that.  But I suspect you just have one PHY per  
device.  If you have more, how is that configured?  Is the hardware  
aware of the number of PHYs?  Or are you just selecting between  
different PHY addresses?

>
> This also feeds into a question on SET_NETDEV_DEV. How does it  
> react to
> multiple net devices attached to a single base driver?

SET_NETDEV_DEV declares the base *device* of the net device.  The  
driver is a separate issue.  And it shouldn't be a problem, because  
each device instance has its own private structure.

Andy
