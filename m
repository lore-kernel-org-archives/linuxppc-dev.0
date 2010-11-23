Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25DB9B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Nov 2010 08:10:47 +1100 (EST)
Subject: Re: [PATCH v1] ppc44x:PHY fixup for USB on canyonlands board
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <201011231421.02377.sr@denx.de>
References: <201011231256.oANCur3N016433@amcc.com>
	<201011231421.02377.sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Nov 2010 08:10:21 +1100
Message-ID: <1290546621.32570.85.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Rupjyoti Sarmah <rsarmah@amcc.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rsarmah@apm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > +	setbits8(&bcsr[7], BCSR_USB_EN);
> > +	udelay(100000);
> > +
> > +	clrbits8(&bcsr[7], BCSR_USB_EN);
> > +	udelay(100000);
> 
> Thats a total bootup delay of 200ms. Is this really needed?

In addition, so large delays should use msleep() if possible (depends
how early we are here).

Cheers,
Ben,

> And I suggest to add a few comments to the code explaining why exactly you are 
> setting/clearing the bits in the BCSR and the GPIO registers.

Seconded,

Cheers,
Ben.
