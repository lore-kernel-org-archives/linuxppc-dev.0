Message-ID: <40EC2DC8.5020400@246tNt.com>
Date: Wed, 07 Jul 2004 19:07:20 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: ppc linux embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Getting rid of static IO mapping
References: <40EB1C28.3000402@246tNt.com>
In-Reply-To: <40EB1C28.3000402@246tNt.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I'll try to re-explain my problem more clearly. Maybe some one will
see a solution.

I'm trying to avoid any static io mapping. So no use of
setup_io_mapping. I also setup a handler for ppc_md.progress to have
early debug.
This progress function makes use of the UART, so at every call the
uart must be mapped and I have to know where.

In the current code, during platform setup, I setup BAT2 to 1:1 map
this area. So I can access it early and I know the address. But when
load_up_mmu is called, my mapping disapear ( wanted behavior ), so
from this point, I should ioremap the zone once and keep it in a
static var (to avoir ioremap/iounmap each time). The problem is to
detect WHEN I should ioremap it, detect if the load_up_mmu part is
done or not.

The solutions I have thinked of :
 - Don't use BAT2 at all and ioremap it from the start. But at that
point ioremap will use io_remap_base and not the vm. So I'm not sure
it's a good idea to keep it all the time. Does the vm will know not to
use it ? And looking at the comment in arch/ppc/mm/init.c :

        ioremap_base = 0xfe000000UL;    /* for now, could be 0xfffff000 */

I'd say that I should avoir ioremap before mem_init_done.

 - Another solution, use BAT2, then when mem_init_done == 1, ioremap.
But mem_init_done is set to 1 before load_up_mmu, so I would end up
with the same area mapped by the BATs and the pages. IIRC in the 603
manual, it's clearly noted that should not happen.

So anyone has a clue on how to do it ?


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
