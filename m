Message-ID: <3D647E5E.9060708@dslextreme.com>
Date: Wed, 21 Aug 2002 23:02:06 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: request_irq() bug in ENET driver?
References: <20020821045259.GG18818@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> This code comes from ppc405_enet_open():
>
> 	if (!(get_mal_dcrn(fep->mal, DCRN_MALTXCASR))) {
>  		request_irq(BL_MAC_WOL,ppc405_eth_wakeup,0,"OCP EMAC Wakeup",dev);
> 		request_irq(BL_MAL_SERR,ppc405_eth_serr,0,"OCP EMAC MAL SERR",dev);
> 		request_irq(BL_MAL_TXDE,ppc405_eth_txde,0,"OCP EMAC TX DE ",dev);
>
> 		request_irq(BL_MAL_RXDE,ppc405_eth_rxeob,0,"OCP EMAC RX DE",dev);
>
> 		request_irq(BL_MAL_TXEOB,ppc405_eth_txeob,0,"OCP EMAC TX EOB",dev);
> 		request_irq(BL_MAL_RXEOB,ppc405_eth_rxeob,0,"OCP EMAC RX EOB",dev);
> 	}
>
> ppc405_eth_rxeob is being registed twice, both for the MAL_RXEOB and
> for the MAL_RXDE interrupts, and ppc405_eth_rxde() is registered
> never.  Is there a reason for this, or is it just a bug?
>
> --
> David Gibson			| For every complex problem there is a
> david@gibson.dropbear.id.au	| solution which is simple, neat and
> 				| wrong.
> http://www.ozlabs.org/people/dgibson
>
>
>
>
>

David,

Its a bug Eugene pointed out to me a while back, patch tomorrow for this
and other changes Eugene sent me.

Armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
