Message-ID: <160c01c2b8c3$0db674f0$9900010a@aztec.local>
From: "Frederic Soulier" <soulier@aztec-radiomedia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <DB0585C9F6F9D411BE8F00D0B7896A4CC0601F@SNCMAIL>
Subject: Very slow shell from internal MPC8241 UART
Date: Fri, 10 Jan 2003 17:12:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

  I'm using kernel linux-2.4.17-mvl21 on a custom board based on a MPC8241.
  Everything looks ok until my ramdisk shell is executed : it is *very*
slow.
  For my tests I use simple-Ramdisk (available on the Denx ftp site).

  I use the internal UART of the MPC8241 (IRQ 137). It looks to work fine
for U-Boot and for displaying Linux boot messages.

  I've found some threads from this mailing-list about the same problem.
Solutions were about EPIC configuration.
  I use only the internal EPIC (no external 8259), my EPIC configuration is
very simple and no external interrupts are generated at this time.

  Here are the modifications that I've applied to my kernel in order to take
care of the internal UART (as described in
http://lists.linuxppc.org/linuxppc-embedded/200202/msg00056.html)

  1. Leave EUMBAR @ 0xFC000000
  2. Call io_block_mapping(0xfc000000, 0xfc000000, 0x04000000, _PAGE_IO); in
<platform>_map_io()
  3. Call mpc10x_bridge_init() w/ 0xfc000000 as the last parameter in
<platform>_find_bridge()

I've alse defined this UART to work with IRQ 137 :

#define STD_SERIAL_PORT_DFNS \
    { 0, BASE_BAUD, PPC200_SERIAL, 137, STD_COM_FLAGS,  \
     iomem_base: (u8 *)PPC200_SERIAL, io_type: SERIAL_IO_MEM }

w/ PPC200_SERIAL == 0xFC004500  (internal DUART channel #1)

After that the UART was working for the kernel boot messages before the
shell is executed.
The shell is awfully slow (16 caracters in one time every 30 seconds
approx.).

I've tried to add  the openpic_set_sources() as described in other threads
in order to take care of the IRQ #137 :

 1. Add openpic_set_sources(0, 138, NULL);  in <platform>_init_irq() but in
this case there is no more display from the shell.

 Please note that to do this modification I've had to replace
arch/ppc/kernel/open_pic.c and arch/ppc/kernel/open_pic_defs.h in order to
add the openpic_set_sources() function.
 The new open_pic.c and open_pic_defs.h came from linuxppc-2.4.18.

Any advice will be welcomed,

Best regards,

Frederic Soulier


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
