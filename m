Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 6F6BCDDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Jan 2007 19:37:41 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so1030527ugf
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Jan 2007 00:37:40 -0800 (PST)
Message-ID: <528646bc0701140037k71757790j8af48afac8391c75@mail.gmail.com>
Date: Sun, 14 Jan 2007 01:37:39 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Bernd Sowislo" <BSowislo@gmx.de>,
	"linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>
Subject: Re: Fw: [Bugme-new] [Bug 7808] New: Xilinx ML403 does not boot
In-Reply-To: <EJEFJPEGEFDHNKNCEDPOCEJDCEAA.BSowislo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <528646bc0701120842o1c06bc48h8785b5d00843fd74@mail.gmail.com>
	<EJEFJPEGEFDHNKNCEDPOCEJDCEAA.BSowislo@gmx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/14/07, Bernd Sowislo <BSowislo@gmx.de> wrote:
> High,
> you were right,
> the 4.1 version from 4.1-20060811 works
> with the weak statement

Good.

> but the kernel hangs
> after
> now booting the kernel
>
> even if I switch back to the old crosstool path
> (after make clean)
>
> now no version work
> any idea?

I'm using gcc 4.0.0 as packaged by ELDK 4.0; you might want to give it a tr=
y.

All I do is this to get a working image on linux 2.6.20rc4
$ make distclean
$ make CROSS_COMPILE=3Dppc_4xx- ARCH=3Dppc ml403_defconfig
$ make CROSS_COMPILE=3Dppc_4xx- ARCH=3Dppc menuconfig   # and disable XMON
$ make CROSS_COMPILE=3Dppc_4xx- ARCH=3Dppc zImage

Try that and see how it works.

Cheers,
g.

>
> -----Urspr=FCngliche Nachricht-----
> Von: glikely@gmail.com [mailto:glikely@gmail.com]Im Auftrag von Grant
> Likely
> Gesendet: Freitag, 12. Januar 2007 17:42
> An: Andrew Morton
> Cc: linuxppc-dev@ozlabs.org; BSowislo@gmx.de;
> bugme-daemon@kernel-bugs.osdl.org
> Betreff: Re: Fw: [Bugme-new] [Bug 7808] New: Xilinx ML403 does not boot
>
>
> > There is another question:
> > the embed-config declares a static pointer bp
> > for the info structure
> > this pointer is used by the calling load_kernel
> > routine.
> > is a variable valid for the caller if it is declared
> > in the context of a subroutine?
>
> You mean this at line 28?
>
> /* For those boards that don't provide one.
> */
> #if !defined(CONFIG_MBX)
> static  bd_t    bdinfo;
> #endif
>
> Yes, this is okay to pass around.
>
> ...
>
> Let's get one possible issue out of the way: You said you used
> ml430_defconfig as .config.  Did you do a 'make ml403_defconfig', or
> did you just copy the file?  If you just copied the file, did you do a
> 'make oldconfig' before building?  If you didn't do either 'make
> ml403_defconfig' or 'cp; make oldconfig' then you will probably have
> config problems.
>
> ...
>
> Try this: get an object dump of zImage and see where embed_config is
> referenced.  Below are the relevant sections from my image.
>
> The interesting bits are there are 2 definitions for embed_config (1
> weak) in my zImage; but it is easy to see that the call to
> embed_config is linked to the strong (correct) one at address 4005fc.
> The weak one is at 400158.
>
> What do you see?
>
> $ ppc_4xx-objdump -dS arch/ppc/boot/images/zImage.elf | grep embed_config=
 -C
> 5
>   40014c:       39 20 00 00     li      r9,0
>   400150:       7d 28 03 a6     mtlr    r9
>   400154:       4e 80 00 20     blr
>  */
> void __attribute__ ((weak))
> embed_config(bd_t **bdp)
> {
> }
>   400158:       4e 80 00 20     blr
>
> 0040015c <load_kernel>:
> --
>         unsigned long initrd_size;
>
>         /* First, capture the embedded board information.  Then
>          * initialize the serial console port.
>          */
>         embed_config(&bp);
>   400170:       38 61 00 18     addi    r3,r1,24
>   400174:       90 01 00 44     stw     r0,68(r1)
>   400178:       90 c1 00 18     stw     r6,24(r1)
>   40017c:       48 00 04 81     bl      4005fc <embed_config>
> #if defined(CONFIG_SERIAL_CPM_CONSOLE) ||
> defined(CONFIG_SERIAL_8250_CONSOLE)
>         com_port =3D serial_init(0, bp);
>   400180:       80 81 00 18     lwz     r4,24(r1)
>   400184:       38 60 00 00     li      r3,0
>   400188:       48 00 0f b5     bl      40113c <serial_init>
> --
>   4005ec:       bb 01 00 20     lmw     r24,32(r1)
>   4005f0:       7c 08 03 a6     mtlr    r0
>   4005f4:       38 21 00 40     addi    r1,r1,64
>   4005f8:       4e 80 00 20     blr
>
> 004005fc <embed_config>:
>          * - If the data cache is turned on this must have been done by
>          *   a bootloader and we assume that the cache contents are
>          *   valid.
>          */
>         __asm__("mfdccr %0": "=3Dr" (dccr));
>   4005fc:       7c 1a fa a6     mfdccr  r0
>         if (dccr =3D=3D 0) {
>   400600:       2f 80 00 00     cmpwi   cr7,r0,0
>   400604:       40 9e 00 1c     bne-    cr7,400620 <embed_config+0x24>
>   400608:       38 00 01 00     li      r0,256
>   40060c:       7c 09 03 a6     mtctr   r0
>   400610:       39 20 00 00     li      r9,0
>                 for (addr =3D 0;
>                      addr < (congruence_classes * line_size);
>                      addr +=3D line_size) {
>                         __asm__("dccci 0,%0": :"b"(addr));
>   400614:       7c 00 4b 8c     dccci   r0,r9
>   400618:       39 29 00 20     addi    r9,r9,32
>   40061c:       42 00 ff f8     bdnz+   400614 <embed_config+0x18>
>                 }
>         }
>
>         bd =3D &bdinfo;
>         *bdp =3D bd;
>
>


--=20
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
