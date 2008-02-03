Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 60989DDDEC
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Feb 2008 18:35:46 +1100 (EST)
Subject: RE: Kernel oops while duming user core.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rune Torgersen <runet@innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03EE4A90@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B03EE46B8@ismail.innsys.innovsys.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE47A4@ismail.innsys.innovsys.com>
	<20080131201601.GA10501@loki.buserror.net>
	<20080131204158.GV14201@localdomain> <47A235AD.9050107@freescale.com>
	<47A24480.8060103@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03EE4A90@ismail.innsys.innovsys.com>
Content-Type: text/plain
Date: Sun, 03 Feb 2008 18:34:24 +1100
Message-Id: <1202024064.7208.6.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Nathan Lynch <ntl@pobox.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-01-31 at 16:10 -0600, Rune Torgersen wrote:
> Scott Wood wrote:
> > Scott Wood wrote:
> >> Nathan Lynch wrote:
> >>> Is the crashing program multithreaded?  The first report had firefox
> >>> triggering the oops.
> >> 
> >> OK, I've got a test program that triggers it now.  I'll see if I can
> >> figure out what's going on.
> > 
> > The problem seems to be that update_mmu_cache() is called on a guard
> > page with no access rights. 
> > 
> > Changing update_mmu_cache() to always call flush_dcache_icache_page()
> > fixes it, though a better performing fix would probably be to add an
> > exception table entry for the dcbst.
> 
> I can confirm that this seems to fix it.

Might be better to avoid the flush when the page isn't readable ?

Ben.
