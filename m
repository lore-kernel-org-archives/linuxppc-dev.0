Return-Path: <msuchanek@suse.de>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNKB00WGtzDqd9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 00:58:32 +1000 (AEST)
Date: Wed, 10 May 2017 16:58:27 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Jonathan Corbet
 <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko
 <mhocko@suse.cz>, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 RFT 1/2] powerpc/fadump: reduce memory consumption
 for capture kernel
Message-ID: <20170510165827.5a2e1022@kitsune.suse.cz>
In-Reply-To: <765ca86f-b6c5-190e-b3a9-91282e199baf@linux.vnet.ibm.com>
References: <20170502155611.6789-1-msuchanek@suse.de>
 <765ca86f-b6c5-190e-b3a9-91282e199baf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 3 May 2017 12:43:33 +0530
Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:

> On Tuesday 02 May 2017 09:26 PM, Michal Suchanek wrote:
> > With fadump (dump capture) kernel booting like a regular kernel, it
> > almost needs the same amount of memory to boot as the production
> > kernel, which is unwarranted for a dump capture kernel. But with no
> > option to disable some of the unnecessary subsystems in fadump
> > kernel, that much memory is wasted on fadump, depriving the
> > production kernel of that memory.
> >
> > Introduce kernel parameter 'fadump_append=' that would take regular
> > kernel parameters to be appended when fadump is active.
> > This 'fadump_append=' parameter can be leveraged to pass parameters
> > like nr_cpus=1, cgroup_disable=memory and numa=off, to disable
> > unwarranted resources/subsystems.
> >
> > Also, ensure the log "Firmware-assisted dump is active" is printed
> > early in the boot process to put the subsequent fadump messages in
> > context.
> >
> > Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> > v4:
> >   - use space separated arguments instead of comma separated
> >   - do not append parameters when fadummp is disabled
> > ---
> >   arch/powerpc/kernel/fadump.c | 27 ++++++++++++++++++++++++---
> >   1 file changed, 24 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/fadump.c
> > b/arch/powerpc/kernel/fadump.c index ebf2e9c..e0c728a 100644
> > --- a/arch/powerpc/kernel/fadump.c
> > +++ b/arch/powerpc/kernel/fadump.c
> > @@ -79,8 +79,10 @@ int __init early_init_dt_scan_fw_dump(unsigned
> > long node,
> >   	 * dump data waiting for us.
> >   	 */
> >   	fdm_active = of_get_flat_dt_prop(node, "ibm,kernel-dump",
> > NULL);
> > -	if (fdm_active)
> > +	if (fdm_active) {
> > +		pr_info("Firmware-assisted dump is active.\n");
> >   		fw_dump.dump_active = 1;
> > +	}
> >
> >   	/* Get the sizes required to store dump data for the
> > firmware provided
> >   	 * dump sections.
> > @@ -263,8 +265,12 @@ int __init fadump_reserve_mem(void)
> >   {
> >   	unsigned long base, size, memory_boundary;
> >
> > -	if (!fw_dump.fadump_enabled)
> > +	if (!fw_dump.fadump_enabled) {
> > +		if (fw_dump.dump_active)
> > +			pr_warn("Firmware-assisted dump was active
> > but kernel"
> > +				" booted with fadump disabled!\n");
> >   		return 0;
> > +	}
> >
> >   	if (!fw_dump.fadump_supported) {
> >   		printk(KERN_INFO "Firmware-assisted dump is not
> > supported on" @@ -304,7 +310,6 @@ int __init
> > fadump_reserve_mem(void) memory_boundary = memblock_end_of_DRAM();
> >
> >   	if (fw_dump.dump_active) {
> > -		printk(KERN_INFO "Firmware-assisted dump is
> > active.\n"); /*
> >   		 * If last boot has crashed then reserve all the
> > memory
> >   		 * above boot_memory_size so that we don't touch
> > it until @@ -363,6 +368,22 @@ unsigned long __init
> > arch_reserved_kernel_pages(void) return memblock_reserved_size() /
> > PAGE_SIZE; }
> >
> > +/* Look for fadump_append= cmdline option. */
> > +static int __init early_fadump_append_param(char *p)
> > +{
> > +	if (!p)
> > +		return 1;
> > +
> > +	if (fw_dump.fadump_enabled && fw_dump.dump_active) {
> > +	pr_info("enforcing additional parameters (%s) passed
> > through "
> > +		"'fadump_append=' parameter\n", p);
> > +		parse_early_options(p);  
> 
> While testing this on a system with yaboot bootloader, it seems that
> parsing a parameter with syntax like fadump_append="nr_cpus=1
> numa=off" is not resulting in the intended way..

Since yaboot arguments are quoted you will probably want something like

append = "quiet splash somearg1 somearg2 fadump_append=\"nr_cpus=1
numa=off\""

in yaboot.conf

Looking at the yaboot parser it seems to handle quoting of quotes so
unlike your parser that does not handle quoting of commas it allows
passing arbitrary arguments to both the normal kernel and the fadump
kernel. 

Thanks

Michal
