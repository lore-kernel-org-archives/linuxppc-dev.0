Message-ID: <390088B4.5408B5EF@embeddededge.com>
Date: Fri, 21 Apr 2000 12:58:28 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: zzh <david-1z@263.net>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: memory map
References: <39002421.07687@mta1>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


zzh wrote:


> 1)Some area eg BCSR mapped below KERNELBASE,is this safe?

If you ioremap() after the kernel VM allocator is initialized, this
is fine.  You then get a kernel virtual address to use that will
map to the physical address.  Don't map this in mm/init.c initialization
as this maps 1:1 because the VM is not initialized yet.  The things
mapped in mm/init.c should be just the minimum to debug or get
the kernel booted.

> I check some process's vm area,it does not fall in this area,will
> it be unsafe under some circumstances?

The "some" circumstances are incorrect mapping during the early
initialization.

> 2)I read mapin_ram() in mm/init.c ,found that phys mem is also mapped
> both by bat and page table ,what is this for?

Physical memory is mapped by BATs, if they exist on the processor.
Since the 8xx doesn't have BATs, the memory is mapped through page
tables.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
