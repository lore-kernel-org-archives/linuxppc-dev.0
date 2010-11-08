Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7B36DB70F4
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Nov 2010 20:47:37 +1100 (EST)
Message-ID: <4CD7C802.8020908@windriver.com>
Date: Mon, 08 Nov 2010 17:50:58 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Stefan Strobl <nst@gersys.de>
Subject: Re: Problem Ethernet Initialization MPC5200 +  LXT971A
References: <4CD431B4.7060405@gersys.de>
In-Reply-To: <4CD431B4.7060405@gersys.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stefan Strobl wrote:
> Hi
> 
> I'm having a Problem with the Initialization of my Ethernet PHY
> (FEC_MPC5200 + LXT971A Phy). I'm using latest U-Boot and Linux 2.6.37
> from Denx.
> 
> Once in Linux I can ping my own IP-Address but not any other device in
> my network. The Link LED is on when connected to the network but when
> pinging some other device nothing is being transmitted (Traffic LED is
> off).
> 
> If - before booting - I'm using any network command under U-Boot (which
> is calling eth_init()), the interface works fine after that under Linux
> also!
> In that case the kernel prints the line:
>      PHY: f003000:00 - Link is Up - 100/Full

Can you probe PHY successfully when failed?

> 
> So I'm not sure whether the Linux driver does not initialize the PHY
> correctly or whether I should be running a command under Linux that
> makes the interface work. I've played around with ifconfig but that
> didn't get me any further.
> 
> Under sysfs I can see that the MAC address is assigned correctly but:
> carrier = 0    (should be 1)
> duplex = half    (should be full)
> operstate = down
> speed = 10    (should be 100)
> 

Can you use 'ethtool' utility to access/control that? If no please check how you
access PHY by MII bus? I doubts some multiplex PIN should be configured when you
operate PHY.

> To workaround I could make u-boot run eth_init() always but that doesn't
> seem the right approach to this.

Yes. Often we shouldn't depend the bootloader do this when we use NIC. But its
worth tracking eth_init in detail to check what are missed for Linux. I guest
those should be dedicated to the hardware. For example, configuring
multiplex-pin, or reset PHY before the real operation action and so on.

Tiejun

> 
> Any ideas?
> 
> Many Thanks,
> Stefan.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
