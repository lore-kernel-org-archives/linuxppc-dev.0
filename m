Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [128.224.252.2])
	by ozlabs.org (Postfix) with ESMTP id 5B8CDDE49C
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 01:04:27 +1000 (EST)
Date: Mon, 7 Jul 2008 11:02:48 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: reduce code duplication in legacy_serial, add
	UART parent types
Message-ID: <20080707150245.GA17307@windriver.com>
References: <200801172335.48817.arnd@arndb.de>
	<12011947821738-git-send-email-paul.gortmaker@windriver.com>
	<20080124224043.GA418@windriver.com>
	<Pine.LNX.4.64.0801250216530.9153@blarg.am.freescale.net>
	<1215412426.8970.97.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1215412426.8970.97.camel@pasglop>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: Re: [PATCH] powerpc: reduce code duplication in legacy_serial, add UART parent types
on 07/07/2008 Benjamin Herrenschmidt wrote:

> On Fri, 2008-01-25 at 02:17 -0600, Kumar Gala wrote:
> > > The legacy_serial was treating each UART parent in a separate code block.
> > > Rather than continue this trend for the new parent IDs, this condenses
> > > all (soc, tsi, opb, plus two more new types) into one of_device_id array.
> > > The new types are wrs,epld-localbus for the Wind River sbc8560, and a
> > > more generic "simple-bus" as requested by Scott Wood.
> > >
> > > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > > ---
> > >  arch/powerpc/kernel/legacy_serial.c |   45 +++++++++++++---------------------
> > >  1 files changed, 17 insertions(+), 28 deletions(-)
> > >
> > applied
> 
> (Catching that old patch on patchworks by accident)
> 
> Hrm... please next time don't take patches to generic stuff like
> legacy_serial through your tree. This one has definitely not been
> properly reviewed.
> 
> In this case, there are at least two problems with the patch:
> 
> - The parents array should be called something better, as-is, go figure
> where you crashed when all you find is a symbol called "parents"

While looking around at what other names were used, I saw the ibmebus
used an equally non-descript name too, so I'll fix that as well.  Patch
to follow shortly.

Thanks,
Paul.

> 
> - The array isn't terminated (or did I miss something ?) which means
> that non-matching parents will probably crash.
> 
> Ben.
> 
> 
