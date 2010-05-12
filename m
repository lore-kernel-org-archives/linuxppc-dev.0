Return-Path: <horms@verge.net.au>
Received: from kirsty.vergenet.net (kirsty.vergenet.net [202.4.237.240])
	by ozlabs.org (Postfix) with ESMTP id B7A0FB7E0E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 May 2010 23:37:40 +1000 (EST)
Date: Wed, 12 May 2010 22:19:03 +0900
From: Simon Horman <horms@verge.net.au>
To: Maxim Uvarov <muvarov@gmail.com>
Subject: Re: [PATCH 1/2] Fix kexec on powerpc32
Message-ID: <20100512131902.GA8109@verge.net.au>
References: <20100511174749.19309.44615.stgit@muvarov>
	<4BEA2375.7040802@nerdbynature.de>
	<AANLkTimSATEKI4TdO6zNWSRzl2on4OL5D2GGBlVsndMs@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTimSATEKI4TdO6zNWSRzl2on4OL5D2GGBlVsndMs@mail.gmail.com>
Cc: Christian Kujau <lists@nerdbynature.de>, linuxppc-dev@lists.ozlabs.org,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 12, 2010 at 10:31:26AM +0400, Maxim Uvarov wrote:
> 2010/5/12 Christian Kujau <lists@nerdbynature.de>
> 
> > Maxim Uvarov wrote on 2010-05-11 10:47 :
> > > This patch is required in case if you are using new toolchains.
> >
> > I'm on Debian/stable (binutils 2.18, gcc 4.3.2), so I applied your patches
> > to the latest -git checkout:
> >
> > First, compilation fails with:
> >
> > cc1: warnings being treated as errors
> > kexec/arch/ppc/kexec-ppc.c: In function ‘get_base_ranges’:
> > kexec/arch/ppc/kexec-ppc.c:258: error: value computed is not used
> > make: *** [kexec/arch/ppc/kexec-ppc.o] Error 1
> >
> > Somehow a "-" hyphen made it into one of the functions:
> >
> > > --- a/kexec/arch/ppc/kexec-ppc.c
> > > +++ b/kexec/arch/ppc/kexec-ppc.c
> > [...]
> > >                       if (local_memory_ranges >= max_memory_ranges) {
> > > -                             fclose(file);
> > > -                             break;
> > > +                             if (realloc_memory_ranges() < 0){
> > > +     -                               fclose(file);
> >
> > Oh, I sent this patch twice with stg -a by mistake. And second version has
> "-". I will fix and resend patches.
> 
> >
> > Removing this, gets me further, until:
> >
> >
> > purgatory/arch/ppc/crt.o: In function `__lshrdi3':
> > (.text+0xf0): multiple definition of `__lshrdi3'
> > purgatory/arch/ppc/misc.o:(.text+0x50): first defined here
> > collect2: ld returned 1 exit status
> > make: *** [purgatory/purgatory.ro] Error 1
> >
> > And has been defined in purgatory/arch/ppc/crt.S and
> > ./purgatory/arch/ppc/misc.S. Removing it from e.g. crt.S
> > makes it compile, I have not tested it yet, though :-)
> >
> 
> Yes, that is expected result for old tool chains. New tool chains (from code
> sourcery )  need this crt.S.
> I think we can have --with-oldtoolchain option to configure to point to old
> tool chains. (or even rename it to --with-crts,
> I don't know what is better.)

I think --with-crts would be better as --with-oldtoolchain could
mean many things.
