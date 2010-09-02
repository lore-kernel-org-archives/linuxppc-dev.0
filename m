Return-Path: <johnkokko@hotmail.com>
Received: from col0-omc3-s15.col0.hotmail.com (col0-omc3-s15.col0.hotmail.com
	[65.55.34.153]) by ozlabs.org (Postfix) with ESMTP id ADA5CB716D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 18:26:34 +1000 (EST)
Message-ID: <COL120-W10FFCD057D88A833B4B46EA78C0@phx.gbl>
From: Ioannis Kokkoris <johnkokko@hotmail.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: RE: P1021MDS QE Ethernet Ports
Date: Thu, 2 Sep 2010 11:26:31 +0300
In-Reply-To: <COL120-W4274596E983E02BCBF4AD0A78B0@phx.gbl>
References: <COL120-W4274596E983E02BCBF4AD0A78B0@phx.gbl>
Content-Type: text/plain; charset="iso-8859-7"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> From: johnkokko@hotmail.com
> To: linuxppc-dev@lists.ozlabs.org
> Subject: P1021MDS QE Ethernet Ports
> Date: Wed=2C 1 Sep 2010 15:11:56 +0300
>
>
> Hello=2C
>
> we are seeing a strange behavior when trying to use the QE Ethernet inter=
faces.
> ENET5 (UCC5 - RMII) interface on P1021MDS boards does not come up if ther=
e is no physical link on the ENET1 (UCC1 - MII) Port.
> It seems that interrupts from ENET5 are normally received but the link co=
mes up and works properly only if we have physical connection on ENET1.
>
So far I found the following:

After adding traces=2C it seems that genphy_update_link() polls the correct=
 device=2C with the correct address (0x03)=2C but although a physical link =
is present in ENET5=2C the polling is not successful until there is a link =
in ENET1 (address 0x02)!

genphy_update_link: Dev: Micrel KS8041 ADD: 3 Status read 0x7849=A0 (withou=
t ENET1 Link)
genphy_update_link: Dev: Micrel KS8041 ADD: 3 Status read 0x786D=A0 (with=
=A0=A0=A0 ENET1 Link)

How does the MDIO of ENET1 affect the management of the physical interface =
in a different HW address?


> Can anyone think of a possible reason for this behavior=2C is there a way=
 to trace this problem?
> I can provide any further information needed.
>
> Any help would be appreciated=2C
> Regards=2C
> John
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
 		 	   		  =
