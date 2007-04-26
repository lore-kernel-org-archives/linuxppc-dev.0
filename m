Return-Path: <mb@bu3sch.de>
Received: from vs166246.vserver.de
	(static-ip-62-75-166-246.inaddr.intergenia.de [62.75.166.246])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4604ADDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 19:45:32 +1000 (EST)
From: Michael Buesch <mb@bu3sch.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [2.6.22] pasemi: hardware rng driver
Date: Thu, 26 Apr 2007 11:23:57 +0200
References: <20070425204512.GB19781@lixom.net>
	<200704260138.32220.arnd@arndb.de>
In-Reply-To: <200704260138.32220.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704261123.58032.mb@bu3sch.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, egor@pasemi.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 April 2007 01:38:31 Arnd Bergmann wrote:
> On Wednesday 25 April 2007, Olof Johansson wrote:
> 
> > +static void __iomem *rng_regs;
> > +
> > +static int pasemi_rng_data_present(struct hwrng *rng)
> > +{
> > +	return (in_le32(rng_regs + SDCRNG_CTL_REG)
> > +		& SDCRNG_CTL_FVLD_M) ? 1 : 0;
> > +}
> 
> It would be nicer to get rid of the global rng_regs variable by sticking
> it into rng->priv.

Yeah, I think that would be better. Saves one global variable.


-- 
Greetings Michael.
