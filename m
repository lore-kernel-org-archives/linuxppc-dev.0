Message-ID: <003b01bfbc02$88afc3c0$4a1f76d8@washington>
From: "Navin Boppuri" <nboppuri@trinetcommunication.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: UART configuration problems
Date: Fri, 12 Jan 2001 19:06:00 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone,

I am trying to interface a MAX3100 uart to an SPI controller on the MPC823.
I have a functional SPI driver running. The transmit part of the UART works
just fine. I am able to transmit characters at 9600 8N1 baud. The problem
arises when I do a receive. The uart documentation says that the internal
fifo is 8 word long. But I notice that the FIFO is able to store only 8
characters. For example, if I transmit the characters
            abcdefghijklmnopqrstuvwxyz

The uart shows only "yz" in its buffers. The other 24 characters are lost. I
noticed that 8 charaters are written in the buffer. It first writes
"abcdefgh" and then overwrites that with "ijklmnop" and so on. The uart
generates an irq interrupt whenever there is incoming data. I do not see why
the buffer is not big enough.

Can someone give me some insight into this problem? What do I need to do to
correct this?

Navin.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
