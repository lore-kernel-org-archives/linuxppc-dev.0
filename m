To: "Linux/PPC Development" <linuxppc-dev@lists.linuxppc.org>
Subject: Implementing support a PHY device connected to FCC2 on the PM826 board.
From: "vishal" <vishal@isofttech.com>
Reply-To: "vishal" <vishal@isofttech.com>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0
Message-Id: <20040808165523.1177387099.vishal@isofttech.com>
Date: Sun, 8 Aug 2004 16:55:23 +0530
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,
  I am trying to add the support for a Ethernet PHY device in the
PPC kernel. I am using a PM826 development board, With my PHY device
connected to the FCC2 via the PORTB lines.
  Most of the pins used in connecting the PHY to the FCC2 correspond to
the PORTB assignments.As is in the existing source:

#define PB2_TXER        ((uint)0x00000001)
#define PB2_RXDV        ((uint)0x00000002)
#define PB2_TXEN        ((uint)0x00000004)
#define PB2_RXER        ((uint)0x00000008)
#define PB2_COL         ((uint)0x00000010)
#define PB2_CRS         ((uint)0x00000020)
#define PB2_TXDAT       ((uint)0x000003c0)
#define PB2_RXDAT       ((uint)0x00003c00)

    ^^^ for these pins the existing code should suffice.
 The pins that are diffently implemented for the FCC2 are:
 1. The Recieve clock(Rx_CLK) is connected to CLK17 (PB17)
 2. The Transmit clock(Tx_CLK) is connected to CLK18 (PB16)
 3. The MDIO corresponds to PB15, & MDC corresponds to PB14.

 I am doing the following additional configuration (in init_fcc_ioports)for the
   1. setting PSORB to 1 for Rx_CLK &TxCLK pins.
   2. setting PDIRB to 0 Rx_CLK &TxCLK pins.
   3. setting PPARB to 1 for Rx_CLK &TxCLK pins.
   4. Setting the PDIRB (as input) for the MDIO & MDC pins
   5. Setting the PPARB (as General Purpose) the MDIO & MDC pins

     I expected this to work and atleast be able to read the PHY ID
during the fec_enet_init(), but It doesnt.
  I am *not* doing any settings for the ClockMask & clockroute register
of PORTB for FCC2. Is it needed considering my scenario?
  Or am i missing something else?

  Hope someone can point me out to anything else that needs to be handled?
  All help will be greatly appreciated.
  Thnaks in advance.

regards,
Vishal

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
