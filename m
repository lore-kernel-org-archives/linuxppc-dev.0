Return-Path: <tiejun.china@gmail.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 299A7DDE07
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 22:30:02 +1100 (EST)
From: tiejun.china@gmail.com
To: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org,
	akpm@linux-foundation.org, michael@ellerman.id.au
Subject: Re: [PATCH 1/1] Fix 64bit Mapple Host Bridge Address and Size Nodes
Date: Fri,  3 Apr 2009 18:46:33 +0800
Message-Id: <1238755594-18869-1-git-send-email-tiejun.china@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> > Thanks.
> > 

Firstly sorry for the delay response.

> > Now, is there any reason you can't fold the fix inside the existing
> > fixup_device_tree_maple() fixup ?  IE. Does it apply to any Maple board
> > or only this ATCA6101 ?
> > 

I really don't validate this on every Maple board since it's impossible to access them for me. I'm glad to improve everything if someone can hold my hand.

> > If not (if it does only apply to this specific board), then give the
> > function a better name, such as fixup_device_tree_atca6101() and make it
> > check for the /model property of the device-tree to make sure you only
> > hit that board and nothing else.
> > 

So I have to do the later as you said and please check my v1 patch.

Michael,

Fortunately this patch could be fix something as you expect when you comments one patch about CPC925 on atca6101.
Hope helpful!

Best Regards
Tiejun

