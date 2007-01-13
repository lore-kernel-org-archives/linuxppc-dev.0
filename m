Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3C852DDDFF
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Jan 2007 07:40:19 +1100 (EST)
Subject: Re: [PATCH 2/7] Powerpc MSI implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20070113192734.GA30867@kroah.com>
References: <1168514716.63474.857278133999.qpush@cradle>
	<20070111112503.0CC1BDDF13@ozlabs.org>
	<20070111194427.GA20450@kroah.com>
	<1168550403.22458.414.camel@localhost.localdomain>
	<1168552498.22458.428.camel@localhost.localdomain>
	<20070112231317.GC665@kroah.com>
	<1168667863.5011.44.camel@localhost.localdomain>
	<20070113192734.GA30867@kroah.com>
Content-Type: text/plain
Date: Sun, 14 Jan 2007 07:40:15 +1100
Message-Id: <1168720815.5011.70.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olof Johannsson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I'm saying I don't want to see 2 different MSI implementations in the
> kernel.  I'm sure you can understand this reasoning.
> 
> I misunderstood your original patches in that I thought you were
> cleaning up the generic versions for everyone, not creating a separate
> set of APIs.  Sorry for the misunderstanding.

It's not a separate set of APIs. The APIs are the same (as far as
drivers are concerned). We are providing a new "core" that indeed aims
are replacing the current one (and provides the same APIs to drivers).

We have two backends implemented for it for now, soon 3 as I need to
write one for Cell blades.

So at this point we have three possible approaches:

 1- We can put it entirely in arch/powerpc. You NAKed the few generic
changes to pci.h but we can hide that in sysdata or some other ppc
specific stuff hanging off pci_dev. That is maybe the easiest approach
for us to at least have MSI support in 2.6.21. (We really do need MSI
support in urgently).

 2- We can put it as I suggested and you just NAKed in
drivers/pci/msi-new.c along with our new backends. Thus, Kconfig defines
wether the old core is used (Intel,Altix) or the new core. I still feel
that's the best option as it makes it easier for other archs (including
Intel & Altix) to port MSI support to the new infrastructure as it will
be there. Maybe the best approach is to compromise here and do that, but
keep it in -mm until Intel and Altix are ported over in which case it
can be merged in linus tree.

 3- We can keep it out of tree and try to work with others to have Intel
and Altix stuff ported over out of tree, until we have a new patch which
completely replaces the existing stuff.

I still think it's better to have the new core in -mm before everything
is ported to it though.

Ben.
