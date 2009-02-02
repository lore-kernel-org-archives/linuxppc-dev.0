Return-Path: <Lixin.Yao@HSTX.com>
Received: from mail.hstx.com (mail.hstx.com [64.95.133.106])
	by ozlabs.org (Postfix) with ESMTP id D8B41DDF07
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 09:00:32 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Can not get PATA to work for Compact Flash with 2.6.28 kernel
Date: Mon, 2 Feb 2009 14:00:31 -0800
Message-ID: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4BC@exchtxus2.HSTX.global.vpn>
In-Reply-To: <49876AFB.3060207@harris.com>
References: <03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B2@exchtxus2.HSTX.global.vpn>
	<49870A66.8030302@harris.com>
	<03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B7@exchtxus2.HSTX.global.vpn>
	<49872152.1050902@harris.com>
	<03D77CA4AC7F4D48A6AB5DA3F1001B3F10A4B9@exchtxus2.HSTX.global.vpn>
	<49876AFB.3060207@harris.com>
From: "Lixin Yao" <Lixin.Yao@HSTX.com>
To: "Steven A. Falco" <sfalco@harris.com>
Cc: linuxppc-dev@ozlabs.org, Aaron Pace <kodiakuppercut@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I redefined io functions in libata-sff.c, byte operations are converted
to 16bit word operations. Maybe I should ask for HW changes in new
revisions of the board.

These are the changes I had to make in drivers/ata/libata-sff.c.
TR5000V2 is my board config define.

#if defined(CONFIG_TR5000V2)

#define ioread8(X) ide_inb(X)
#define iowrite8(X, Y) ide_outb(X, Y)
#define ioread16_rep(X, Y, Z) ide_read16_rep(X, Y, Z)
#define iowrite16_rep(X, Y, Z) ide_write16_rep(X, Y, Z)

static void inline ide_outb (u8 val, void __iomem *addr)
{
   asm("eieio");
   *(ushort *)addr =3D val;
   asm("eieio");
   asm("sync");
}

static unsigned char inline ide_inb(void __iomem *addr)
{
   ushort data16;
   data16 =3D *(volatile ushort *)(addr);
   asm("eieio");=20
   asm("sync");
   return data16;
}


static void ide_read16_rep(void __iomem *addr, void *dst, unsigned long
ulcount)
{
   const volatile u16 __iomem *port =3D addr;
   void *buf =3D dst;
   long count =3D ulcount;
   u16 *tbuf =3D buf;
   u16 tmp;

   if (unlikely(count <=3D 0))
      return;
   asm volatile("sync");
   do {
      tmp =3D *port;
      eieio();
      *tbuf++ =3D tmp>>8 | tmp<<8;
   } while (--count !=3D 0);
   asm volatile("twi 0,%0,0; isync" : : "r" (tmp));
}

static void ide_write16_rep(void __iomem *addr, const void *src,
unsigned long ulcount)
{
   volatile u16 __iomem *port =3D addr;
   const void *buf =3D src;
   long count =3D ulcount;  =20
   const u16 *tbuf =3D buf;

   if (unlikely(count <=3D 0))
      return;
   asm volatile("sync");
   do {
      *port =3D *tbuf<<8 | *tbuf>>8;
      tbuf++;
   } while (--count !=3D 0);
   asm volatile("sync");
}
#endif=20


I can mount DOS FS now.

>mknod /dev/sda1 b 8 1
>mount -t msdos /dev/sda1 /mnt

Thanks.

Lixin

-----Original Message-----
From: Steven A. Falco [mailto:sfalco@harris.com]=20
Sent: Monday, February 02, 2009 4:52 PM
To: Lixin Yao
Cc: Aaron Pace; linuxppc-dev@ozlabs.org
Subject: Re: Can not get PATA to work for Compact Flash with 2.6.28
kernel

Lixin Yao wrote:
> Steven/Aaron,
>=20
> I found the problem. On my board, the CF is on a 16 bit interface on
bus
> of MPC8248. The HW is connected in Big Endian format. PPC Bit D0 is
> connected to CF Bit D15, and PPC D1 to CF Bit D14, till PPC D0 to CF
> D15. I had to swap the bytes in u-boot. I forgot to do it in Kernel.=20
>=20
> After making the change, CF is detected. But I can not access /dev/hda
> or any scsi/sda devices under /dev.=20
>=20

How did you swap the bytes?  The CF will be accessed both in byte mode
and in 16-bit mode.  So this is tricky to do in software.  When we
wired our CF, we deliberately swapped the bytes in hardware.  So the
processor bus MSB goes to pin 6 of the CF.

	Steve
