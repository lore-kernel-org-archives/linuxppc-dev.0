Date: Tue, 18 Sep 2001 02:49:08 +0200
From: cejka@inf.enst.fr
To: linuxppc-embedded@lists.linuxppc.org
Subject: MPC860 and audio codec MC145481 problems
Message-ID: <20010918024908.A18414@inf.enst.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi to all PowerPC masters,
  I'm very new in the PowerPC world and embedded systems. I'm trying
to find out the way how to control simple audio codec MC145481 by
PowerQUICC MPC860. Existing connection is as follows:
  PA0 (CLK8/L1TCLKB / TOUT4) to MCLK/BCLKR/BCLKT
  PA10 (TXD3 / L1RXDB) to DT
  PA11 (RXD3 / L1TXDB) to DR
  PB17 (L1ST3 / RTS3/L1RQb) to FSR/FST
Protocol to MC145481 is very simple: If I want to send anything, MCLK/BCLKR
is for main chip clock and a bit clock, DR is synchronous serial receive
line and FSR is frame sync. To send a byte, it is sufficient to produce one
clock pulse on FSR and then send a byte to DR with BCLKR rate. The problem
is that both clock signals MCLK/BCLKR/BCLKT and FSR/FST has to be generated
by PowerPC and there is none input sync signal into PowerPC.

Did anybody do similar thing already? I expect so. I can control audio
codec by busy loop in Linux kernel with cli()/sti() around this loop,
but as everybody knows, it is very bad solution, so I'm trying to use
serial interface, but still without any success.

I see two possible solutions, but then I have several questions:

* If I use SCCn in direct NMSI configuration, do I need to switch wires
  DT and DR to have connected them TXD3 -> DR and RXD3 -> DT instead of
  current TXD3 -> DT and RXD3 -> DR? And is there any possibility to
  generate baud rate clock on PB17? (I think no, but I would like to be
  sure.)

* If I use SCCn in TSA configuration over TDMB which looks more appropriate
  because of L1* signals, I can produce clock TOUT4 for audio codec by setting
  PAPAR[DD0] = 1 and PADIR[DR0] = 1, but is this TOUT4 signal availible
  internally on the same pin too for L1TCLKB (or CLK8) signal when there
  is PADIR[DR0] = 1? I understand from MPC860 manual that if I have
  external clock source on pin PA0 and PADIR[DR0] = 0, it can be used for
  both L1TCLKB and CLK8, but I could not find anything about possible
  internal connection (or disconnection?) between TOUT4 and L1TCLCB/CLK8
  on the same pin when PADIR[DR0] = 1. Maybe I can test it, but I do not
  know how to check L1TCLCB/CLK8. And the last question, for which I could
  not find answer in MPC860 manual: Is it possible to start data
  transmittion without external pulse on input L1TSYNCB signal? For this
  simple audio codec, I just have to produce strobe signal on L1ST3 and then
  send a data without any other synchronization, but in manual I see just
  in-line sync. pattern (???) (29.4.2.1) or default synchronization for
  receiving after channel is enabled (29.4.2.2), but not anything
  for default synchronization for transmitting.

Thanks to anybody, who would like to help,
  Rudolf

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
