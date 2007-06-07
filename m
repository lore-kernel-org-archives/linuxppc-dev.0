Return-Path: <SRS0+8f2be1f524bb961c24bd+1383+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [209.217.80.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C1016DDF04
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 00:54:10 +1000 (EST)
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1180904670.31677.18.camel@localhost.localdomain>
References: <7fc919fce0761f861be3069a853d3169@bga.com>
	<1180769992.14025.1.camel@localhost.localdomain>
	<4662E7EA.70506@ru.mvista.com>
	<d067769912d2ed5c9e1b4770b77303dd@kernel.crashing.org>
	<46630256.8050909@ru.mvista.com>
	<1180904670.31677.18.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Jun 2007 15:53:58 +0100
Message-Id: <1181228038.2785.54.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, linux-mtd@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-06-04 at 07:04 +1000, Benjamin Herrenschmidt wrote:
> So you are saying that because the current linux MTD stuff can only
> probe (which doesn't always work), we should not put the proper chip
> interface type in the device-tree ?
> 
> Your argument makes no sense to me.
> 
> Put the proper interface informations in the device-tree, maybe some OS
> smarter than linux will make good use on it and maybe linux will be
> fixed at one point too (not by you, of course, you gave us that line
> often enough about not being paid to do the right thing).

In general, Linux is doing the right thing by probing.

There are two major command sets for NOR flash -- the Intel/Sharp
command set, and the AMD/Fujitsu command set.

There are also two major ways to detect flash chips -- the JEDEC probe
with magic numbers for mfr/chip ident, and the CFI ('Common Flash
Interface') probe which gets you tables of information about the chip,
including what optional command set extensions it has, etc.

You _can_ bypass the probe and pass straight through to the 'back-end'
chip driver. But unless you provide the CFI information you won't get to
use any of the optional chip features (or blacklist some of the
known-broken features). It doesn't make a lot of sense to try using the
back-end chip drivers directly. Just go through the normal probe
process, really.

If you really want to bypass the probe, then I suspect you want the full
CFI tables to be present in your OF properties.

-- 
dwmw2
