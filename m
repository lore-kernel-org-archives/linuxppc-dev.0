Subject: Re: question about 8241 again
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: llee <llee@huawei.com>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <4089E119.40003@huawei.com>
References: <4089E119.40003@huawei.com>
Content-Type: text/plain
Message-Id: <1082783785.10725.63.camel@gaston>
Mime-Version: 1.0
Date: Sat, 24 Apr 2004 15:16:26 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-04-24 at 13:38, llee wrote:
> Hi, all,
>
> I get confusion on linux PPC MMU management(kernel 2.6.3): It seems
> linux setup an empty hashtable (in MMU_init_hw) first and do a
> hash_page() when exception. But at least it should make a real mapping
> for the kernel itself, shouldn't it? But I haven't found it do this
> anywhere.

The kernel itself... well.. that depends. For the kernel code/data,
and in general, the beginning of the linear mapping, linux uses BATs
(basically, the start of memory is mapped with BATs, up to 512Mb,
that is 2 BATs). In 2.6, the kernel should be able to cope with
taking a hash fault on the rest of kernel memory at any time, if
you spot a case where this isn't true, please tell us ;) Especially,
it clears MSR:RI in areas where faulting isn't safe (like when using
SRR0/SRR1) which causes a fault at this point to return to a special
fixup code instead of resuming the normal flow of execution.

> And also, when i add the following code in sandpoint_map_io(and I also
> enable feature CPU_FTR_HPTE_TABLE for 8241):
>     io_block_mapping(0x70000000, 0x70000000, 0x20000000, _PAGE_IO);
>     io_block_mapping(0x80500000, 0x80500000, 0x00100000, _PAGE_IO);
> the first call get a bat mapping and another get a page mapping, but
> only the first one works find, the second one could not been access.

I'm not too sure, I tend to discourage people from using
io_block_mapping, use ioremap instead. Make sure you are past
MMU_init though before you can use the page tables.

> Could anybody tell me why?
>
> Thanks advanced and sorry for my poor english.
>
> Ken
>
--
Benjamin Herrenschmidt <benh@kernel.crashing.org>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
