Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Feb 2007 11:17:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 11/16] zImage wrapper for Ebony
Message-ID: <20070214001710.GC11491@localhost.localdomain>
References: <20070213061025.6EB43DDD0C@ozlabs.org>
	<45D1EFBC.7040805@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45D1EFBC.7040805@am.sony.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2007 at 09:05:00AM -0800, Geoff Levand wrote:
> David Gibson wrote:
> > This patch adds support for building a zImage wrapper suitable for the
> > Ebony (440GP) evaluation board.  This supports booting both from uboot
> > (old versions which don't supply a flattened device tree) and IBM
> > Openbios (aka "treeboot").
> 
> > +++ working-2.6/arch/powerpc/boot/Makefile	2007-02-12 14:22:17.000000000 +1100
> > -src-plat := of.c
> > +src-plat := of.c ebony.c
> >  src-boot := crt0.S $(src-wlib) $(src-plat) empty.c
> 
> 
> Could this be better as:
> 
> src-plat-$(CONFIG_44x) += ebony.c
> src-plat := of.c $(src-plat-y)
> 
> 
> >  src-boot := $(addprefix $(obj)/, $(src-boot))
> > @@ -94,6 +94,12 @@ $(patsubst %.S,%.o, $(filter %.S, $(src-
> >  $(obj)/wrapper.a: $(obj-wlib)
> >  	$(call cmd,bootar)
> >  
> > +quiet_cmd_dtc = DTC     $@
> > +      cmd_dtc = $(dtc) -O dtb -o $@ -b 0 -V 16 $<
> > +
> > +$(obj)/%.dtb: $(srctree)/$(src)/dts/%.dts
> > +	$(call if_changed,dtc)
> > +
> 
> 
> If dtc is not installed will this create an empty dtb file that ends
> up getting used?  If so, try something like this:

Um.. no.  How would dtc create a file if it wasn't there..?

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
