Return-Path: <peri@aqua.aspd.pwr.wroc.pl>
Received: from aqua.aspd.pwr.wroc.pl (aqua.aspd.pwr.wroc.pl [156.17.17.24])
	by ozlabs.org (Postfix) with ESMTP id E04ED2BDA1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 19:57:52 +1000 (EST)
Date: Tue, 28 Sep 2004 11:57:44 +0200 (CEST)
From: Piotr Perak <peri@aqua.aspd.pwr.wroc.pl>
To: Matt Porter <mporter@kernel.crashing.org>
In-Reply-To: <20040927065758.B25288@home.com>
Message-ID: <Pine.LNX.4.21.0409281116130.12901-100000@aqua.aspd.pwr.wroc.pl>
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


On Mon, 27 Sep 2004, Matt Porter wrote:

> Since you are failing in ocp_add_one_device() and you have a
> processor which doesn't have a chip definition in 2.6, the
> problem is probably somewhere there.  Doublecheck your
> arch/ppc/platforms/4xx/ibm405cr.c (you do have one, right?)
> against a known good one in arch/ppc/platforms/4xx/ibm405gp.c

Because I use ibm405cr.c which works good with 2.4.23 I think that's not
the problem. Remember the call stack?

setup_arch() - arch/ppc/kernel/setup.c
  -> ocp_early_init() - arch/ppc/syslib/ocp.c
    -> ocp_add_one_device() - arch/ppc/syslib/ocp.c
      ->  alloc_bootmem MACRO calling __alloc_bootmem_core() -
mm/bootmem.c

When I comment line calling ocp_early_init() I fail in:
 
setup_arch() - arch/ppc/kernel/setup.c
  -> paging_init() - arch/ppc/mm/init.c
    -> free_area_init() - arch/ppc/mm/page_alloc.c
      -> free_area_init_node() - arch/ppc/mm/page_alloc.c
        -> alloc_bootmem_node() MACRO calling __alloc_bootmem_node -
mm/bootmem.c
          -> __alloc_bootmem_core() - mm/bootmem.c

As you can see again __alloc_bootmem_core. So maybe there's some
problem with memory?

Forgive me if I ask stupid questions, but this the first time I have
something to do with the kernel (not counting compiling for my home PC).
