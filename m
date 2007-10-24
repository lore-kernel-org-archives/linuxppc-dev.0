Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc2-s35.bay0.hotmail.com (bay0-omc2-s35.bay0.hotmail.com
	[65.54.246.171]) by ozlabs.org (Postfix) with ESMTP id D3544DDF42
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Oct 2007 17:26:26 +1000 (EST)
Message-ID: <BAY101-W422E04CF50A57F15D38ED1BE940@phx.gbl>
From: - Reyneke <reynekejunk@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: PPC4xx 2x eth phy
Date: Wed, 24 Oct 2007 07:26:25 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Some quick feedback to the list. A few weeks ago I talked about the problem=
 of the second ethernet connection not working when the first ethernet conn=
ection does not have a link.

Basically the problem is PHYs that don't generate a RX clock when no link i=
s present (i.e. ET1011. It turns out that in case of the 440Epx, there is s=
ome interdependency within the EMAC which means that when EMAC1 initialises=
, there MUST be a RX clock on EMAC0. If that is not the case, EMAC1 will NO=
T send/receive even though initialisation and auto-negotiation is successfu=
l.

There is some linux code for handling missing RX clocks, but this code does=
 not extend to the scenario where one EMAC is dependent on another EMAC's P=
HY having a receive clock.

Regards
   Jan Reyneke


> HI,
>
> We've run into a bit of an odd problem and we are not sure where to go an=
d
> look for the cause.
>
> We have some 440EPx based hardware with two GIG-Ethernet ports using RGMI=
I
> and 2x ET1011C PHY's. Problem is that eth1 will only initialise correctly
> (i.e. receive and transmit) if eth0 has a link. Eth0 always work OK,
> regardless of eth1 status. Eth1 will work OK if eth0 has a link (i.e.
> initialised) at time of setup. Once initialised, eth0 status is
> irrelevant.
> All this is during Linux boot process.
>
> Any ideas?
>
> We can access PHY registers via u-boot (mii commands). Same 1Gig link
> speed
> is used on both ports. Linux kernel is 2.6.19.

_________________________________________________________________
The next generation of MSN Hotmail has arrived - Windows Live Hotmail
http://www.newhotmail.co.uk=
