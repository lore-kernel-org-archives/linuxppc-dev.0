Message-ID: <3E716A78.2030403@tataelxsi.co.in>
Date: Fri, 14 Mar 2003 11:06:56 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: accessing immap_t * variable in mpc8260
References: <3E70A2C3.8090305@tataelxsi.co.in> <15985.793.339541.402592@nanango.paulus.ozlabs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the answers. Now I have a better picture, still some more
doubts...

Paul Mackerras wrote:
> Omanakuttan writes:
>
>
>>In FCC code, eldk/ppc_82xx/usr/src/linux/arch/ppc/8260_io/fcc_enet.c,
>>immap_t * immap is simply typecasted to IMAP_ADDR, which is
>>((uint)0xf0000000).
>>Now, after assigning this physical address, fcc_enet code continues the
>>immap_t variable without doing any __va macro.
>
>
> The __va macro is only applicable to addresses in system RAM.  If you
> are using "HIGHMEM" support (unlikely on an 82xx) you can only use
we are not using it, and I thought it is a intel feature, to address
64GB mem. Thanks for this input. We have 64MB SDRAM and 8MB FLASH.
> __va on "low" memory addresses, i.e. those that are mapped
> contiguously starting at KERNELBASE.
>
>
>>I am confused at this point, that how can kernel code access a physical
>>address as if it were virtual address ? how does the page frame -> page
>>conversion (and vice versa) happens on this front?
>
>
> The 8xx and 82xx ports map several things at the same virtual address
Sorry for asking shortcut, but which files in the source tree will give
me the exact mapping? shall I start exploring mm directory in ppc/arch?
will init.c and pgtable.c give what I want?
> as their physical address.  That simplifies some things but has the
OK, now if I use __va on such an address, it will not do any harm,
right? if both physical and virtual address are same, I cannot think of
any way __va(x) or __pa(x) returning something other than x . But again
the implementation of __va
#define ___va(paddr) ((paddr)+PPC_MEMOFFSET)
where PPC_MEMOFFSET is  CONFIG_KERNEL_START or 0xc000_0000, but it
implies that va is pa+3GB or custom kernel start address.
Now if the memory manager maps pa+3GB back to pa, I think there will be
no problem. Is it what happens? if so, how can we tell virtual and phy
address are same?
> disadvantage that it tends to clutter up the kernel virtual addres
> space.  If you have no more than 512MB of RAM or so, that isn't a big
> problem.  On powermac/CHRP/PReP machines we no longer map anything at
> fixed virtual addresses, because those machines can have a gigabyte or
> more of RAM.
>
> Paul.
>

Thanks and regards,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
