MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: 440GX: mapping PCI address
Date: Tue, 27 Jul 2004 13:20:27 -0500
Message-ID: <45ABD2373C33C4459D42B40EC4F346F2026215B0@FTWMLVEM03.e2k.ad.ge.com>
From: "Barbier, Renaud (GE Infrastructure)" <Renaud.Barbier@ge.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ok. I am lost here.
I have checked the linux source code and can see
comments regarding fix for the 36-bit address.
So I would think the current BSP I have can support what I need.


Still even though I am getting an address from mmap access, to the location freezes my machine.
Here is the code.
fd=open("/dev/mem", O_RDWR);

/* test fd for error */
ptr=(unsigned int *)mmap(0, 4096, PROT_READ | PROT_WRITE,
                             MAP_SHARED, fd, 0xec00000); or /* 0x80002000 */
printf("ptr = 0x%x\n", (unsigned int)ptr);

the returned address is 0x30019000.

If I understand correctly 0x0ec00000 should be translated by the kernel
to 0x20ec00000 to map the PCI configuration register.

I can see the remapping being done when using ioremap in the drivers but not
when doing mmap at user level. So could be wrong in my system?


Actually, what do you do if you have 512MB of memory? I guess change the "trap" area.

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Gerhard
Jaeger
Sent: Thursday, July 22, 2004 12:48 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 440GX: mapping PCI address



Hi,

checkout
arch/ppc/mm/pgtable.c
there you'll find the ioremap function which is used to remap physical
addresses. This function calls internaly fixup_big_physaddr(), defined in
arch/ppc/kernel/ibm44x_common.c
This fixup_big_physaddr() adjusts some 32bit addresses to some corresponding
36bit addresses, which can be mapped by the kernel by calling ioremap64.
Your example:
Calling mmap with the address 0x80002000 (see also include/asm-ppc/ibm44x.h)
will map the PCI area, by trapping this 0x80002000 and making a 36bit address
out of it. There a 3 "trap" areas defined:
/*
 * 36-bit trap ranges
 */
#define PPC44x_IO_LO            0x40000000
#define PPC44x_IO_HI            0x40001000
#define PPC44x_PCICFG_LO        0x0ec00000
#define PPC44x_PCICFG_HI        0x0ec7ffff
#define PPC44x_PCIMEM_LO        0x80002000
#define PPC44x_PCIMEM_HI        0xffffffff

Hope this helps,
  Gerhard

On Thursday 22 July 2004 11:58, Barbier, Renaud (GE Infrastructure) wrote:
> As you know the PCI address(and other embedded device) are seen through a
> 36-bit address space.
>
> How do you map this address from user space?
>
> I have seen a message from 2002 saying it is not supported. Anything new
> since then?
>
> thanks.

--
Gerhard Jaeger                             g.jaeger@sysgo.com
SYSGO AG                      Embedded and Real-Time Software
Voice: + 49 731 94683-0                Fax: + 49 731 94683-10
www.sysgo.com | www.elinos.com | www.osek.de | www.imerva.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
