Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 367D7DDE3A
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 10:20:04 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id l8M0K6qH012986
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 10:20:06 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l8M0Nc2g212318
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 10:23:38 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l8M0K33a011478
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 10:20:04 +1000
Date: Sat, 22 Sep 2007 10:19:56 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Matt Tyrlik <tyrlik@us.ibm.com>
Subject: Re: DTC Patch for Cygwin
Message-ID: <20070922001956.GA28045@localhost.localdomain>
References: <20070921184639.GA23906@ld0162-tx32.am.freescale.net>
	<OFF6527B59.0D9695D8-ON8525735D.006AC05C-8525735D.006C3903@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFF6527B59.0D9695D8-ON8525735D.006AC05C-8525735D.006C3903@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 03:42:04PM -0400, Matt Tyrlik wrote:
> >Scott Wood <scottwood@freescale.com> wrote on 09/21/2007 02:46:39 PM:
> > On Fri, Sep 21, 2007 at 11:26:04AM -0400, Matt Tyrlik wrote:
> > >
> > > Changes required to compile DTC under Cygwin

A S-o-b line will be needed before this can be applied.

> > >
> > > ===================================================================
> > > --- dtc-org.orig/tests/supernode_atdepth_offset.c
> > > +++ dtc-org/tests/supernode_atdepth_offset.c
> > > @@ -63,8 +63,11 @@ int path_prefix(const char *path, int de
> > >                 return 1;
> > >
> > >         p = path;
> > > -       for (i = 0; i < depth; i++)
> > > -               p = strchrnul(p+1, '/');
> > > +       for (i = 0; i < depth; i++) {
> > > +               p = strchr(p+1, '/');
> > > +               if (!p)
> > > +                       p = path + strlen(path);
> > > +       }
> > >
> > >         return p - path;
> > >  }
> >
> > Maybe we should define strchrnul under #ifndef GLIBC, similar to
> > strndupa?
> Since this is used only in one place David Gibson suggested that the
> change should be done in code.

Yeah, I don't actually particularly care which way we go with this one.

> > > Index: dtc-org/tests/testutils.c
> > > ===================================================================
> > > --- dtc-org.orig/tests/testutils.c
> > > +++ dtc-org/tests/testutils.c
> > > @@ -52,10 +52,9 @@ static void sigint_handler(int signum, s
> > >  void test_init(int argc, char *argv[])
> > >  {
> > >         int err;
> > > -       struct sigaction sa_int = {
> > > -               .sa_sigaction = sigint_handler,
> > > -       };
> > > +       struct sigaction sa_int;
> > >
> > > +       sa_int.sa_sigaction = sigint_handler,
> > >         test_name = argv[0];
> >
> > What version of GCC does cygwin use?  That doesn't seem like something
> > that should break due to OS differences.
> >
> > -Scott
> Currently 3.4.4. The compiler can't handle unnamed union in an
> initializer.

Or at least that's my surmise, I can't see why else it would be
breaking.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
