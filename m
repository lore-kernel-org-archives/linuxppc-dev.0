Return-Path: <glikely@secretlab.ca>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.232])
	by ozlabs.org (Postfix) with ESMTP id C8240DDE02
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 14:18:11 +1000 (EST)
Received: by nz-out-0506.google.com with SMTP id i1so3090087nzh
	for <linuxppc-dev@ozlabs.org>; Tue, 02 Oct 2007 21:18:11 -0700 (PDT)
Message-ID: <fa686aa40710022118r170ab652mdd65c216304b3330@mail.gmail.com>
Date: Tue, 2 Oct 2007 22:18:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: benh@kernel.crashing.org
Subject: Re: [PATCH 2 6/7] Uartlite: Add of-platform-bus binding
In-Reply-To: <1191365012.22572.33.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
	<20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>
	<1191304386.6310.92.camel@pasglop>
	<fa686aa40710020726s330d586p6ece70ae378f1206@mail.gmail.com>
	<871wcd33ux.fsf@macbook.be.48ers.dk>
	<fa686aa40710020910u3a679ea2m15b005d0ba5fb054@mail.gmail.com>
	<1191365012.22572.33.camel@pasglop>
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
> > My opinion is that since it is driver-specific code anyway, then it
> > belongs with the driver.  Plus a driver writer for ARM doesn't need to
> > write them.  It's the powerpc or microblaze developer who will do it.
> > If the driver maintainer doesn't want the binding in the main driver
> > .c file, then the binding can easily be in an additional .c file
> > without needing to add a constructor.  (Kind of like how many USB host
> > controllers are managed)
>
> The main advantage is that it keeps the OF specific code localized to a
> single function, whether that function lives in the driver or the arch
> code, it makes it self contained and easier to deal with by the driver
> author.
>
> Having multiple device types on which the driver can attach is a pain
> from a driver standpoint. It needs multiple
> probe/remove/suspend/resume/shutdown hooks etc... it's a bigger
> maintainance burden in the long run.

For many drivers, I think that is already the case.  USB OHCI is a
prime example where there are both PCI and platform_bus bindings among
others.  It seems to me that the bus binding effectively translates
down to "where do I go to get the needed information".  I think it
results in less of a maintenance burden to explicitly separate bus
binding from device setup as opposed to adding constructor code.

> The important thing however, with the constructor approach is to try as
> much as possible to keep the proper tree structure, and thus, try to
> find a way to instanciate the devices with proper parent/child
> relationship so that ordering for things like suspend/resume operations
> is maintained.

I'm not sure I follow.  Example?

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
