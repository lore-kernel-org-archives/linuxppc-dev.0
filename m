Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 330041A075F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 20:11:48 +1000 (AEST)
Date: Fri, 17 Jul 2015 20:09:31 +1000
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, tytso@mit.edu, herbert@gondor.apana.org.au,
 mpm@selenic.com, hpa@linux.intel.com, keescook@chromium.org
Subject: Re: [PATCH] powerpc: Use hardware RNG for arch_get_random_seed_* not
 arch_get_random_*
Message-ID: <20150717100931.GC5916@iris.ozlabs.ibm.com>
References: <20150717091558.GA5916@iris.ozlabs.ibm.com>
 <20150717093757.GA15502@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150717093757.GA15502@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 17, 2015 at 04:37:57AM -0500, Segher Boessenkool wrote:
> On Fri, Jul 17, 2015 at 07:15:58PM +1000, Paul Mackerras wrote:
> > @@ -7,13 +7,22 @@
> >  
> >  static inline int arch_get_random_long(unsigned long *v)
> >  {
> > +	return 0;
> > +}
> > +
> > +static inline int arch_get_random_int(unsigned int *v)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline int arch_get_random_seed_long(unsigned long *v)
> > +{
> >  	if (ppc_md.get_random_long)
> >  		return ppc_md.get_random_long(v);
> 
> You probably want to change that last name (ppc_md.get_random_long) then?
> Pretty confusing like this :-)

Fair point.  New patch coming.

Paul.
