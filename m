Message-ID: <3A6FC1EB.1CC0B893@mvista.com>
Date: Thu, 25 Jan 2001 01:04:27 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: mgreer@mvista.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_HIGHMEM on PPC
References: <3A6E224E.C0305107@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


"Mark A. Greer" wrote:

> Has anyone tried CONFIG_HIGHMEM on PPC lately?

I think it is broken and I have also stumbled into a fix for it.

When HIGHMEM is used, memory pages are mapped to virtual addresses
that are not 1:1 mapped.  Our simple virt_to_phys macros won't work
with HIGHMEM pages.  The 4xx and 8xx processor (and in my test
kernel all processors) map the virt_to_phys to the 'iopa' function
in arch/ppc/mm/init.c.  This way the actual page table entry is
tracked down for a virtual address.

Change your virt_to_phys, virt_to_bus macros in include/asm-ppc/io.h
to call 'iopa' (and do the PCI_DRAM_OFFSET adjustment as necessary)
and let me know what happens.  I'm working on the reverse, using
the mm_ptov() but I don't have it done yet.  If you are using the
reverse (bus_to_virt, etc.) functions, let me know and I'll try to
find a quick hack.

I would like to know who works on APUS as well.  In making these
VM changes, I certainly broke the APUS code (because I stole from
there and made it all common :-).  I would like to work with someone
to straighten this out as I have no way to test it.

Thanks.

	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
