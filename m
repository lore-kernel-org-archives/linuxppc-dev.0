Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9CAAFDDEBF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 27 Sep 2007 06:42:40 +1000 (EST)
Date: Wed, 26 Sep 2007 15:41:56 -0500
From: Scott Wood <scottwood@freescale.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: [PATCH4/4] [POWERPC] Fix cpm_uart driver
Message-ID: <20070926204156.GA15217@loki.buserror.net>
References: <46F6C9DC.90008@scram.de> <46F8101E.1050000@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B0368C44B@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0368C44B@ismail.innsys.innovsys.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Sep 26, 2007 at 03:32:29PM -0500, Rune Torgersen wrote:
> > From: Scott Wood
> > Maybe that's how it was, but the current code initializes it (more or
> > less) directly with IMAP_ADDR, which also gets fed into ioremap.
> > 
> > One of the two has got to be wrong.
> 
> arch/ppc maps the immr area 1:1 into kernel memory, so ioremap and
> physical are the same.
> See arch/ppc/syslib/m8260_setup.c, line 208 (function m8260_map_io)

We were talking about 8xx, not 82xx -- is it always identity mapped there?

If so, then why bother with the ioremap in immr_map_size() in
arch/ppc/8xx_io/commproc.c?  And why compare the result from ioremap() with
a raw identity-mapped address?

-Scott
