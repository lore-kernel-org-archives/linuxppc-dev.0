From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14806.62164.27906.255635@argo.linuxcare.com.au>
Date: Sun, 1 Oct 2000 19:16:20 +1100 (EST)
To: Dan Malek <dan@mvista.com>
Cc: frowand@mvista.com,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: __ioremap_at() in 2.4.0-test9-pre2
In-Reply-To: <39D68EB8.4CAD5168@mvista.com>
References: <19340822040932.8760@mailhost.mipsys.com>
	<Pine.LNX.4.10.10009281150130.3468-100000@cassiopeia.home>
	<14803.57550.118150.759977@argo.linuxcare.com.au>
	<39D41AA2.C586D738@mvista.com>
	<14804.7238.688771.238444@argo.linuxcare.com.au>
	<39D4E85F.926CFD5B@mvista.com>
	<14805.17492.766815.388301@argo.linuxcare.com.au>
	<39D66E4D.4364FC8B@mvista.com>
	<39D68EB8.4CAD5168@mvista.com>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Dan Malek writes:

> This "equivalent" mapping is going to be the greatest challenge.  The
> reason this happens is because we need access through the MMU before
> the kernel has initialized the kernel VM allocator.  Parts of the early
> kernel initialization that have to access control/status registers of
> various types are going to be mapped 1:1.  After some of these proposed
> changes, these mappings are going to be destroyed and remapped (to get
> the "standard" 0xff000000 address).  This is really bad for the

Ummm, no, I think we may have a misunderstanding here.

First, you can use ioremap before the kernel VM allocator is set up,
and you can continue to use the virtual addresses you get by doing so.
So no mappings are going to be destroyed and remapped.  All we do for
early ioremaps of addresses < ioremap_base is to allocate addresses
starting at ioremap_base and going down.  And yes, we will need to do
that for addresses >= 0xff000000 too (in fact 0xfe000000 if we are
using CONFIG_HIGHMEM).  Actually, there's really no reason why we
shouldn't do that for all physical addresses.  So the code in ioremap
would become something like this:

	if (mem_init_done) {
		struct vm_struct *area;
		area = get_vm_area(size, VM_IOREMAP);
		if (area == 0)
			return NULL;
		v = VMALLOC_VMADDR(area->addr);
	} else {
		v = (ioremap_bot -= size);
	}

(leaving out the "if (p >= ioremap_base)" test), and we could
initialize ioremap_bot to 0xff000000 (or 0xfe000000 in the highmem
case).

Secondly, all your integrated devices would be using memory-mapped
I/O, so the question of what _IO_BASE is, and how inb/outb work, is
pretty much irrelevant to you, isn't it?

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
