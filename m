Mime-Version: 1.0
Message-Id: <p05101505b8da65e8b244@[10.8.16.89]>
In-Reply-To: <scb46c71.006@mx.amx.com>
References: <scb46c71.006@mx.amx.com>
Date: Wed, 10 Apr 2002 17:05:30 -0500
To: "Chuck Partridge" <Chuck_Partridge@amx.com>
From: Greg Allen <gallen@arlut.utexas.edu>
Subject: Re: MPC8245 Internal Duart and Linux
Cc: linuxppc-embedded@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
