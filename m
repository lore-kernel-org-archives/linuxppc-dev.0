Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 15186DDD08
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Feb 2007 13:40:18 +1100 (EST)
Date: Mon, 12 Feb 2007 18:40:15 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Lonsn <lonsn2004@126.com>
Subject: Re: How to force the 1000M network interface work in 100M mode?(AMCC
	440GX, board based on ocotea)
Message-ID: <20070213024015.GD9754@gate.ebshome.net>
References: <45D123A9.50805@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D123A9.50805@126.com>
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

On Tue, Feb 13, 2007 at 10:34:17AM +0800, Lonsn wrote:
> Hi, all:
> We have design a new board based on AMCC ocotea board. The linux kernel 
> version we use is 2.6.18 from kernel.org. The network interface is the 
> same as ocotea(eth0 and eth1 work in SMII mode, eth2 and eth3 work in 
> RGMII mode).The 1000Mbit ehernet physical transceiver chip is also 
> CIS8201(VSC8201). These pins(ANEG_DIS,FRC_DPLX,MODE10,MODE100,MODE1000) 
> of CIS8201 are set as 01111.
> Maybe because of the signal integrity problem of the gigabit 
> clock&data,eth3 doesn't work in 1000M mode(eth2 is ok). If we connect 
> eth3 with a host which has 100M ethernet, then eth3 works in 100M mode 
> well. If we connect eth3 with a host which has 1000M ethernet interface, 
>  then eth3 can recognize the link is 1000Mbit, but ping is not ok.
> So we want to force the eth3 work in 100M mode even eth3 is connected 
> with a 1000M host.(we think the hardware is ok when eth3 works in 100M 
> mode).
> We have used ethtool in the board and in the host to force the eth3 work 
> in 100M mode, but failed. Maybe we can't change this setting in 
> userspace? or we should changed the IBM_EMAC driver?
> Any suggestions?

Use ethtool to limit advertised auto-negotiation mode or force 100 on 
_both_ ends of the link. Probably, when you forced 100, you did it 
only on 440GX side, that's why it failed. Personally, I prefer 
"forcing" link speed by tweaking advertised modes, this way you have 
to do this only on one side of the link.

-- 
Eugene
