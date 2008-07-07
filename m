Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 731C3DDE03
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 16:34:13 +1000 (EST)
Subject: Re: [PATCH] powerpc: reduce code duplication in legacy_serial, add
	UART parent types
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <Pine.LNX.4.64.0801250216530.9153@blarg.am.freescale.net>
References: <200801172335.48817.arnd@arndb.de>
	<12011947821738-git-send-email-paul.gortmaker@windriver.com>
	<20080124224043.GA418@windriver.com>
	<Pine.LNX.4.64.0801250216530.9153@blarg.am.freescale.net>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 16:33:46 +1000
Message-Id: <1215412426.8970.97.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, Paul Gortmaker <paul.gortmaker@windriver.com>,
	arnd@arndb.de, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-01-25 at 02:17 -0600, Kumar Gala wrote:
> > The legacy_serial was treating each UART parent in a separate code block.
> > Rather than continue this trend for the new parent IDs, this condenses
> > all (soc, tsi, opb, plus two more new types) into one of_device_id array.
> > The new types are wrs,epld-localbus for the Wind River sbc8560, and a
> > more generic "simple-bus" as requested by Scott Wood.
> >
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  arch/powerpc/kernel/legacy_serial.c |   45 +++++++++++++---------------------
> >  1 files changed, 17 insertions(+), 28 deletions(-)
> >
> applied

(Catching that old patch on patchworks by accident)

Hrm... please next time don't take patches to generic stuff like
legacy_serial through your tree. This one has definitely not been
properly reviewed.

In this case, there are at least two problems with the patch:

- The parents array should be called something better, as-is, go figure
where you crashed when all you find is a symbol called "parents"

- The array isn't terminated (or did I miss something ?) which means
that non-matching parents will probably crash.

Ben.
