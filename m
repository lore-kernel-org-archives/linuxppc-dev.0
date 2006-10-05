Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4AC5767DC7
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Oct 2006 16:51:57 +1000 (EST)
Subject: Re: [PATCH 10/11] Add MPC8360EMDS board support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20061005063304.GD1985@gate.ebshome.net>
References: <4879B0C6C249214CBE7AB04453F84E4D19D865@zch01exm20.fsl.freescale.net>
	<20060927165556.04c8d5d7@vitb.ru.mvista.com>
	<CE624A83-809E-4180-800E-660A578FFCFC@embeddedalley.com>
	<20060927112201.293fef44@localhost.localdomain>
	<EBD0615C-4F22-430F-BD23-1283DF98F1B3@embeddedalley.com>
	<1159942128.13323.21.camel@localhost.localdomain>
	<7BD0D5CE-7BA3-43DC-B972-B75672F6A31E@embeddedalley.com>
	<1160005019.5887.30.camel@localhost.localdomain>
	<20061005062105.GA1985@gate.ebshome.net>
	<1160029594.22232.22.camel@localhost.localdomain>
	<20061005063304.GD1985@gate.ebshome.net>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 16:51:35 +1000
Message-Id: <1160031095.22232.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-10-04 at 23:33 -0700, Eugene Surovegin wrote:
> On Thu, Oct 05, 2006 at 04:26:34PM +1000, Benjamin Herrenschmidt wrote:
> > 
> > Regarding the "mess", it's the whole #ifdef junk in there that is
> > driving me nuts and that I'll rip appart probably next week. A lot of
> > this could be soft-tests or the ifdefs could be resolved at Kconfig
> > instead of having a list of processors in 3 different headers if you
> > really want to compile the changes in rather than do soft-tests.
> 
> Well, sent me changes for review, or become a maintainer, but this 
> time _real_ maintainer, not like last time when you touched this code.

Well, last time I touched this code, I took something that was not
working at all and made it work for me and a couple of other people that
were working on it at the same time. If it had issues, they were never
reported to me back then. However, I never intended to do long term
maintainership of this driver and that was clear from the very
beginning. If you ran into other issues and fixed them afterward, that's
fine, but don't blame me for not fixing issues I didn't encounter nor
was told about for the short time while I was taking care of it.

Anyway, my point is, the per-processor ifdef lists are just fugly and
need to be turned into "soft" changes. The driver also needs to get some
OF probing and use the new DCR accessors to move over to powerpc and to
work with the EMAC cell within the new Cell southbridge.

I have some preliminary patches doing just the OF probing and DCR
changes. I still want to do some serious change of the #ifdef mess into
something more flexible to allow for runtime choice of the type of EMAC
and MAL.

I'll post patches (and possibly incremental "cleanup") to the list,
CC'ing you, as expected for a driver you maintain.

Ben.
