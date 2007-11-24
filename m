Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (pip15.gyao.ne.jp [61.122.117.253])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E92D0DDE33
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Nov 2007 18:26:19 +1100 (EST)
Date: Sat, 24 Nov 2007 16:26:13 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC][PATCH 0/3] OF-platform PATA driver
Message-ID: <20071124072613.GA7303@linux-sh.org>
References: <20071123175229.GA27143@localhost.localdomain>
	<4747751D.4060802@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4747751D.4060802@garzik.org>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 23, 2007 at 07:49:33PM -0500, Jeff Garzik wrote:
> Anton Vorontsov wrote:
> >Here is the PATA Platform driver using OF infrastructure.
> >
> >Mostly it's just a wrapper around a bit modified pata_platform
> >driver.
> >
> >Patches are well split for the easier review:
> >
> >First one factors out platform_device specific bits and modifies
> >pata_platform to be a library-alike driver (with platform_device
> >default binding).
> >
The only issue I have here is that this library-like version has subtle
semantic changes that will break existing drivers.

irq_flags exists in struct pata_platform_info precisely for the IRQ
resource IRQ flags (as opposed to the IORESOURCE flags, which are what
the IRQ resource flags refer to instead). This change takes that for
granted and just assumes we're going to be using the res->flags, which is
both an invalid assumption, and will utterly break blackfin and others
that depend on it.

Incidentally, we already have an include/linux/pata_platform.h. If this
is going to be library-like, through the prototypes in there, rather than
splitting them up betewen include/linux and drivers/ata. We don't need
two headers.

These patches basically look fine to me otherwise, though it would be
nice if the semantic-changing bits had been abstracted. So as long as the
old irq_flags behaviour is maintained and that irq_res->flags stuff is
ripped out, I'll add my Acked-by as well.
