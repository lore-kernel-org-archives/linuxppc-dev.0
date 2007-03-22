Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC30ADE09E
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 03:22:46 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l2MGMe0G000508
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 09:22:41 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l2MGMeBN029435
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 11:22:40 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2MG2iZK016335
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 11:02:44 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 90B83AEFC9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 11:22:39 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2MGMdwG020618
	for linuxppc-dev@ozlabs.org; Thu, 22 Mar 2007 11:22:39 -0500
Date: Thu, 22 Mar 2007 11:22:39 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 05/17] bootwrapper: misc device tree fixes
Message-ID: <20070322162239.GA20185@ld0162-tx32.am.freescale.net>
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172845.GE29784@ld0162-tx32.am.freescale.net>
	<20070321015104.GC27969@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321015104.GC27969@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 12:51:04PM +1100, David Gibson wrote:
> On Fri, Mar 16, 2007 at 12:28:45PM -0500, Scott Wood wrote:
> > 1. The dtb should be generated in $tmpdir, rather than the current directory.
> > Normally, $tmpdir is ".", so it doesn't matter, but the wrapper should obey
> > the -W option if it should be passed.
> 
> This is still wrong (or at least insufficient).  If we're building
> with a target directory different from the source directory we
> shouldn't add anything to the source directory, but $tmpdir still
> will.

No, it won't.  The current directory is the object directory.  I tested
it.

The tmpdir thing wasn't to fix that (since it's not broken); it was just
something I'd noticed when I was looking over the script.

> > 2. DTC has a habit of complaining about errors which are not really
> > errors.  Thus, the -f option is now passed to it, to force it to generate
> > output regardless.
> 
> I'd really prefer not to add -f by default.  I think getting rid of
> the bogus warnings from dtc is a better idea.

I agree, and have posted a patch to DTC do this.

-Scott
