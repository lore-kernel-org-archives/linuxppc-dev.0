Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD45011C477@NTSERVER4>
From: linuxppc <linuxppc@4bridgeworks.com>
To: Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Fix for 440GX in RGMII mode (RE: 440gx gigabit)
Date: Wed, 4 Aug 2004 16:38:51 +0100 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Thought I'd send this out for all to see, until an official fix gets placed
in the 2.6 tree

Daren

> -----Original Message-----
> From: Ralph Siemsen [mailto:rsiemsen@rossvideo.com]
> Sent: 04 August 2004 14:44
> To: mporter@kernel.crashing.org
> Cc: Neil Wilson; Daren Hayward
> Subject: Re: 440gx gigabit
>
>
> Ralph Siemsen wrote:
>
> > Tomorrow I will try and figure out how the proper values
> should get in
> > that register.
>
> Well this turned out to be pretty straightforward.  The
> emac_rgmii_port_speed() function in
> drivers/net/ibm_emac/ibm_emac_core.c
> does the register setting, based upon values several arrays:
> rgmii_speed_mask[], rgmii_speed_100[] and rgmii_speed_1000[].
>
> The problem is that the indexing into these arrays does not match how
> they are actually populated.  As written we have:
>
> static unsigned int rgmii_speed100[] = {
> 	0,
>          0,
>          RGMII_MII2_100MB,
>          RGMII_MII3_100MB
> };
>
> That is fine, since EMAC2 and EMAC3 are the gigabit ports;
> however, the
> numbering of inputs on the RGMII bridge begins at zero and there are
> only two inputs:
>
> emac: IBM EMAC Ethernet driver, version 2.0
> Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org> [...]
> zmii0: input 2 in SMII mode
> rgmii0: input 0 in RGMII mode                <---- **** INPUT 0
> eth2: IBM emac, MAC 00:20:05:ff:00:3e
> eth2: Found CIS8201 Gigabit Ethernet PHY (0x10)
> zmii0: input 3 in SMII mode
> rgmii0: input 1 in RGMII mode                <---- **** INPUT 1
> eth3: IBM emac, MAC 00:20:05:ff:00:3f
> eth3: Found CIS8201 Gigabit Ethernet PHY (0x18)
>
> So slots 2 and 3 are never used in the rgmii data
> structures... however
> that is where the proper bit definitions are... as a result, we read
> only the zero fields, and the RGMII_SSR register never gets changed.
>
> Quick fix is to write [input + 2] in the emac_rgmii_port_speed()
> function... With this small change, all the ethernet ports
> work great on
> my IBM EVP board.
>
> Not sure how the official fix should go... I'm inclined to say that
> RGMII_INPUTS should be defined as 2 (not 4) and the
> structures should be
> collapsed down, leaving off the 0 elements.  But perhaps Matt had his
> reasons for making it 4 like the other structures...
>
> -Ralph
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
