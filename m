Return-Path: <johnkokko@hotmail.com>
Received: from col0-omc1-s16.col0.hotmail.com (col0-omc1-s16.col0.hotmail.com
	[65.55.34.26]) by ozlabs.org (Postfix) with ESMTP id 22440B7185
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 17:05:22 +1000 (EST)
Message-ID: <COL120-W1B541E7CCFDA55F070E79A78D0@phx.gbl>
From: Ioannis Kokkoris <johnkokko@hotmail.com>
To: <haiying.wang@freescale.com>
Subject: RE: P1021MDS QE Ethernet Ports
Date: Fri, 3 Sep 2010 10:05:17 +0300
In-Reply-To: <1283434368.2904.2.camel@udp120119uds.am.freescale.net>
References: <COL120-W4274596E983E02BCBF4AD0A78B0@phx.gbl>,
	<COL120-W10FFCD057D88A833B4B46EA78C0@phx.gbl>,
	<1283434368.2904.2.camel@udp120119uds.am.freescale.net>
Content-Type: text/plain; charset="iso-8859-7"
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


> Subject: RE: P1021MDS QE Ethernet Ports
> From: Haiying.Wang@freescale.com
> To: johnkokko@hotmail.com
> CC: linuxppc-dev@lists.ozlabs.org
> Date: Thu=2C 2 Sep 2010 09:32:48 -0400
>
> On Thu=2C 2010-02-09 at 11:26 +0300=2C Ioannis Kokkoris wrote:
>>> From: johnkokko@hotmail.com
>>> To: linuxppc-dev@lists.ozlabs.org
>>> Subject: P1021MDS QE Ethernet Ports
>>> Date: Wed=2C 1 Sep 2010 15:11:56 +0300
>>>
>>>
>>> Hello=2C
>>>
>>> we are seeing a strange behavior when trying to use the QE Ethernet int=
erfaces.
>>> ENET5 (UCC5 - RMII) interface on P1021MDS boards does not come up if th=
ere is no physical link on the ENET1 (UCC1 - MII) Port.
>>> It seems that interrupts from ENET5 are normally received but the link =
comes up and works properly only if we have physical connection on ENET1.
>>>
>> So far I found the following:
>>
>> After adding traces=2C it seems that genphy_update_link() polls the corr=
ect device=2C with the correct address (0x03)=2C but although a physical li=
nk is present in ENET5=2C the polling is not successful until there is a li=
nk in ENET1 (address 0x02)!
>>
>> genphy_update_link: Dev: Micrel KS8041 ADD: 3 Status read 0x7849 (withou=
t ENET1 Link)
>> genphy_update_link: Dev: Micrel KS8041 ADD: 3 Status read 0x786D (with E=
NET1 Link)
>>
>> How does the MDIO of ENET1 affect the management of the physical interfa=
ce in a different HW address?
> Which board version are you using? this problem is now fixed in the new b=
oard version but not available right now.=20

We are using a board revision 2 (pilot version). Our main concern is whethe=
r this issue affects the working UCC1 eth interface performance.
Do you think that removing or pulling-down R79 (pin 21@U11) will fix the pr=
oblem with ENET1?

> You can connect two UECs for your current development.

Do you mean that changing the ENET1 interface from UCC1 to UCC3 in dts may =
solve the problem?

thank you for your reply=2C
John

 		 	   		  =
