Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D6DE267B54
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jun 2006 08:13:28 +1000 (EST)
Subject: Re: MSI support on Linux PCI implementation for Ocotea
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Shawn Jin <shawnxjin@gmail.com>
In-Reply-To: <c3d0340b0606161445w5acb4da8j26870f56a4bf4d9@mail.gmail.com>
References: <c3d0340b0606151414q6d218554j255fa74a68a5c9af@mail.gmail.com>
	<1150413771.7725.20.camel@localhost.localdomain>
	<c3d0340b0606161445w5acb4da8j26870f56a4bf4d9@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 17 Jun 2006 08:13:17 +1000
Message-Id: <1150495997.23600.52.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-06-16 at 14:45 -0700, Shawn Jin wrote:
> Hi Ben,
> 
> > Now, regarding MSI, as you have noticed, the situation isn't great. I'm
> > currently in the middle of reworking our interrupt management (and
> > interrupt numbers allocation layer) and Michael Ellermann is looking at
> > the MSI issue in parallel.
> 
> Just one point about MSI(-X) message address and data format. I think
> it should be the platform that defines the content.

That's an obvious requirement :)

> Current
> implementation doesn't have this flexibility. We have a design where
> MSI mode uses message data to carry vector number info while MSI-X
> mode uses message address to carry this info. Although it seems
> strange, but I think it's allowed by the spec.

The current implementation is bad :) There are some patches for altix
that are in -mm that add some platform hooks that make the situation a
little bit better, but it's still far from perfect.

Ben.
