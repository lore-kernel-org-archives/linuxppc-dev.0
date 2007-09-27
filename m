Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EEA73DDDF8
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Sep 2007 08:45:16 +1000 (EST)
Subject: Re: 2.6.23-rc8 dies somewhere during boot!?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
In-Reply-To: <20070927222733.201970@gmx.net>
References: <20070927191233.201980@gmx.net>
	<20070927192551.GK7970@austin.ibm.com> <20070927193131.201920@gmx.net>
	<20070927205012.GN7970@austin.ibm.com> <20070927211700.201970@gmx.net>
	<20070927213503.GA18686@austin.ibm.com> <20070927215735.201960@gmx.net>
	<20070927222007.GE18686@austin.ibm.com> <20070927222733.201970@gmx.net>
Content-Type: text/plain
Date: Fri, 28 Sep 2007 08:39:43 +1000
Message-Id: <1190932783.6158.39.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-09-28 at 00:27 +0200, Gerhard Pircher wrote:
> -------- Original-Nachricht --------
> > Datum: Thu, 27 Sep 2007 17:20:07 -0500
> > Von: linas@austin.ibm.com
> > An: Gerhard Pircher <gerhard_pircher@gmx.net>
> > CC: linuxppc-dev@ozlabs.org
> > Betreff: Re: 2.6.23-rc8 dies somewhere during boot!?
> 
> > On Thu, Sep 27, 2007 at 11:57:35PM +0200, Gerhard Pircher wrote:
> > 
> > The last identifiable message I was
> > 
> > <7>PCI: Calling quirk...
> > 
> > which is from drivers/pci/quirks.c
> > 
> > ...CI: Found 0000:00:07.2 [1106/303...
> > 
> > and this is from pci_setup_device() in drivers/pci/probe.c  So I'd look
> > to see if pci_setup_device() ever returned, and then I'd look to see
> > what happened next.
> Ah, I thought probing is done in the architecture's PCI code. I'll take
> a look at pci_setup_device() function.

It's one of the quirks I suppose. Those are often full of x86 only
bogoziness that hurts everybody else if you happen to hit them.

The "late" quirks are called at pci_enable_device() time.

Ben
