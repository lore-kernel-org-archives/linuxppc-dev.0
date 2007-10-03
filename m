Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.233])
	by ozlabs.org (Postfix) with ESMTP id C8A53DDE19
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 00:39:02 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so3622965wxd
	for <linuxppc-dev@ozlabs.org>; Wed, 03 Oct 2007 07:39:02 -0700 (PDT)
Message-ID: <fa686aa40710030739k13e05571l7063aa635a8727dc@mail.gmail.com>
Date: Wed, 3 Oct 2007 08:39:01 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2 6/7] Uartlite: Add of-platform-bus binding
In-Reply-To: <1191385456.22572.45.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
	<20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>
	<1191304386.6310.92.camel@pasglop>
	<fa686aa40710020726s330d586p6ece70ae378f1206@mail.gmail.com>
	<871wcd33ux.fsf@macbook.be.48ers.dk>
	<fa686aa40710020910u3a679ea2m15b005d0ba5fb054@mail.gmail.com>
	<1191365012.22572.33.camel@pasglop>
	<fa686aa40710022118r170ab652mdd65c216304b3330@mail.gmail.com>
	<1191385456.22572.45.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/2/07, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> On Tue, 2007-10-02 at 22:18 -0600, Grant Likely wrote:
>
> > For many drivers, I think that is already the case.  USB OHCI is a
> > prime example where there are both PCI and platform_bus bindings among
> > others.  It seems to me that the bus binding effectively translates
> > down to "where do I go to get the needed information".  I think it
> > results in less of a maintenance burden to explicitly separate bus
> > binding from device setup as opposed to adding constructor code.
>
> I think nobody consider the mess that is USB in that are to be something
> we want to reproduce.

Heh, true, but the structure of multiple bus bindings is probably not
something we can get away from.

>
> > > The important thing however, with the constructor approach is to try as
> > > much as possible to keep the proper tree structure, and thus, try to
> > > find a way to instanciate the devices with proper parent/child
> > > relationship so that ordering for things like suspend/resume operations
> > > is maintained.
> >
> > I'm not sure I follow.  Example?
>
> Well, make sure that if 2 platform devices repreesnt respectively a bus
> and a device on that bus, they properly get instanciated as parent &
> child in sysfs as well.

Right, okay.  Looking at platform_device_add(), the default parent is
platform_bus, but it can be overridden.  of_platform_bus devices get
the hierarchy of the device tree by default.  So in the platform bus
case, the constructor would need to explicitly set the parent device?
Correct?

Also, how do you see the constructor code getting executed?  Called
explicitly from the platform code, or some form of auto binding?  I
look at fsl_soc.c and I shudder as each constructor does a pass of the
whole tree looking for compatible nodes.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
