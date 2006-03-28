Return-Path: <listmember@orkun.us>
Received: from www65.dixiesys.com (ns65a.dixiesys.com [65.254.42.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 46456679FF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 05:17:08 +1100 (EST)
Message-ID: <44297979.2050206@orkun.us>
Date: Tue, 28 Mar 2006 11:59:21 -0600
From: Tolunay Orkun <listmember@orkun.us>
MIME-Version: 1.0
To: Jeff.Fellin@rflelect.com
Subject: Re: PPC405EP and Abatron BDI help
References: <OF3A743E50.87BEEA66-ON8525713F.00587402@teal.com>
In-Reply-To: <OF3A743E50.87BEEA66-ON8525713F.00587402@teal.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi,

I am also involved in bring up effort of a 405EP board (in-house 
developed). We had 3rd party 405GP boards before so I expected bring up 
to be less rocky but there are some subtle differences to note.

Are you configuring the PerWE* and PerCS* properly?

1) You need to set CPC0_PCI[SPE] bit to set PerWE* as output for CS0 
(So, you can write your Flash connected to CS0. Note that this is DCR 
0x0F9. There are incorrect references in the manual as the register 
number is 0x0F4 (which is PLLMR1)

2) You need to program GPIO pins to alternate functions via GPIO0 
registers (Read Chapter 23 of 405EP manual) otherwise you will not sett 
CS* asserted for your devices (except CS0). For example, for CS1 you 
need to set GPIO10 to alternate function.

On the 405GP these would normally be configured CPC0_CR0/1. 405EP 
probably does not use these registers at all (well, the CPC0_CR 
registers are not documented in 405EP manual except two places make 
refer to it: table 3-6 and 12.2.1 Timer Base Counter -- someone else 
could chime on this)

3) Of course you need to configure EBC0_BnCR and EBC0_BnAP as 
appropriate to your peripheral as well.

Best regards,
Tolunay

Jeff.Fellin@rflelect.com wrote:
> I'm not sure if this forum can help me, but perhaps someone has experience
> with
> using an Abatron BDI2000 to control an AMCC PPC405EP evaluation board. I am
> having problems with getting the BDI to access devices on the external bus.
> I have verifed the EBC settings are correct by comparing them to the values
> set by Uboot 1.1.2 (Jun 2, 2005 Rev B) running on the board.
> 
> I have used the base bubinga.cfg , Stefan Roese's configuration file, sent
> to me
> from someone on this mailing list. I modified the configuration to match
> the external
> device configuration of the AMCC PPC405EP evaluation board.
> 
> Any ideas as to why I cannot access devices on the external bus using the
> BDI,
> but Uboot can?
> 
> 
>  Jeff Fellin
> RFL Electronics
> Jeff.Fellin@rflelect.com
> 973 334-3100, x 327
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
