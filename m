Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 385A7DDE0F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 09:21:58 +1000 (EST)
Date: Tue, 18 Sep 2007 09:55:03 -0500
From: Scott Wood <scottwood@freescale.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: [PATCH 23/28] mpc82xx: Define CPU_FTR_NEED_COHERENT
Message-ID: <20070918145503.GG441@ld0162-tx32.am.freescale.net>
References: <20070917165643.GA6545@loki.buserror.net>
	<20070917165815.GW6563@loki.buserror.net>
	<DCEAAC0833DD314AB0B58112AD99B93B0360A803@ismail.innsys.innovsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0360A803@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 18, 2007 at 09:34:31AM -0500, Rune Torgersen wrote:
> > -----Original Message-----
> > From: Scott Wood
> > Sent: Monday, September 17, 2007 11:58 AM
> > 
> > The 8272 (and presumably other PCI PQ2 chips) appear to have the
> > same issue as the 83xx regarding PCI streaming DMA.
> > 
> 
> Can you explain what this isssue is? We're using a 8280 and have had
> some PCI busmaster DMA problems, and wonder if it is related.

I'm not sure of the details, just that I get corrupted PCI DMA if I don't
set it.

BTW, if the problems you're seeing include lockups when using PCI DMA,
check out the end of the PCI initialization in
arch/powerpc/boot/cuboot-pq2.c; it requires certain non-default arbiter
settings.

-Scott
