Message-ID: <3DB6A051.7A526641@corelatus.com>
Date: Wed, 23 Oct 2002 15:12:49 +0200
From: Thomas Lange <thomas@corelatus.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8xx enet collision counter
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Collisions in 8xx scc ethernet are not reported
correctly IMHO.

>From enet.c :
		/* Deferred means some collisions occurred during transmit,
		 * but we eventually sent the packet OK.
		 */
		if (bdp->cbd_sc & BD_ENET_TX_DEF)
			cep->stats.collisions++;

>From Table 28-8 in 860 UM:
------
6 DEF Defer indication. The frame was deferred before being sent
successfully,
that is, the transmitter had to wait for carrier sense before sending
because the line was busy.
This is not a collision indication; collisions are indicated in RC.
------
10-13 RC Retry count. Indicates the number of retries required before
the frame was sent successfully. If RC = 0, the frame was sent correctly
the first time. If RC = 15 and RET_LIM = 15 in the parameter RAM, 15
retries were required. Because the counter saturates at 15, if RC = 15
and RET_LIM > 15, then 15 or more retries were required. The controller
writes this field after it successfully sends the buffer.
------


The correct way to do it would be to use the RC value,
something like this:

		/* Check retry counter, i.e. collision counter */
		if (bdp->cbd_sc & BD_ENET_TX_RCMASK){
		  /* Note that counter cannot go higher than 15 */
		  cep->stats.collisions+=(bdp->cbd_sc & BD_ENET_TX_RCMASK)>>2;
		}

I have tried this and it looks much better. That is, when
tranceiver led signals collision, the collision counter actually
moves ;-)

/Thomas

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
