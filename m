Reply-To: <jwalden@digitalatlantic.com>
From: "Jerry Walden" <jwalden@digitalatlantic.com>
To: "Linux PPC embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: Bringing up Linux kernel of custom 405gpr board dies in serial_putc
Date: Mon, 17 Mar 2003 18:56:12 -0500
Message-ID: <EGEGIJHKDKJGAJMGIDPNIEJDCJAA.jwalden@digitalatlantic.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings:

I am trying to bring up the Monta Vista Kernel
(Linux-2.4.18_mvl30) on a custom 405GPr based
board.  I can bring up u-boot just fine and dandy -
all the u-boot peripheral configurations work
just fine.

I am using a BDI-2000 to assist in debugging.

I perform the following steps:

1) Reset the board using the BDI
2) U-boot comes up just fine
3) I issue the halt command from the BDI
4) I issue the command - load 0x200000 vmlinux.PPCBoot BIN from the BDI
5) I issue the command - go 0x03xx_xxxx which continues the u-boot monitor
from the halt
6) I issue the imi command - imi 0x200000 - and it prints out that all is
well with the image
7) I issue the u-boot command - bootm 0x200000, and it proceeds to boot
linux and then I get not
   response or output after the message (Transferring control to Linux at
address 00000000...)

So in order to investigate what could be going wrong, before I issue the
bootm command in step
7, I halt the processor using the BDI, and have set succesive breakpoints
deeper into the code
until I think I have found the function which is causing problems -the code
below crashes in serial_putc
at the first readb.  It looks to me like the comport address is the same as
in my u-boot code,
as is the register offset UART_LSR.

Any ideas at what to look into further.

Kindest Regards,

Jerry


/* We assume that the UART has already been initialized by the
   firmware or the boot loader */
static void
serial_putc(u8 * com_port, unsigned char c)
{
	while ((readb(com_port + (UART_LSR)) & UART_LSR_THRE) == 0) ;
	writeb(c, com_port);
}

static void
ppc4xx_progress(char *s, unsigned short hex)
{
	char c;
#ifdef SERIAL_DEBUG_IO_BASE
	u8 *com_port = (u8 *) SERIAL_DEBUG_IO_BASE;

	while ((c = *s++) != '\0') {
		serial_putc(com_port, c);
	}
	serial_putc(com_port, '\r');
	serial_putc(com_port, '\n');
#else
	printk("%s\r\n");
#endif
}


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
