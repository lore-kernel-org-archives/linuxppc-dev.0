Return-Path: <dgibson@ozlabs.org>
Date: Tue, 29 May 2007 15:34:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Don't use HOSTCFLAGS in BOOTCFLAGS
Message-ID: <20070529053445.GD30266@localhost.localdomain>
References: <20070529032924.GA30266@localhost.localdomain>
	<d35e07648ef5813bd9e3572eec36bfb3@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d35e07648ef5813bd9e3572eec36bfb3@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 29, 2007 at 07:12:21AM +0200, Segher Boessenkool wrote:
> >  #	To this end we need to define BOOTCC, etc, as the tools
> > -#	needed to build the 32 bit image.  These are normally HOSTCC,
> > +#	needed to build the 32 bit image.
> >  #	but may be a third compiler if, for example, you are cross
> 
> You've broken this comment, you should pay for it now :-)

Eck, yes.

> > -HOSTCC		:= gcc
> > -BOOTCFLAGS	:= $(HOSTCFLAGS) -fno-builtin -fno-unit-at-a-time 
> > -nostdinc -isystem \
> > -		   $(shell $(CROSS32CC) -print-file-name=include) -fPIC
> > +BOOTCFLAGS	:= -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
> > +		   -fno-strict-aliasing -O2 -msoft-float -pipe \
> 
> -Os instead?

Hrm, yeah, that's probably a good idea.

> > +		   -fomit-frame-pointer -fno-builtin -fno-unit-at-a-time \
> 
> Why -fno-unit-at-a-time ?

Crap.  Because I forgot that the patch stack I was working on had my
patch which adds -fno-unit-at-a-time (I often use that when debugging,
because it makes the disassembly more comprehensible).  In fact
without that patch, this one doesn't apply.

> > +		   -fPIC -nostdinc \
> > +		   -isystem $(shell $(CROSS32CC) -print-file-name=include)
> 
> Also, is there any reason why you can't simply use $(CC) -m32 with
> the kernel $(CFLAGS) ?

I did think about that.  But the kernel CFLAGS does includes
-ffixed-r2 and -Iarch/powerpc which I don't think we want here.

Revised version coming shortly.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
