From: "Rob Taylor" <robt@flyingpig.com>
To: "Dan Malek" <dan@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: switching linux kernels
Date: Fri, 6 Oct 2000 17:50:52 +0100
Message-ID: <000e01c02fb5$9637a8b0$b400a8c0@eventhorizon>
MIME-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_NextPart_000_000F_01C02FBD.F7FC10B0"
In-Reply-To: <39D21A61.445CC61F@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C02FBD.F7FC10B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

I was just having a second look at io.h, cos i'm using a hacked up version for
some ppcboot stuff, and I noticed that when CONFIG_APUS is on read doesn't
eieio, and when its on it does, surely readw/writew, etc shouldn't eieio and
in/out, etc should? infact the whole thing seems a bit of a mess.
attached are the functions I'm using for pci accesses in ppcboot. Doubt it'll be
of any use, but I thought you might be interested.


Thanks,
Rob Taylor
Flying Pig Systems

>
> > presumably this is due to int in/out macros adding _IO_BASE to the pointer?
>
> Yes.
>
> > ... So
> > am I right in thinking that it makes sense to use in/out for ISA
> accesses (if
> > _IO_BASE is set correctly for your platform) and readb/writeb/..
> for the rest of
> > your memory mapped registers?
>
>
> Well, yes, today.  Some of us have been "fighting" about this lately.
> I'm not a fan of address arithmetic in the inb/outb, so probably on
> 8xx and 82xx you will always have some "opaque" handle to in/out that
> doesn't resemble any notion of x86 "ports".  The reason is that on
> these 8xx and 82xx systems (and potentially others) we don't have very
> flexible host bridges, or the processors are used in complex multiple
> PCI bus configurations where the notion of "bus 0" may not exist.  You
> can't assume using a hard coded (or legacy) port number will get you
> anywhere but a bus fault.
>
>
> 	-- Dan
>
>

------=_NextPart_000_000F_01C02FBD.F7FC10B0
Content-Type: application/octet-stream;
	name="pci_io.h"
Content-Disposition: attachment;
	filename="pci_io.h"
Content-Transfer-Encoding: quoted-printable

/* originally from linux source (asm-ppc/io.h).
 * Sanity added by Rob Taylor, Flying Pig Systems, 2000
 */
#ifndef _PCI_IO_H_
#define _PCI_IO_H_

#include <io.h>

#define pcimem_readb(addr) (*(volatile u8 *) (addr))
#define pcimem_writeb(b,addr) ((*(volatile u8 *) (addr)) =3D (b))
#define pciio_readb(addr) (*(volatile u8 *) (addr)); eieio()
#define pciio_writeb(b,addr) ((*(volatile u8 *) (addr)) =3D (b)); =
eieio()

#if !defined(__BIG_ENDIAN)
#define pcimem_readw(addr) (*(volatile u16 *) (addr))
#define pcimem_readl(addr) (*(volatile u32 *) (addr))
#define pcimem_writew(b,addr) ((*(volatile u16 *) (addr)) =3D (b))
#define pcimem_writel(b,addr) ((*(volatile u32 *) (addr)) =3D (b))
#else
#define pcimem_readw(addr) pcimem_read_le16((volatile u16 *)(addr))
#define pcimem_readl(addr) pcimem_read_le32((volatile u32 *)(addr))
#define pcimem_writew(b,addr) pcimem_write_le16((volatile u16 =
*)(addr),(b))
#define pcimem_writel(b,addr) pcimem_write_le32((volatile u32 =
*)(addr),(b))
#endif

#if !defined(__BIG_ENDIAN)
#define pciio_readw(addr) (*(volatile u16 *) (addr)); eieio()
#define pciio_readl(addr) (*(volatile u32 *) (addr)); eieio()
#define pciio_writew(b,addr) ((*(volatile u16 *) (addr)) =3D (b)); =
eieio()
#define pciio_writel(b,addr) ((*(volatile u32 *) (addr)) =3D (b)); =
eieio()
#else
#define pciio_readw(addr) pcimem_read_le16((volatile u16 *)(addr)); =
eieio()
#define pciio_readl(addr) pcimem_read_le32((volatile u32 *)(addr)); =
eieio()
#define pciio_writew(b,addr) pcimem_write_le16((volatile u16 =
*)(addr),(b)); eieio()
#define pciio_writel(b,addr) pcimem_write_le32((volatile u32 =
*)(addr),(b)); eieio()
#endif

extern inline int pcimem_read_le16(volatile unsigned short *addr)
{
    int ret;

    __asm__ __volatile__("lhbrx %0,0,%1" : "=3Dr" (ret) :
                  "r" (addr), "m" (*addr));
    return ret;
}

extern inline void pcimem_write_le16(volatile unsigned short *addr, int =
val)
{
    __asm__ __volatile__("sthbrx %1,0,%2" : "=3Dm" (*addr) :
                  "r" (val), "r" (addr));
}


extern inline unsigned pcimem_read_le32(volatile unsigned *addr)
{
    unsigned ret;

    __asm__ __volatile__("lwbrx %0,0,%1" : "=3Dr" (ret) :
                 "r" (addr), "m" (*addr));
    return ret;
}


extern inline void pcimem_write_le32(volatile unsigned *addr, int val)
{
    __asm__ __volatile__("stwbrx %1,0,%2" : "=3Dm" (*addr) :
                 "r" (val), "r" (addr));
}

#endif /* _PCI_IO_H_ */

------=_NextPart_000_000F_01C02FBD.F7FC10B0--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
