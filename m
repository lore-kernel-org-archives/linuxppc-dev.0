Message-Id: <scb472f8.096@mx.amx.com>
Date: Wed, 10 Apr 2002 17:14:08 -0500
From: "Chuck Partridge" <Chuck_Partridge@amx.com>
To: <gallen@arlut.utexas.edu>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8245 Internal Duart and Linux
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm using the South Bridge's 8259 controllers and putting the 8245 EPIC in pass through mode, so all internal 8245 interrupts are routed out the L_INT pin to one of the ALI's PCI_IRQ pins.

Does this seem like something very wrong?

I originally thought this would be the easiest way to handle this from an IRQ standpoint, but now know that I have never seen anyone else do this.

>>> Greg Allen <gallen@arlut.utexas.edu> 04/10/02 05:05PM >>>

>{ 0, BASE_BAUD_8245_DUART, AMX2275_SERIAL_2, 9, STD_COM_FLAGS, /* ttyS2 */ \
>   iomem_base: (u8 *)AMX2275_SERIAL_2,                             \
>   io_type: SERIAL_IO_MEM },                                       \
>{ 0, BASE_BAUD_8245_DUART, AMX2275_SERIAL_3, 9, STD_COM_FLAGS, /* ttyS3 */ \
>   iomem_base: (u8 *)AMX2275_SERIAL_3,                             \
>   io_type: SERIAL_IO_MEM },

This may or may not be the problem, but your IRQs are faulty.

The internal 8245 IRQs are 137 and 138.

You need to call openpic_set_sources() before openpic_init() to get
these initialized.

My utx8245_init_IRQ() contains:

     openpic_set_sources(0, 32, NULL);       /* up to serial interrupt 15 */
     openpic_set_sources(129, 3, NULL);      /* MPC8245 I2C, DMA0, DMA1 */
     openpic_set_sources(134, 1, NULL);      /* MPC8245 Message Unit */
     openpic_set_sources(137, 2, NULL);      /* MPC8245 DUART */
     openpic_init(1, 0, 0, -1);

L8r,
-Greg
--
  Gregory E. Allen, MSEE Engineering Scientist
  Applied Research Laboratories:
  The University of Texas at Austin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
