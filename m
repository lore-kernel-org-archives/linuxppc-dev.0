Return-Path: <alebas@televes.com>
Received: from tvesnat.televes.com (unknown [212.163.42.137])
	by ozlabs.org (Postfix) with ESMTP id 2D6702BE83
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 Nov 2004 05:57:53 +1100 (EST)
Message-ID: <1101236780.41a38a2c7f44f@webmail.televes.com:443>
Date: Tue, 23 Nov 2004 20:06:20 +0100
From: alebas@televes.com
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Kernel 2.6 hangs at m82xx_board_init
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I was trying to get kernel 2.6.10-rc1 running in mpc8272ads board,
but i have some problems.

Debugging with BDI2000 + gdb i have arrived to m82xx_board_init call,
which is coded in arch/ppc/platforms/pq2ads.c as:

void __init
m82xx_board_init(void)
{
        /* Enable the 2nd UART port */
        *(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_RS232_EN2;
}

When this code is executed, the kernel jumps directly to another
address, 0xc000984c, which is inside the __delay function, and
execution stays here in an infinite loop.

I get the following disassemble from objdump:

c01bf908 <m82xx_board_init>:
c01bf908:       3d 20 f4 50     lis     r9,-2992
c01bf90c:       61 29 00 04     ori     r9,r9,4
c01bf910:       80 09 00 00     lwz     r0,0(r9)      <=======
c01bf914:       54 00 02 0c     rlwinm  r0,r0,0,8,6
c01bf918:       90 09 00 00     stw     r0,0(r9)
c01bf91c:       4e 80 00 20     blr

and the marked instruction is the last one executed before the jump.

Any idea? Why this instruction is braching without control?

As bootloader i am using uboot-1.1.2.

Thanks.

Alex
