Return-Path: <sr@denx.de>
Received: from natfrord.rzone.de (natfrord.rzone.de [81.169.145.161])
	by ozlabs.org (Postfix) with ESMTP id 48C2D680F3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Sep 2005 23:51:47 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 19 Sep 2005 15:51:43 +0200
References: <004101c5bd1f$3d1b91e0$dbe5fed4@scsad.scs.ch>
In-Reply-To: <004101c5bd1f$3d1b91e0$dbe5fed4@scsad.scs.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Message-Id: <200509191551.44266.sr@denx.de>
Cc: Peter Fercher <peter.fercher@scs.ch>
Subject: Re: emac driver broken in 2.6.12.2 ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Peter,

On Monday 19 September 2005 15:37, Peter Fercher wrote:
> i have problems with the IBM EMAC with 2.6.12.2 (the driver worked with
> 2.4.25)
> running on ppc405EP octobus board. Cross compiled on x86 using the eldk-3.1
> toolchain
>
> any hints ?
>
> emac: IBM EMAC Ethernet driver, version 2.0
>
> Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
>
> eth0: IBM emac, MAC 00:00:00:00:00:00
>
> eth0: Found Generic MII PHY (0x00)
>
> eth1: IBM emac, MAC 00:00:00:00:00:00
>
> eth1: Found Generic MII PHY (0x01)

Looks like your board platform file is not copying the MAC addresses into the 
ocp struct. Take a look at bubinga_setup_arch() in platforms/4xx/bubinga.c. 
Here ibm_ocp_set_emac() is used to copy the addresses.

Best regards,
Stefan
