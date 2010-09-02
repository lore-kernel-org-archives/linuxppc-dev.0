Return-Path: <Haiying.Wang@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by ozlabs.org (Postfix) with ESMTP id 21A9EB7163
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 23:33:24 +1000 (EST)
Subject: RE: P1021MDS QE Ethernet Ports
From: Haiying Wang <Haiying.Wang@freescale.com>
To: Ioannis Kokkoris <johnkokko@hotmail.com>
In-Reply-To: <COL120-W10FFCD057D88A833B4B46EA78C0@phx.gbl>
References: <COL120-W4274596E983E02BCBF4AD0A78B0@phx.gbl>
	<COL120-W10FFCD057D88A833B4B46EA78C0@phx.gbl>
Content-Type: text/plain
Date: Thu, 2 Sep 2010 09:32:48 -0400
Message-ID: <1283434368.2904.2.camel@udp120119uds.am.freescale.net>
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-02-09 at 11:26 +0300, Ioannis Kokkoris wrote:
> > From: johnkokko@hotmail.com
> > To: linuxppc-dev@lists.ozlabs.org
> > Subject: P1021MDS QE Ethernet Ports
> > Date: Wed, 1 Sep 2010 15:11:56 +0300
> >
> >
> > Hello,
> >
> > we are seeing a strange behavior when trying to use the QE Ethernet interfaces.
> > ENET5 (UCC5 - RMII) interface on P1021MDS boards does not come up if there is no physical link on the ENET1 (UCC1 - MII) Port.
> > It seems that interrupts from ENET5 are normally received but the link comes up and works properly only if we have physical connection on ENET1.
> >
> So far I found the following:
> 
> After adding traces, it seems that genphy_update_link() polls the correct device, with the correct address (0x03), but although a physical link is present in ENET5, the polling is not successful until there is a link in ENET1 (address 0x02)!
> 
> genphy_update_link: Dev: Micrel KS8041 ADD: 3 Status read 0x7849  (without ENET1 Link)
> genphy_update_link: Dev: Micrel KS8041 ADD: 3 Status read 0x786D  (with    ENET1 Link)
> 
> How does the MDIO of ENET1 affect the management of the physical interface in a different HW address?
Which board version are you using? this problem is now fixed in the new board version but not available right now. You can connect two UECs for your current development.

> 
> > Can anyone think of a possible reason for this behavior, is there a way to trace this problem?
> > I can provide any further information needed.
> >
> > Any help would be appreciated,
> > Regards,
> > John
> >
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>  		 	   		  
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
