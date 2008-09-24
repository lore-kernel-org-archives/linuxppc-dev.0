Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7CF0FDDE1E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Sep 2008 16:29:25 +1000 (EST)
Subject: Re: Regarding select() on PPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200809240823.12484.arnd@arndb.de>
References: <7B7EF7F090B9804A830ACC82F2CDE95D56E206@insardxms01.ap.sony.com>
	<1222160853.12085.136.camel@pasglop> <200809240823.12484.arnd@arndb.de>
Content-Type: text/plain
Date: Wed, 24 Sep 2008 16:28:59 +1000
Message-Id: <1222237739.8277.62.camel@pasglop>
Mime-Version: 1.0
Cc: "Sadashiiv, Halesh" <halesh.sadashiv@ap.sony.com>,
	linuxppc-embedded@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 2008-09-24 at 08:23 +0200, Arnd Bergmann wrote:
> On Tuesday 23 September 2008, Benjamin Herrenschmidt wrote:
> > 
> > > Means argument checking in ppc_select() can be removed??
> > > Than shall I post patch to linuxppc-dev@ozlabs.org
> > 
> > ppc_select can probably be removed alltogether and ppc32_select too
> 
> I think ppc32_select needs to stay. It never did the hack for
> supporting the old_select calling conventions, but it does the
> sign extension for the 32 bit arguments, which I think you still
> want.

Why do we want it ?

It's an int, it's zero extended, but that should still be a valid signed
32 bits int in compat_sys_select() or do I miss something ?
 
Ben.

> In any way, both the 32 bit emulation and the native ppc32 code
> path should do the same thing, which currently they don't.
> 
> 	Arnd <><
