Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 68D0FB6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  5 Sep 2011 06:08:41 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=windows-1252
Subject: early_init_devtree() order of memblock limit setting
Date: Sun, 4 Sep 2011 15:08:32 -0500
Message-Id: <8A961C15-8762-4350-B96D-5173F18C785B@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Cc: PPC list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben,

I've got an issue on Book-E 64 with the bolted linear mapping and how =
big it might be.  We have to take into account things like mem=3D when =
determining how to set ppc64_rma_size.  So I'm wondering if there is a =
reason w/regards to the order in which we call =
setup_initial_memory_limit() vs parsing the cmdline and calling =
memblock_enforce_memory_limit(limit) in early_init_devtree().

Could we reorder the follow code such that we call =
setup_initial_memory_limit() to after memblock_enforce_memory_limit()?

- k

void __init early_init_devtree(void *params)
{
	=85

        setup_initial_memory_limit(memstart_addr, first_memblock_size);

        /* Save command line for /proc/cmdline and then parse parameters =
*/
        strlcpy(boot_command_line, cmd_line, COMMAND_LINE_SIZE);
        parse_early_param();

        /* Reserve MEMBLOCK regions used by kernel, initrd, dt, etc... =
*/
        memblock_reserve(PHYSICAL_START, __pa(klimit) - PHYSICAL_START);
        /* If relocatable, reserve first 32k for interrupt vectors etc. =
*/
        if (PHYSICAL_START > MEMORY_START)
                memblock_reserve(MEMORY_START, 0x8000);
        reserve_kdump_trampoline();
        reserve_crashkernel();
        early_reserve_mem();
        phyp_dump_reserve_mem();

        limit =3D memory_limit;
        if (! limit) {
                phys_addr_t memsize;

                /* Ensure that total memory size is page-aligned, =
because
                 * otherwise mark_bootmem() gets upset. */
                memblock_analyze();
                memsize =3D memblock_phys_mem_size();
                if ((memsize & PAGE_MASK) !=3D memsize)
                        limit =3D memsize & PAGE_MASK;
        }
        memblock_enforce_memory_limit(limit);

	=85
}=
