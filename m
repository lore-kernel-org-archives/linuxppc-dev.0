Message-ID: <3ADDDCFF.CB4B9A6F@nexus-tech.net>
Date: Wed, 18 Apr 2001 14:29:19 -0400
From: Kyle Harris <kharris@nexus-tech.net>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: sound driver on mpc823
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm working on a sound driver for the LM4548 (ac97 codec). I've taken
Dan Malek's cs4218_tdm driver and ported it to 2.4 kernel for a starting
point. I have a couple questions I hope someone can help me with.

The CPM reports underrun errors. The driver does not set the LAST bit
for any buffer descriptors and setting this bit prevents this error. But
only for a few bytes. If I set the data length to be greater than 16
bytes I still get underrun errors. The bit_clk (L1TCLK) is 12.288 MHz
and sync (L1RSYNC) is 48 kHz.

1) Why is the LAST bit never set? It seems this causes the application
to block waiting for completion. Which I guess is OK if the application
continues to send data to the driver. But is this desirable? How is the
device closed in this case?

2) Why do underrun errors occur even when the LAST bit is set? Is the
CPM unable to keep up at this data rate? Is this significant, or does
the driver/codec recover?

Thanks, Kyle.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
