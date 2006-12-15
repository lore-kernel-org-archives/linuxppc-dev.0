Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix sparsemem on Cell
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <20061215165335.61D9F775@localhost.localdomain>
References: <20061215165335.61D9F775@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 16 Dec 2006 07:21:53 +1100
Message-Id: <1166214113.31351.101.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	mkravetz@us.ibm.com, gone@us.ibm.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The only other assumption is that all memory-hotplug-time pages 
> given to memmap_init_zone() are valid and able to be onlined into
> any any zone after the system is running.  The "valid" part is
> really just a question of whether or not a 'struct page' is there
> for the pfn, and *not* whether there is actual memory.  Since
> all sparsemem sections have contiguous mem_map[]s within them,
> and we only memory hotplug entire sparsemem sections, we can
> be confident that this assumption will hold.
> 
> As for the memory being in the right node, we'll assume tha
> memory hotplug is putting things in the right node.

BTW, just that people know, what we are adding isn't even memory :-) We
are calling __add_pages() to create struct page for the SPE local stores
and register space as we use them later from a nopage() handler (and no,
we can't use no_pfn just yet for various reasons, notably we need to
handle races with unmap_mapping_ranges() and thus have the truncate
logic in).

Those pages, thus, must never be onlined. Ever. It might make sense to
create a way to inform memory hotplug of that fact, but on the other
hand, I wouldn't bother as I have a plan to get rid of those
__add_pages() completely and work without struct page, maybe in a 2.6.21
timeframe.

Ben.
