MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16567.54462.281664.81717@cargo.ozlabs.ibm.com>
Date: Sat, 29 May 2004 10:09:34 +1000
From: Paul Mackerras <paulus@samba.org>
To: Tom Rini <trini@kernel.crashing.org>,
	Pantelis Antoniou <panto@intracom.gr>
Cc: Dan Malek <dan@embeddededge.com>,
	Kumar Gala <kumar.gala@motorola.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH #4/9] 8xx-2.6 | MM tweaks
In-Reply-To: <20040527165316.GF6763@smtp.west.cox.net>
References: <40B48819.9000904@intracom.gr>
	<20040527165316.GF6763@smtp.west.cox.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini writes:

> Which you exactly reverted.  Were the changes from Paul incorrect here?
> Or is perhaps there something more needed on the 8xx side of things?

The problem with the old code (which Pantelis put back) is that PTEs
no longer necessarily have fixed, unique virtual addresses in the
kernel.  Now that we can have PTE pages in highmem, it is necessary to
use pte_offset_map to get the address of a PTE (which does a kmap if
you have HIGHMEM enabled) and pte_unmap when you are finished with
it.  The address you get back from pte_offset_map is only valid until
you do pte_unmap, and you can't sleep between pte_offset_map and
pte_unmap (it uses an atomic kmap).

However, PTE pages for kernel mappings are allocated in lowmem, and
you can get a persistent kernel virtual address for them.

Those changes were in va_to_pte, and the only user of that (that I can
find) is va_to_phys, which isn't called at all AFAICS (and shouldn't
be needed).  Probably the best thing is just to remove them.  In
addition, get_8xx_pte and print_8xx_pte appear to be used only in some
debugging code in softemu8xx.c, and could probably be dispensed with
(another #ifdef gone, yay :).  Certainly users of get_8xx_pte could
use get_pteptr instead.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
