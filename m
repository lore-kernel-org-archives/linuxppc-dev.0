From: "Stephan Linke" <Stephan.Linke@epygi.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: FW: 8xx FEC gets stuck while like is down
Date: Wed, 2 Oct 2002 16:33:47 +0200
Message-ID: <FCEAKDJJAPHPLJFINDAJMEHECJAA.Stephan.Linke@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I discovered a strange behavior of the 8xx FEC driver. (kernel v2.4.18)
(PHY: LXT972)

During a test where I was sending pings on the FEC interface I
unplugged the cable for a few minutes. After reconnecting the
cable the FEC driver still refused sending new packets.

I figured out the following: The tx_full variable was still set and so
(verry likely) the wait queue was still deactivated.
Looks like the following happend: No one keept the xmit function from trying
to send  new data turing the time when a link was detected (fep->link =
0->1) and fec_restart() has not been called yet (due to delays by working
through the MII command list). So the TX buffer get filled and finaly the
tx_full condition occures causing the wait queue to be stoped. In
fec_restart() the skb in the TX buffers are discarded and transmition is
restarted. But no one took care of the tx_full condition so no one restarted
the wait queue.

Maybe some of my own changes caused that problem. (Mainly using bottom half
handlers for the events.) So I compaired it with the original sources: But
there's no reason why this shouldn't happen in ther normal sources (except
maybe a slightly relaxed timing).

I see two chances to avoid this condition:
  a) Completely disable the TX path during that time.
   (My current patch stops the transmit queue
    when the something changed at the PHY,
    waiting for fec_restart() to restart the queue.)
  b) Simply restart the wait queue at the end of fec_restart()
    every time it is disabled.

Any ideas?

Thanks, Stephan Linke


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
