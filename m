Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4BAB4DDEE4
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 02:16:27 +1000 (EST)
Message-ID: <46C1D553.4000201@freescale.com>
Date: Tue, 14 Aug 2007 11:16:19 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] [UPDATED] tsec: Allow Ten Bit Interface to be configurable
References: <1187044669.10295.4.camel@server>	<3FE16C0A-892F-4481-999A-A699C0C70BF9@kernel.crashing.org>	<013b01c7de23$5baa7d70$6f00a8c0@ESIDT>
	<1B668DF2-9909-4D43-AAFF-3A2ADFA283B2@freescale.com>
In-Reply-To: <1B668DF2-9909-4D43-AAFF-3A2ADFA283B2@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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

Andy Fleming wrote:
> It's actually a per-tsec property.  There's not one tbi, there's one  
> per TSEC.  The one on TSEC 0 is special in that it can interfere with  
> PHYs on the MDIO bus.
> 
> So I would suggest making it a property of the ethernet node:
> 
> ethernet@24000 {
> ...
> tbipa = <1f>;
> ...
> }

"tbipa" isn't likely to pass the Segher test. :-)

If the TBI address is in PHY-space, then it should go in the MDIO bus. 
For the second TSEC, create a second MDIO bus node.

-Scott
