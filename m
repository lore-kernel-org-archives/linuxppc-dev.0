Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id BE6822BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 23:44:44 +1000 (EST)
Date: Tue, 28 Sep 2004 06:44:42 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Piotr Perak <peri@aqua.aspd.pwr.wroc.pl>
Message-ID: <20040928064442.A31883@home.com>
References: <20040927065758.B25288@home.com>
	<Pine.LNX.4.21.0409281116130.12901-100000@aqua.aspd.pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0409281116130.12901-100000@aqua.aspd.pwr.wroc.pl>;
	from peri@aqua.aspd.pwr.wroc.pl on Tue, Sep 28, 2004 at
	11:57:44AM +0200
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

On Tue, Sep 28, 2004 at 11:57:44AM +0200, Piotr Perak wrote:
> 
> On Mon, 27 Sep 2004, Matt Porter wrote:
> 
> > Since you are failing in ocp_add_one_device() and you have a
> > processor which doesn't have a chip definition in 2.6, the
> > problem is probably somewhere there.  Doublecheck your
> > arch/ppc/platforms/4xx/ibm405cr.c (you do have one, right?)
> > against a known good one in arch/ppc/platforms/4xx/ibm405gp.c
> 
> Because I use ibm405cr.c which works good with 2.4.23 I think that's not
> the problem. Remember the call stack?

Which 2.4 tree?  linux-2.4, linuxppc-2.4, and linuxppc_2_4_devel haven't
had explicit 405cr support that I've noticed. Since the ocp layer has
changed that would leave open the possibility of a problem in translating
the support to the new ocp layer. 

> setup_arch() - arch/ppc/kernel/setup.c
>   -> ocp_early_init() - arch/ppc/syslib/ocp.c
>     -> ocp_add_one_device() - arch/ppc/syslib/ocp.c
>       ->  alloc_bootmem MACRO calling __alloc_bootmem_core() -
> mm/bootmem.c
> 
> When I comment line calling ocp_early_init() I fail in:
>  
> setup_arch() - arch/ppc/kernel/setup.c
>   -> paging_init() - arch/ppc/mm/init.c
>     -> free_area_init() - arch/ppc/mm/page_alloc.c
>       -> free_area_init_node() - arch/ppc/mm/page_alloc.c
>         -> alloc_bootmem_node() MACRO calling __alloc_bootmem_node -
> mm/bootmem.c
>           -> __alloc_bootmem_core() - mm/bootmem.c
> 
> As you can see again __alloc_bootmem_core. So maybe there's some
> problem with memory?

Hrm, I see. Did your firmware change between your working 2.4 kernel
and your non-working 2.6 kernel?  If you're failing in there that would
be my first thought. I suppose that's probably not that case though.

> Forgive me if I ask stupid questions, but this the first time I have
> something to do with the kernel (not counting compiling for my home PC).

Well, the 405cr support issue is really throwing me for a loop here. If
you're crashing in _alloc_bootmem_core() and haven't hacked any MM code
then you're an interesting spot.  Can you trace it down to the exact
failure in __alloc_bootmem_core?

-Matt
