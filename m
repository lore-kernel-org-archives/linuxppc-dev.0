Message-ID: <3CD040AB.5000702@mvista.com>
Date: Wed, 01 May 2002 12:23:23 -0700
From: Todd Poynor <tpoynor@mvista.com>
MIME-Version: 1.0
To: andrew may <acmay@acmay.homeip.net>
Cc: Venkatesh Ramamurthy <rpranesh@hotmail.com>, mporter@mvista.com,
	frank_rowand@mvista.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux on 440GP Networking issues
References: <F45zrLCCtgx8VUkRacU000059cf@hotmail.com> <20020501120137.B9360@ecam.san.rr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>Yep, the kernel tries to setup the second controller. But there is someting
>>very strange. Eventhough there is no network cable connected to the second
>>ethernet port , the OCP ENET driver says that it is 10Mbps, Link up and half
>>duplex.

The above is the default provided when autonegotiation doesn't turn up
anything useful, at least for the AMD Am79C875* PHYs (see ibm_ocp_phy.c:
mii_parse_Am79C875_pcr), which probably isn't the way to go.  And
handling of the "no link" case does seem to need some work.

Could verify whether the lockup is related to configuring 2 EMACs by a
hack to ppc405_enet_open to return -ENODEV if fep->emac_num > 0.  If
that boots fine then see if ppc405_eth_mal_dump shows registers such as
EMAC0's TXCTP0R or RXCTP0R changing values after EMAC1 is configured.
If so, that FIXME in the ppc405_enet_open code probably needs revisiting.


--
Todd


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
