Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id ACFBFDDED1
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 03:42:15 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id k3so764999ugf
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 08:42:13 -0800 (PST)
Message-ID: <528646bc0701120842o1c06bc48h8785b5d00843fd74@mail.gmail.com>
Date: Fri, 12 Jan 2007 09:42:12 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: Fw: [Bugme-new] [Bug 7808] New: Xilinx ML403 does not boot
In-Reply-To: <528646bc0701112159m670f3a51r3061838080905dcc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20070111010358.851692fb.akpm@osdl.org>
	<528646bc0701110634v5eccd80aue030fcd25807a644@mail.gmail.com>
	<528646bc0701112159m670f3a51r3061838080905dcc@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, BSowislo@gmx.de,
	"bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> There is another question:
> the embed-config declares a static pointer bp
> for the info structure
> this pointer is used by the calling load_kernel
> routine.
> is a variable valid for the caller if it is declared
> in the context of a subroutine?

You mean this at line 28?

/* For those boards that don't provide one.
*/
#if !defined(CONFIG_MBX)
static  bd_t    bdinfo;
#endif

Yes, this is okay to pass around.

...

Let's get one possible issue out of the way: You said you used
ml430_defconfig as .config.  Did you do a 'make ml403_defconfig', or
did you just copy the file?  If you just copied the file, did you do a
'make oldconfig' before building?  If you didn't do either 'make
ml403_defconfig' or 'cp; make oldconfig' then you will probably have
config problems.

...

Try this: get an object dump of zImage and see where embed_config is
referenced.  Below are the relevant sections from my image.

The interesting bits are there are 2 definitions for embed_config (1
weak) in my zImage; but it is easy to see that the call to
embed_config is linked to the strong (correct) one at address 4005fc.
The weak one is at 400158.

What do you see?

$ ppc_4xx-objdump -dS arch/ppc/boot/images/zImage.elf | grep embed_config -C 5
  40014c:       39 20 00 00     li      r9,0
  400150:       7d 28 03 a6     mtlr    r9
  400154:       4e 80 00 20     blr
 */
void __attribute__ ((weak))
embed_config(bd_t **bdp)
{
}
  400158:       4e 80 00 20     blr

0040015c <load_kernel>:
--
        unsigned long initrd_size;

        /* First, capture the embedded board information.  Then
         * initialize the serial console port.
         */
        embed_config(&bp);
  400170:       38 61 00 18     addi    r3,r1,24
  400174:       90 01 00 44     stw     r0,68(r1)
  400178:       90 c1 00 18     stw     r6,24(r1)
  40017c:       48 00 04 81     bl      4005fc <embed_config>
#if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE)
        com_port = serial_init(0, bp);
  400180:       80 81 00 18     lwz     r4,24(r1)
  400184:       38 60 00 00     li      r3,0
  400188:       48 00 0f b5     bl      40113c <serial_init>
--
  4005ec:       bb 01 00 20     lmw     r24,32(r1)
  4005f0:       7c 08 03 a6     mtlr    r0
  4005f4:       38 21 00 40     addi    r1,r1,64
  4005f8:       4e 80 00 20     blr

004005fc <embed_config>:
         * - If the data cache is turned on this must have been done by
         *   a bootloader and we assume that the cache contents are
         *   valid.
         */
        __asm__("mfdccr %0": "=r" (dccr));
  4005fc:       7c 1a fa a6     mfdccr  r0
        if (dccr == 0) {
  400600:       2f 80 00 00     cmpwi   cr7,r0,0
  400604:       40 9e 00 1c     bne-    cr7,400620 <embed_config+0x24>
  400608:       38 00 01 00     li      r0,256
  40060c:       7c 09 03 a6     mtctr   r0
  400610:       39 20 00 00     li      r9,0
                for (addr = 0;
                     addr < (congruence_classes * line_size);
                     addr += line_size) {
                        __asm__("dccci 0,%0": :"b"(addr));
  400614:       7c 00 4b 8c     dccci   r0,r9
  400618:       39 29 00 20     addi    r9,r9,32
  40061c:       42 00 ff f8     bdnz+   400614 <embed_config+0x18>
                }
        }

        bd = &bdinfo;
        *bdp = bd;
