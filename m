Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFBBA1A00C5
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 12:56:40 +1000 (AEST)
Message-ID: <1443668200.17980.1.camel@ellerman.id.au>
Subject: Re: [v2,5/5] powerpc/pseries: re-use code from of_helpers module
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Segher Boessenkool
 <segher@kernel.crashing.org>,  nfont@linux.vnet.ibm.com
Date: Thu, 01 Oct 2015 12:56:40 +1000
In-Reply-To: <1443629978.8361.316.camel@linux.intel.com>
References: <20150814115200.0F4E1140293@ozlabs.org>
 <1443629978.8361.316.camel@linux.intel.com>
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

On Wed, 2015-09-30 at 19:19 +0300, Andy Shevchenko wrote:
> On Fri, 2015-08-14 at 21:51 +1000, Michael Ellerman wrote:
> > On Tue, 2015-11-08 at 11:23:09 UTC, Andy Shevchenko wrote:
> > >  int dlpar_attach_node(struct device_node *dn)
> > >  {
> > >  	int rc;
> > >  
> > > -	dn->parent = derive_parent(dn->full_name);
> > > -	if (!dn->parent)
> > > -		return -ENOMEM;
> > > +	dn->parent = pseries_of_derive_parent(dn->full_name);
> > > +	if (IS_ERR(dn->parent))
> > > +		return PTR_ERR(dn_parent);
> >                                  ^
> > 				 ?
> > 
> > There are cross compilers on kernel.org, or on Ubuntu you can just:
> > 
> > $ apt-get install gcc-powerpc-linux-gnu
> > $ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-gcc
> 
> Thanks! I tried today and the above the only problem with the series.
> Would you like me to resend whole series?

I'd like someone to test it. I gather that you haven't because it didn't
compile.

I assume you don't have access to hardware to test it on?

cheers
