Return-Path: <peri@aqua.aspd.pwr.wroc.pl>
Received: from aqua.aspd.pwr.wroc.pl (aqua.aspd.pwr.wroc.pl [156.17.17.24])
	by ozlabs.org (Postfix) with ESMTP id 2CE3F2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Sep 2004 01:48:00 +1000 (EST)
Date: Tue, 28 Sep 2004 17:47:57 +0200 (CEST)
From: Piotr Perak <peri@aqua.aspd.pwr.wroc.pl>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20040928064442.A31883@home.com>
Message-ID: <Pine.LNX.4.21.0409281735560.6394-100000@aqua.aspd.pwr.wroc.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6.x on 405CR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



On Tue, 28 Sep 2004, Matt Porter wrote:

> On Tue, Sep 28, 2004 at 11:57:44AM +0200, Piotr Perak wrote:
> > Because I use ibm405cr.c which works good with 2.4.23 I think that's not
> > the problem. Remember the call stack?
> 
> Which 2.4 tree?  linux-2.4, linuxppc-2.4, and linuxppc_2_4_devel haven't
> had explicit 405cr support that I've noticed. Since the ocp layer has
> changed that would leave open the possibility of a problem in translating
> the support to the new ocp layer.

linux-2.4 ported to our board some time ago.  

> 
> > setup_arch() - arch/ppc/kernel/setup.c
> >   -> ocp_early_init() - arch/ppc/syslib/ocp.c
> >     -> ocp_add_one_device() - arch/ppc/syslib/ocp.c
> >       ->  alloc_bootmem MACRO calling __alloc_bootmem_core() -
> > mm/bootmem.c
> > 
> > When I comment line calling ocp_early_init() I fail in:
> >  
> > setup_arch() - arch/ppc/kernel/setup.c
> >   -> paging_init() - arch/ppc/mm/init.c
> >     -> free_area_init() - arch/ppc/mm/page_alloc.c
> >       -> free_area_init_node() - arch/ppc/mm/page_alloc.c
> >         -> alloc_bootmem_node() MACRO calling __alloc_bootmem_node -
> > mm/bootmem.c
> >           -> __alloc_bootmem_core() - mm/bootmem.c
> > 
> > As you can see again __alloc_bootmem_core. So maybe there's some
> > problem with memory?
> 
> Hrm, I see. Did your firmware change between your working 2.4 kernel
> and your non-working 2.6 kernel?  If you're failing in there that would
> be my first thought. I suppose that's probably not that case though.

2.4.23 still runs on board I try to port 2.6.8.1 to. So I guess firmware
is not the problem?

> Well, the 405cr support issue is really throwing me for a loop here. If
> you're crashing in _alloc_bootmem_core() and haven't hacked any MM code
I haven't change any MM code.

> then you're an interesting spot.  Can you trace it down to the exact
> failure in __alloc_bootmem_core?
I already did it. Can you please read
http://ozlabs.org/pipermail/linuxppc-dev/2004-September/000104.html? I
described there what weird things are happening in __alloc_bootmem_core.

Piotr Perak
