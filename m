Message-ID: <40EB28C7.5020105@246tNt.com>
Date: Wed, 07 Jul 2004 00:33:43 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: ppc linux embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Getting rid of static IO mapping
References: <40EB1C28.3000402@246tNt.com>
In-Reply-To: <40EB1C28.3000402@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sylvain Munaut wrote:

 > In the current situation, I use the physical address and there is a
 >  1:1 mapping. The mapping is first done by directly manipulating
 > {D,I}BAT2, then by setup_io_mappings.

Actually, looking at the code in arch/ppc/mm/init.c

        /* Map in all of RAM starting at KERNELBASE */
        if (ppc_md.progress)
                ppc_md.progress("MMU:mapin", 0x301);
        mapin_ram();

#ifdef CONFIG_HIGHMEM
        ioremap_base = PKMAP_BASE;
#else
        ioremap_base = 0xfe000000UL;    /* for now, could be 0xfffff000 */
#endif /* CONFIG_HIGHMEM */
        ioremap_bot = ioremap_base;

        /* Map in I/O resources */
        if (ppc_md.progress)
                ppc_md.progress("MMU:setio", 0x302);
        if (ppc_md.setup_io_mappings)
                ppc_md.setup_io_mappings();


I wonder how it works. At the mapin_ram(), my BAT are overwritten,
then the "MMU:setio" progress is called, but at this point, my BAT is
no longer active and my setup_io_mappings is not yet called. Shouldn't
that crash ? During these two calls, the uart zone shouldn't be mapped.


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
