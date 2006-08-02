Return-Path: <mgreer@mvista.com>
Date: Wed, 2 Aug 2006 09:40:30 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 1/6] bootwrapper: arch/powerpc/boot code reorg
Message-ID: <20060802164030.GB17652@mag.az.mvista.com>
References: <20060719230014.GB3887@mag.az.mvista.com>
	<17616.12251.339657.215571@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17616.12251.339657.215571@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 02:53:47PM +1000, Paul Mackerras wrote:
> Mark A. Greer writes:
> 
> > Abstract the operations used in the bootwrapper.  The operations
> > have been divided up into platform ops (platform_ops), firware ops
> > (fw_ops), device tree ops (dt_ops), and console ops (console_ops).
> 
> Overall the approach looks good.
> 
> The ops structure seems like a reasonable concept, but I question
> whether we need to have platform_ops separate from fw_ops, since the
> firmware is essentially part of the implementation of the platform.

Sometimes the people run different fw's on the same platform.  An
example is the sandpoint which comes with DINK but others run uboot on
it.

> Also I don't see why we need to do a double indirection to get to each
> ops function.

Okay.

> Also, we will probably want to create some directory structure under
> arch/powerpc/boot in the longer term.

Agreed.

> > +#ifdef __powerpc64__
> > +typedef unsigned long		u64;
> > +#else
> > +typedef unsigned long long	u64;
> > +#endif
> 
> This is potentially confusing, because the __powerpc64__ relates to
> the boot wrapper not the kernel, and we don't build a 64-bit boot
> wrapper on any platform (not yet anyway).  Maybe this needs a comment.

Okay.

Mark
