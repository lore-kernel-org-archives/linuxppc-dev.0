Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 37546140082
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 May 2014 22:23:04 +1000 (EST)
Message-ID: <1400156571.397.42.camel@pasglop>
Subject: Re: powerpc/ppc64: Allow allmodconfig to build (finally !)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 15 May 2014 22:22:51 +1000
In-Reply-To: <53749B0E.4050900@roeck-us.net>
References: <1399874254.17624.85.camel@pasglop>
 <20140513002846.GA29753@roeck-us.net> <1399972601.17624.169.camel@pasglop>
 <20140513171749.GA9440@roeck-us.net>
 <20140514133434.13b66009@canb.auug.org.au> <5372FC43.6010707@roeck-us.net>
 <20140514055219.GL5162@bubble.grove.modra.org>
 <20140514153430.GA28553@roeck-us.net>
 <20140515094716.GQ5162@bubble.grove.modra.org>
 <53749B0E.4050900@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org,
 Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-05-15 at 03:46 -0700, Guenter Roeck wrote:
> On 05/15/2014 02:47 AM, Alan Modra wrote:
> > On Wed, May 14, 2014 at 08:34:30AM -0700, Guenter Roeck wrote:
> >> Bummer. Confirmed, if I replace "@h" with "@high" in just one place,
> >> the builds pass with binutils 2.24. Unfortunately the same builds then
> >> fails with binutils 2.23.
> >>
> >> Any idea how to get it to compile with both old and new versions ?
> >
> > The standard way with GNU software would be to write a configure test,
> > that checks for @high support in the assembler, and defines a macro
> > if the assembler passes the check.  I'm not that familiar with the
> > linux kernel these days, but a little grepping around says that
> > something like
> >
> > ashigh := $(call as-instr,lis 9$(comma)foo@high,-DHAVE_AS_ATHIGH=1)
> > KBUILD_AFLAGS += $(ashigh)
> >
> > might work.
> >
> 
> Yes, it does.

Care to send a patch ? :-)

Cheers,
Ben.