> > Cheers,
> > Ben.
> >  
> > On Fri, 2009-02-27 at 09:55 +0800, Tiejun Chen wrote:
>> >>
>> >> 2009/2/27 Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> >>         On Thu, 2009-02-26 at 18:08 +0800, Tiejun Chen wrote:
>> >>         > In the DTB tree created by firmware on Maple 64bit target,
>> >>         host bridge
>> >>         > parent
>> >>         > node has specified both of these two properties to be 2.
>> >>         However, the
>> >>         > actual
>> >>         > "cell" value for host bridge node is 1. we have to provide
>> >>         one fixup
>> >>         > function.
>> >>         
>> >>         
>> >>         Hi !
>> >>         
>> >>         Thanks for the patch. A couple of things tho: Can you make it
>> >>         a bit
>> >>         more robust by properly checking the board type first ?
>> >>
>> >> That is ATCA 6101 and the following is from the MOTLoad firmware.
>> >> ------
>> >> Copyright Motorola Inc. 1999-2006, All Rights Reserved
>> >> MOTLoad RTOS Version 2.0,  PAL Version 1.1 RM01
>> >> Built on Tue Jun 13 10:31:56 EDT 2006 by q3316c
>> >> bbs 2.0 build 38
>> >>
>> >> Part Number          =01-W3930F04A
>> >> Serial Number        =0000001
>> >>
>> >> MPU-Type             =PPC970FX DD3.1
>> >> MPU-Int Clock Speed  =1800MHz
>> >> Memory Speed         =333MHz
>> >>
>> >> PCI bus instance 1   =64 bit, 100 MHz, PCI-X
>> >> PCI bus instance 2   =64 bit, 100 MHz, PCI-X
>> >> PCI bus instance 3   =64 bit, 100 MHz, PCI-X
>> >> PCI bus instance 4   =64 bit, 100 MHz, PCI-X
>> >> PCI bus instance 5   =32 bit, 33 MHz, PCI
>> >>
>> >> HT Link instance 1   =16 bit, 400 MHz
>> >> HT Link instance 2   = 8 bit, 600 MHz
>> >> HT Link instance 3   = 8 bit, 200 MHz
>> >>
>> >> MOTLoad FLASH Image  =FLASH Bank A
>> >>
>> >> Local Memory Found   =080000000 (&2147483648)
>> >> User Download Buffer =0611A5000:0613A4FFF
>> >> ------
>> >>
>> >> Here is some board information I can know:
>> >> ------
>> >> Board revision: 01
>> >> Boot loader version: 2.0
>> >> Silicon revision: 3.1 (pvr 003c 0301) 
>> >> ------
>> >>
>> >>
>> >>         
>> >>         
>> >>         Also, what is this "hostbridge" node ? ie, what does it
>> >>         represent ?
>> >>
>> >>  That means IBM CPC925 system controller resided on the ATCA 6101.
>> >>
>> >>
>> >>         
>> >>         
>> >>         Can you send me a full dump of /proc/device-tree from the
>> >>         machine ?
>> >>         (ie tar it up)
>> >>
>> >> See the attachment.
>> >>  
>> >>
>> >>         
>> >>         Finally, it looks like your patch was whitespace damaged by
>> >>         your mailer.
>> >>
>> >> After you confirm others is ok I will send v2 improved patch.
>> >>
>> >> Thanks & Best Regards
>> >> Tiejun
>> >>  
>> >>         
>> >>         Cheers,
>> >>         Ben.
>> >>         
>> >>         
>> >>         
>> >>         > Signed-off-by: Tiejun Chen <tiejun.china@gmail.com>
>> >>         > ---
>> >>         >  arch/powerpc/kernel/prom_init.c |   42
>> >>         > +++++++++++++++++++++++++++++++++++++++
>> >>         >  1 files changed, 42 insertions(+), 0 deletions(-)
>> >>         >
>> >>         > diff --git a/arch/powerpc/kernel/prom_init.c
>> >>         > b/arch/powerpc/kernel/prom_init.c
>> >>         > index 2445945..9cd23b6 100644
>> >>         > --- a/arch/powerpc/kernel/prom_init.c
>> >>         > +++ b/arch/powerpc/kernel/prom_init.c
>> >>         > @@ -1948,8 +1948,49 @@ static void __init
>> >>         > fixup_device_tree_maple(void)
>> >>         >        prom_setprop(isa, name, "ranges",
>> >>         >                        isa_ranges, sizeof(isa_ranges));
>> >>         >  }
>> >>         > +
>> >>         > +/* On Maple 64bit target host bridge parent node has
>> >>         specified
>> >>         > address and
>> >>         > + * size properties to be 2. But the actual "cell" value for
>> >>         host
>> >>         > bridge node
>> >>         > + * is 1 since early MOTLoad internal bug. */
>> >>         > +static void __init fixup_device_tree_maple_hb(void)
>> >>         > +{
>> >>         > +       phandle hb;
>> >>         > +       u32 hb_ranges[4];
>> >>         > +       u32 size_cell, addr_cell;
>> >>         > +       struct prom_t *_prom = &RELOC(prom);
>> >>         > +       char *name;
>> >>         > +
>> >>         > +       name = "/hostbridge@f8000000";
>> >>         > +       hb = call_prom("finddevice", 1, 1, ADDR(name));
>> >>         > +       if (!PHANDLE_VALID(hb))
>> >>         > +               return;
>> >>         > +
>> >>         > +       if (prom_getproplen(hb, "reg") != 8)
>> >>         > +               return;
>> >>         > +
>> >>         > +       if (prom_getprop(hb, "reg", hb_ranges,
>> >>         (sizeof(hb_ranges))/2)
>> >>         > +               == PROM_ERROR)
>> >>         > +               return;
>> >>         > +
>> >>         > +       prom_getprop(_prom->root, "#address-cells",
>> >>         &addr_cell,
>> >>         > sizeof(addr_cell));
>> >>         > +       prom_getprop(_prom->root, "#size-cells", &size_cell,
>> >>         > sizeof(size_cell));
>> >>         > +
>> >>         > +       if ((addr_cell != 2) || (size_cell != 2) ||
>> >>         > +               (hb_ranges[0] != 0xf8000000))
>> >>         > +               return;
>> >>         > +
>> >>         > +       prom_printf("Fixing up bogus HOSTBRIDGE reg on
>> >>         > Maple/Apache...\n");
>> >>         > +
>> >>         > +       hb_ranges[3] = hb_ranges[1];
>> >>         > +       hb_ranges[1] = hb_ranges[0];
>> >>         > +       hb_ranges[0] = hb_ranges[2] = 0;
>> >>         > +       prom_setprop(hb, name, "reg",
>> >>         > +               hb_ranges, sizeof(hb_ranges));
>> >>         > +}
>> >>         > +
>> >>         >  #else
>> >>         >  #define fixup_device_tree_maple()
>> >>         > +#define fixup_device_tree_maple_hb()
>> >>         >  #endif
>> >>         >
>> >>         >  #ifdef CONFIG_PPC_CHRP
>> >>         > @@ -2190,6 +2231,7 @@ static void __init
>> >>         fixup_device_tree_efika(void)
>> >>         >  static void __init fixup_device_tree(void)
>> >>         >  {
>> >>         >        fixup_device_tree_maple();
>> >>         > +       fixup_device_tree_maple_hb();
>> >>         >        fixup_device_tree_chrp();
>> >>         >        fixup_device_tree_pmac();
>> >>         >        fixup_device_tree_efika();
>> >>         > --
>> >>         > 1.5.6
>> >>         >
>> >>         >
>> >>         >
>> >>         
>> >>         
>> >>
> > 
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> > 
