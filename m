Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id D7FA61A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 18:39:35 +1000 (AEST)
Message-ID: <1443688770.8361.318.camel@linux.intel.com>
Subject: Re: [v2,5/5] powerpc/pseries: re-use code from of_helpers module
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Denis Kirjanov <kda@linux-powerpc.org>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
Date: Thu, 01 Oct 2015 11:39:30 +0300
In-Reply-To: <CAOJe8K1qga-K0Nf=W1h7uP_Rr+w2akH4ES+PGmkSJTLTbL8oPg@mail.gmail.com>
References: <20150814115200.0F4E1140293@ozlabs.org>
 <1443629978.8361.316.camel@linux.intel.com>
 <1443668200.17980.1.camel@ellerman.id.au>
 <CAOJe8K1qga-K0Nf=W1h7uP_Rr+w2akH4ES+PGmkSJTLTbL8oPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-10-01 at 10:02 +0300, Denis Kirjanov wrote:
> On 10/1/15, Michael Ellerman <mpe@ellerman.id.au> wrote:
> > On Wed, 2015-09-30 at 19:19 +0300, Andy Shevchenko wrote:
> > > On Fri, 2015-08-14 at 21:51 +1000, Michael Ellerman wrote:
> > > > On Tue, 2015-11-08 at 11:23:09 UTC, Andy Shevchenko wrote:
> > > > >  int dlpar_attach_node(struct device_node *dn)
> > > > >  {
> > > > >  	int rc;
> > > > > 
> > > > > -	dn->parent = derive_parent(dn->full_name);
> > > > > -	if (!dn->parent)
> > > > > -		return -ENOMEM;
> > > > > +	dn->parent = pseries_of_derive_parent(dn
> > > > > ->full_name);
> > > > > +	if (IS_ERR(dn->parent))
> > > > > +		return PTR_ERR(dn_parent);
> > > >                                  ^
> > > > 				 ?
> > > > 
> > > > There are cross compilers on kernel.org, or on Ubuntu you can 
> > > > just:
> > > > 
> > > > $ apt-get install gcc-powerpc-linux-gnu
> > > > $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-gcc
> > > 
> > > Thanks! I tried today and the above the only problem with the 
> > > series.
> > > Would you like me to resend whole series?
> > 
> > I'd like someone to test it. I gather that you haven't because it 
> > didn't
> > compile.
> 
> Oh yeah, totally untested:
> 
>   CC      arch/powerpc/platforms/pseries/dlpar.o
> arch/powerpc/platforms/pseries/dlpar.c: In function 
> 'dlpar_attach_node':
> arch/powerpc/platforms/pseries/dlpar.c:255:18: error: 'dn_parent'
> undeclared (first use in this function)
>    return PTR_ERR(dn_parent);
>                   ^
> arch/powerpc/platforms/pseries/dlpar.c:255:18: note: each undeclared
> identifier is reported only once for each function it appears in
> scripts/Makefile.build:258: recipe for target
> 'arch/powerpc/platforms/pseries/dlpar.o' failed
> make[2]: *** [arch/powerpc/platforms/pseries/dlpar.o] Error 1
> scripts/Makefile.build:403: recipe for target
> 'arch/powerpc/platforms/pseries' failed
> make[1]: *** [arch/powerpc/platforms/pseries] Error 2
> Makefile:941: recipe for target 'arch/powerpc/platforms' failed
> make: *** [arch/powerpc/platforms] Error 2

Like I mentioned earlier this is the only one issue to compile the
series. Can you fix it and try on real HW?

> 
> > 
> > I assume you don't have access to hardware to test it on?
> > 
> > cheers
> > 
> > 
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
