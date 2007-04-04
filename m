Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33FB7DDE9F
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 11:14:12 +1000 (EST)
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1175645568.10567.42.camel@shinybook.infradead.org>
References: <1175642916.10567.24.camel@shinybook.infradead.org>
	<20070403212928.GA12951@cynthia.pants.nu>
	<1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403.170212.02298297.davem@davemloft.net>
	<1175645568.10567.42.camel@shinybook.infradead.org>
Content-Type: text/plain
Date: Wed, 04 Apr 2007 11:13:12 +1000
Message-Id: <1175649192.30879.19.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-03 at 20:12 -0400, David Woodhouse wrote:
> On Tue, 2007-04-03 at 17:02 -0700, David Miller wrote:
> > Sparc does the same thing, it's a common convention and you really
> > should not break it.
> 
> I thought that argument was lost many years ago. It _used_ to be a
> common convention; we got better.
> 
> > Every powerpc and sparc system out that is using ttyS0 with dynamic
> > minor numbers being allocated.  I really think this should be
> > generalized instead of breaking serial on every powerpc machine out
> > there.
> 
> Nobody's breaking anything. The patch _fixes_ serial, and allows powerpc
> machines to use both z8530 and 8250 ports at the same time; something
> which has been broken for a long time.

It worked before the new serial core, we had a "tweak" in the old 8250
driver to be able to share minors, but that got busted when Russell
rewrote the whole thing. I remember asking him back when he still was
the serial maintainer, and he refused to bring back some sharing of
minors.

Ben.
