Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	by ozlabs.org (Postfix) with ESMTP id 0D0EBDDE23
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 15:50:52 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 1/15] boot: find initrd location from device-tree
Date: Mon, 24 Sep 2007 00:50:47 -0500
References: <boot-8-00.miltonm@bga.com> <boot-8-01.miltonm@bga.com>
	<20070924025824.GD8058@localhost.localdomain>
In-Reply-To: <20070924025824.GD8058@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709240050.47891.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sunday 23 September 2007 9:58:24 pm David Gibson wrote:
> On Fri, Sep 21, 2007 at 06:03:24PM -0500, Milton Miller wrote:
> > Some platforms have a boot agent that can create or modify properties in
> > the device-tree and load images into memory.  Provide a helper to set
> > loader_info used by prep_initrd().
> >
> > Signed-off-by: Milton Miller <miltonm@bga.com>
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
>
> Hrm, despite my earlier ack, I'm going to whinge about a few nits
> here.
>
> > ---
> > re 12168
> > rediffed types.h, offset in ops.h
> >
> > Index: kernel/arch/powerpc/boot/ops.h
> > ===================================================================
> > --- kernel.orig/arch/powerpc/boot/ops.h	2007-09-17 22:12:47.000000000
> > -0500 +++ kernel/arch/powerpc/boot/ops.h	2007-09-17 22:12:51.000000000
> > -0500 @@ -163,6 +163,7 @@ void dt_fixup_clock(const char *path, u3
> >  void __dt_fixup_mac_addresses(u32 startindex, ...);
> >  #define dt_fixup_mac_addresses(...) \
> >  	__dt_fixup_mac_addresses(0, __VA_ARGS__, NULL)
> > +void dt_find_initrd(void);
> >
> >
> >  static inline void *find_node_by_linuxphandle(const u32 linuxphandle)
> > Index: kernel/arch/powerpc/boot/types.h
> > ===================================================================
> > --- kernel.orig/arch/powerpc/boot/types.h	2007-09-17 22:12:47.000000000
> > -0500 +++ kernel/arch/powerpc/boot/types.h	2007-09-17 22:12:51.000000000
> > -0500 @@ -12,6 +12,8 @@ typedef short			s16;
> >  typedef int			s32;
> >  typedef long long		s64;
> >
> > +#define UINT_MAX	0xFFFFFFFF
>
> I actually don't like this constant - at the point you compare you
> care, explicitly, about the value not being over 32-bits, rather than
> whether it fits a uint, so the named constant is more misleading than
> helpful.

Except int and uint are 32 bits on all targets, due to unix standardizing on 
LP64:

http://www.unix.org/whitepapers/64bit.html
http://www.unix.org/version2/whatsnew/lp64_wp.html

> > +/**
> > + * dt_find_initrd - set loader initrd location based on existing
> > properties + *
> > + * finds the linux,initrd-start and linux,initrd-end properties in
> > + * the /chosen node and sets the loader initrd fields accordingly.
> > + *
> > + * Use this if your loader sets the properties to allow other code to
> > + * relocate the tree and/or cause r3 and r4 to be set on true OF
> > + * platforms.
>
> I am unable to make sense of the paragraph above.

I think this means it finds the initrd location from the device tree (supplied 
by your firmware or bootloader) rather than from the kernel command line the 
way all the other platforms do.

Rob
-- 
"One of my most productive days was throwing away 1000 lines of code."
  - Ken Thompson.
