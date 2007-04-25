Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 808C5DDF2F
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 08:48:05 +1000 (EST)
Subject: Re: [PATCH 3/6] Consolidate of_find_property
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20070425.152419.110959714.davem@davemloft.net>
References: <c249005137aa3e50c25221f6849a70ea@kernel.crashing.org>
	<462F93F0.5090608@genesi-usa.com>
	<1177539404.14873.199.camel@localhost.localdomain>
	<20070425.152419.110959714.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 08:47:45 +1000
Message-Id: <1177541265.14873.222.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-25 at 15:24 -0700, David Miller wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Thu, 26 Apr 2007 08:16:44 +1000
> 
> > On Wed, 2007-04-25 at 18:46 +0100, Matt Sealey wrote:
> > 
> > > Can't the ata/ATA thing be fixed by simply fixing device trees where it
> > > happens? strncmp seems the standards-compliant route to take.. why clutter
> > > the common parsing routines with fixes for deviant platforms?
> > 
> > In that specific case, it's even fixed by having the driver have both
> > spellings in it's match list.
> 
> This is something I'd like to avoid.
> 
> Initially I added sparc OFW property support to the Radeon
> driver by checking for both the upper-case and lower-case
> variants of all the property names.
> 
> It was beyond ugly.

Well, I think we are mixing several things in the same pot here :-)

 - property names. That's what you had to deal with for Sparc. I think
it's fair enough to use strcasecmp for these. They are supposed to not
have case, while they happen to do here or there, there is almost no
chance of conflict (several properties with a name differring only by
the case).

 - property content. (That include node names which are really only the
content of the "name" property of that node). The ATA/ata case was for
property content in fact (name property and type property iirc) which is
a different thing and must be kept case sensitive I beleive. That covers
the case of of_device_is_compatible() which should use strcmp (or the
-n- version of it of course).

Do we agree on that ?

Cheers,
Ben.
