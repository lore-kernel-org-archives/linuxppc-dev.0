Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 414DBDDEDC
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Oct 2007 08:43:41 +1000 (EST)
Subject: Re: [PATCH 2 6/7] Uartlite: Add of-platform-bus binding
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40710020910u3a679ea2m15b005d0ba5fb054@mail.gmail.com>
References: <20070930224117.1871.87164.stgit@trillian.cg.shawcable.net>
	<20070930224208.1871.2913.stgit@trillian.cg.shawcable.net>
	<1191304386.6310.92.camel@pasglop>
	<fa686aa40710020726s330d586p6ece70ae378f1206@mail.gmail.com>
	<871wcd33ux.fsf@macbook.be.48ers.dk>
	<fa686aa40710020910u3a679ea2m15b005d0ba5fb054@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 03 Oct 2007 08:43:32 +1000
Message-Id: <1191365012.22572.33.camel@pasglop>
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


> My opinion is that since it is driver-specific code anyway, then it
> belongs with the driver.  Plus a driver writer for ARM doesn't need to
> write them.  It's the powerpc or microblaze developer who will do it.
> If the driver maintainer doesn't want the binding in the main driver
> .c file, then the binding can easily be in an additional .c file
> without needing to add a constructor.  (Kind of like how many USB host
> controllers are managed)

The main advantage is that it keeps the OF specific code localized to a
single function, whether that function lives in the driver or the arch
code, it makes it self contained and easier to deal with by the driver
author.

Having multiple device types on which the driver can attach is a pain
from a driver standpoint. It needs multiple
probe/remove/suspend/resume/shutdown hooks etc... it's a bigger
maintainance burden in the long run.

The important thing however, with the constructor approach is to try as
much as possible to keep the proper tree structure, and thus, try to
find a way to instanciate the devices with proper parent/child
relationship so that ordering for things like suspend/resume operations
is maintained.

Ben.
