Message-ID: <8D7C5F56B409554D9D46AC22195807F3157073@exchwenz01.dmcwave.co.nz>
From: Richard Williams <richard_williams@stratexnet.com>
To: linux <linuxppc-embedded@lists.linuxppc.org>
Subject: 8xx uart driver problems
Date: Wed, 8 Oct 2003 09:23:48 +1300 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have been investigating a problem with the 8xx_io/uart.c driver included
in Denx's 2.4.4 kernel. We have a system where under certain circumstances,
the MPC855's SCC locks up when a large amount of noise is received by it.
The problem occurs just after pppd opens the SCC port.

I can prevent the lock up by either of the following modifications to the
driver.

1. In rs_8xx_interrupt(), move the clearing of events from after the
transmit_chars() function to before receive_chars(). Previously, if a new rx
buffer is filled while in transmit_chars(), the interrupt will be lost. If
the buffers are full when this interrupt is lost, no more interrupts will be
generated and serial rx will be stalled.

2. Enable the BUSY interrupt and process rx buffers when one occurs.

		events = sccp->scc_scce;
		sccp->scc_scce = events;   // <- Clear events here
		if (events & (SCCM_RX | SCCM_BSY)) //Process rx when busy
occurs
			receive_chars(info);
		if (events & SCCM_TX)
			transmit_chars(info);
		// sccp->scc_scce = events;     <- Old clear events position


Either of these changes fixes the lock up problem so I implemented both for
the sake of completeness. But another problem has appeared. If the SCC is
subjected to noise when opening, the driver/CPM can sometimes get in to a
state where some of the buffers are either repeated or received out of
order. After the noise is replaced by good data, ppp gets horribly confused
and the channel is unusable.

Incidentally, when noise is received most characters have framing errors and
an interrupt is generated for each received character. So at 38400 baud up
to 3800 interrupts/sec occur.

My questions are;
Are there any good reasons for NOT making either of the above changes?
Are there any known problems caused by receiving noise on SCC's?

Regards,
Richard

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
