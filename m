Content-Type: text/plain;
  charset="iso-8859-1"
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: 440GX: mapping PCI address
Date: Thu, 22 Jul 2004 13:47:50 +0200
References: <45ABD2373C33C4459D42B40EC4F346F2024CA06C@FTWMLVEM03.e2k.ad.ge.com>
In-Reply-To: <45ABD2373C33C4459D42B40EC4F346F2024CA06C@FTWMLVEM03.e2k.ad.ge.com>
MIME-Version: 1.0
Message-Id: <200407221347.50407.g.jaeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
