Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/9] powerpc: Add macros to access floating point
	registers in thread_struct.
In-reply-to: <1DD06CDB-428E-4832-93CA-6F0404CA6692@kernel.crashing.org> 
References: <20080625040718.028B470296@localhost.localdomain>
	<F09034D9-1B3C-4087-B6DF-FAB7B3AFA191@kernel.crashing.org>
	<48626588.8050202@freescale.com> <20080625161255.GA12165@iram.es>
	<48626FA9.8010903@freescale.com>
	<1DD06CDB-428E-4832-93CA-6F0404CA6692@kernel.crashing.org>
Date: Thu, 26 Jun 2008 10:09:33 +1000
Message-ID: <16449.1214438973@neuling.org>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1DD06CDB-428E-4832-93CA-6F0404CA6692@kernel.crashing.org> you wrote:
> 
> On Jun 25, 2008, at 11:17 AM, Scott Wood wrote:
> 
> > Gabriel Paubert wrote:
> >> On Wed, Jun 25, 2008 at 10:34:32AM -0500, Scott Wood wrote:
> >>> Kumar Gala wrote:
> >>>>> +/* Macros to workout the correct index for the FPR in the  
> >>>>> thread struct */
> >>>>> +#define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
> >>>>> +#define FPRHALF(i) (((i) - PT_FPR0) % 2)
> >>>> Have you looked at what the compiler spits out here to make sure  
> >>>> we aren't getting a divide?  Seems like we could use '& 0x1'.
> >>> GCC's not *that* dumb.  However, you may get some unnecessary sign- 
> >>> twiddling if "i" is signed.
> >> Not for modulo 2, it's only an even/odd choice and GCC implements  
> >> that efficiently IIRC. For other powers of 2,
> >> making the left hand side unsigned helps the compiler.
> >
> > From this:
> >
> > int foo(int x)
> > {
> > 	return x % 2;
> > }
> >
> > I get this with -O3:
> >
> > foo:
> >        mr 0,3
> >        srawi 3,3,1
> >        addze 3,3
> >        slwi 3,3,1
> >        subf 3,3,0
> >        blr
> >        .size   foo, .-foo
> >        .ident  "GCC: (GNU) 4.1.2"
> >
> > Changing it to "x & 1", or to unsigned, gives this:
> >
> > foo:
> >        rlwinm 3,3,0,31,31
> >        blr
> >        .size   foo, .-foo
> >        .ident  "GCC: (GNU) 4.1.2"
> >
> > Maybe newer GCCs are better?
> 
> Nope. gcc-4.3.0 from fedora 9:
> 
> foo:
>          mr 0,3
>          srawi 3,3,1
>          addze 3,3
>          slwi 3,3,1
>          subf 3,3,0
>          blr
> 
> bar:
>          rlwinm 3,3,0,31,31
>          blr
> 
> if you make 'x' unsigned things are better.

I've changed it to '& 0x1', which compiles to something better here.

Mikey
