MIME-Version: 1.0
Message-Id: <3903BE73.04522@mta2>
Date: Mon, 24 Apr 2000 11:24:35 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: Dan Malek <dan@netx4.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re:Re: memory map
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>zzh wrote:
>
>
>> 1)Some area eg BCSR mapped below KERNELBASE,is this safe?
>
>If you ioremap() after the kernel VM allocator is initialized, this
>is fine.  You then get a kernel virtual address to use that will
>map to the physical address.  Don't map this in mm/init.c initialization
>as this maps 1:1 because the VM is not initialized yet.  The things
>mapped in mm/init.c should be just the minimum to debug or get
>the kernel booted.
>
>> I check some process's vm area,it does not fall in this area,will
>> it be unsafe under some circumstances?
>
>The "some" circumstances are incorrect mapping during the early
>initialization.
>
>> 2)I read mapin_ram() in mm/init.c ,found that phys mem is also mapped
>> both by bat and page table ,what is this for?
>
>Physical memory is mapped by BATs, if they exist on the processor.
>Since the 8xx doesn't have BATs, the memory is mapped through page
>tables.
>
>
>	-- Dan
In fact,i am hacking with a motorola 8260 ads board.I download the
mpc8xx to start with.I find it is in fact quite different.The cpm
part is similar,but the core should not use the code in CONFIG_8XX
.I think the memory problem is very important.No i determine to
proceed as follows:
1)Before start_here,map KERNELBASE to 0 with BAT,then can safely call
other function
2)In mapin_ram(),map KERNELBASE to phys mem use paging,i think this is necessary because we need to individually controll the caching property of those pages used by cpm.
3)Map internal memory space with BAT above KERNELBASE.on startup,
my board's IMMR=0f000000,so change this to f0000000 in ROM code
before init dram etc and use it in kernel too.
Do you think this is ok?I learned that you do a 8260 port too,
what is the method you use and how's the status of the work?
                           Best Regard
                           davidzhang


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
