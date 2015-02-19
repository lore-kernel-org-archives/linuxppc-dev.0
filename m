Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 771731A090F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 13:56:35 +1100 (AEDT)
Message-ID: <1424314594.22408.1.camel@ellerman.id.au>
Subject: Re: Problems with Kernels 3.17-rc1 and onwards on Acube Sam460 AMCC
 460ex board
From: Michael Ellerman <mpe@ellerman.id.au>
To: Julian Margetson <runaway@candw.ms>
Date: Thu, 19 Feb 2015 13:56:34 +1100
In-Reply-To: <54E53E07.60609@candw.ms>
References: <54E08E06.8060607@candw.ms>
 <1424045921.3018.4.camel@ellerman.id.au> <54E4EBD7.5000307@candw.ms>
 <1424304787.22020.4.camel@ellerman.id.au> <54E53E07.60609@candw.ms>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-02-18 at 21:36 -0400, Julian Margetson wrote:
> On 2/18/2015 8:13 PM, Michael Ellerman wrote:
> 
> > On Wed, 2015-02-18 at 15:45 -0400, Julian Margetson wrote:
> > > On 2/15/2015 8:18 PM, Michael Ellerman wrote:
> > > 
> > > > On Sun, 2015-02-15 at 08:16 -0400, Julian Margetson wrote:
> > > > > Hi
> > > > > 
> > > > > I am unable to get any kernel beyond  the 3.16 branch working on an
> > > > > Acube Sam460ex
> > > > >  AMCC 460ex based motherboard. Kernel  up 3.16.7-ckt6 working.
> > > > Does reverting b0345bbc6d09 change anything?
> > > > 
> > > > > [    6.364350] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
> > > > > [    6.453794] snd_hda_intel 0001:81:00.1: ppc4xx_setup_msi_irqs: fail mapping irq
> > > > > [    6.487530] Unable to handle kernel paging request for data at address 0x0fa06c7c
> > > > > [    6.495055] Faulting instruction address: 0xc032202c
> > > > > [    6.500033] Vector: 300 (Data Access) at [efa31cf0]
> > > > > [    6.504922]     pc: c032202c: __reg_op+0xe8/0x100
> > > > > [    6.509697]     lr: c0014f88: msi_bitmap_free_hwirqs+0x50/0x94
> > > > > [    6.515600]     sp: efa31da0
> > > > > [    6.518491]    msr: 21000
> > > > > [    6.521112]    dar: fa06c7c
> > > > > [    6.523915]  dsisr: 0
> > > > > [    6.526190]   current = 0xef8bab00
> > > > > [    6.529603]     pid   = 115, comm = kworker/0:1
> > > > > [    6.534163] enter ? for help
> > > > > [    6.537054] [link register   ] c0014f88 msi_bitmap_free_hwirqs+0x50/0x94
> > > > > [    6.543811] [efa31da0] c0014f78 msi_bitmap_free_hwirqs+0x40/0x94 (unreliable)
> > > > > [    6.551001] [efa31dc0] c001aee8 ppc4xx_setup_msi_irqs+0xac/0xf4
> > > > > [    6.556973] [efa31e00] c03503a4 pci_enable_msi_range+0x1e0/0x280
> > > > > [    6.563032] [efa31e40] f92c2f74 azx_probe_work+0xe0/0x57c [snd_hda_intel]
> > > > > [    6.569906] [efa31e80] c0036344 process_one_work+0x1e8/0x2f0
> > > > > [    6.575627] [efa31eb0] c003677c worker_thread+0x2f4/0x438
> > > > > [    6.581079] [efa31ef0] c003a3e4 kthread+0xc8/0xcc
> > > > > [    6.585844] [efa31f40] c000aec4 ret_from_kernel_thread+0x5c/0x64
> > > > > [    6.591910] mon>  <no input ...>
> > > Managed to do a third git bisect  with the following results .
> > Great work.
> > 
> > > git bisect bad
> > > 9279d3286e10736766edcaf815ae10e00856e448 is the first bad commit
> > > commit 9279d3286e10736766edcaf815ae10e00856e448
> > > Author: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > > Date:   Wed Aug 6 16:10:16 2014 -0700
> > > 
> > >     lib: bitmap: change parameter of bitmap_*_region to unsigned
> > 
> > So the bug is in the 4xx MSI code, and has always been there, in fact I don't
> > see how that code has *ever* worked. The commit you bisected to just caused the
> > existing bug to cause an oops.
> > 
> > Can you try this?
> > 
> > diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/sysdev/ppc4xx_msi.c
> > index 6e2e6aa378bb..effb5b878a78 100644
> > --- a/arch/powerpc/sysdev/ppc4xx_msi.c
> > +++ b/arch/powerpc/sysdev/ppc4xx_msi.c
> > @@ -95,11 +95,9 @@ static int ppc4xx_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
> >  
> >  	list_for_each_entry(entry, &dev->msi_list, list) {
> >  		int_no = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
> > -		if (int_no >= 0)
> > -			break;
> >  		if (int_no < 0) {
> > -			pr_debug("%s: fail allocating msi interrupt\n",
> > -					__func__);
> > +			pr_warn("%s: fail allocating msi interrupt\n", __func__);
> > +			return -ENOSPC;
> >  		}
> >  		virq = irq_of_parse_and_map(msi_data->msi_dev, int_no);
> >  		if (virq == NO_IRQ) {
> > 
> Thanks.

> This works with 3.17-rc1. Will try with the 3.18 Branch .

OK great.

> Any ideas why drm is not  working ? (It never worked) .

No sorry. You might have more luck if you post a new thread to the dri list.

> [    5.809802] Linux agpgart interface v0.103
> [    6.137893] [drm] Initialized drm 1.1.0 20060810
> [    6.439872] snd_hda_intel 0001:81:00.1: enabling device (0000 -> 0002)
> [    6.508544] ppc4xx_setup_msi_irqs: fail allocating msi interrupt

I'm curious why it's failing to allocate MSIs. Possibly it's just run out.

Can you post the output of 'cat /proc/interrupts'?

cheers
