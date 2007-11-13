Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 139A9DDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 10:46:40 +1100 (EST)
Message-ID: <473A3760.2090807@freescale.com>
Date: Tue, 13 Nov 2007 17:46:40 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] powerpc: Add support for PORTA and PORTB odr registers
References: <4739ECDA.4010200@scram.de>
In-Reply-To: <4739ECDA.4010200@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: paulus@samba.org, linux-kernel@vger.kernel.org,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> @@ -474,6 +481,12 @@ static void cpm1_set_pin16(int port, int pin, int 
> flags)
>     else
>         clrbits16(&iop->par, pin);
> 
> +    if (port == CPM_PORTA) {
> +        if (flags & CPM_PIN_OPENDRAIN)
> +            setbits16(&iop->odr, pin);
> +        else
> +            clrbits16(&iop->odr, pin);
> +    }
>     if (port == CPM_PORTC) {
>         if (flags & CPM_PIN_SECONDARY)
>             setbits16(&iop->sor, pin);

Where is the odr field of cpm_ioport16 defined?  It's the same position 
as sor, so maybe call it odr_sor or something.

Also, please add an extra newline after the closing brace.

-Scott
