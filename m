Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E81B8DDDFC
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 14:24:32 +1000 (EST)
Subject: Re: [PATCH 2 6/7] Uartlite: Add of-platform-bus binding
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40710022118r170ab652mdd65c216304b3330@mail.gmail.com>
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
	<20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>
	<1191304386.6310.92.camel@pasglop>
	<fa686aa40710020726s330d586p6ece70ae378f1206@mail.gmail.com>
	<871wcd33ux.fsf@macbook.be.48ers.dk>
	<fa686aa40710020910u3a679ea2m15b005d0ba5fb054@mail.gmail.com>
	<1191365012.22572.33.camel@pasglop>
	<fa686aa40710022118r170ab652mdd65c216304b3330@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 03 Oct 2007 14:24:16 +1000
Message-Id: <1191385456.22572.45.camel@pasglop>
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


On Tue, 2007-10-02 at 22:18 -0600, Grant Likely wrote:

> For many drivers, I think that is already the case.  USB OHCI is a
> prime example where there are both PCI and platform_bus bindings among
> others.  It seems to me that the bus binding effectively translates
> down to "where do I go to get the needed information".  I think it
> results in less of a maintenance burden to explicitly separate bus
> binding from device setup as opposed to adding constructor code.

I think nobody consider the mess that is USB in that are to be something
we want to reproduce.

> > The important thing however, with the constructor approach is to try as
> > much as possible to keep the proper tree structure, and thus, try to
> > find a way to instanciate the devices with proper parent/child
> > relationship so that ordering for things like suspend/resume operations
> > is maintained.
> 
> I'm not sure I follow.  Example?

Well, make sure that if 2 platform devices repreesnt respectively a bus
and a device on that bus, they properly get instanciated as parent &
child in sysfs as well.

Ben.
