Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <F1BED55F35F4D3118C0F00E0295CFF4DFF9E7F@mail.mediatrix.com>
From: Jean-Denis Boyer <jdboyer@mediatrix.com>
To: "'Ricardo Scop'" <scop@digitel.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Dan Malek <dan@embeddededge.com>, andy_lowe@mvista.com
Subject: RE: Kernel oops while routing
Date: Wed, 5 Dec 2001 13:01:28 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>      - in fcc_enet_start_xmit, after setting up another bd and
>      incrementing bdp, the next bd's tx-ready bit is tested in order
>      to stop the xmit queue if it is set, ok? But, sometimes, the CPM
>      may already have cleared this bit _and_ the corresponding
>      interrupt has not been serviced yet (because we're in a
>      spin_lock_irq); so, netif_stop_queue is not called in this case,
>      nor is tx_full set;
>
>      - next, the interrupt is serviced, but then curr_tx equals
>      dirty_tx _and_ tx_full is not set, so no sk_buffers are freed!

Yes! I totally agree with you, checking the ready bit in the buffer
descriptor is not guaranteed, even if the interrupts are masked, since the
CPM doesn't suspend its processing.

I have done many tests between two of our custom boards, that use an 8260
and a single FCC. I could effectively see a memory leak.

IMHO, I could suggest an easier patch, that would result in modifying only
one line of code, without changing the 'tx_full' logic. In function
fcc_enet_start_xmit, instead of checking the ready bit (which is bad), we
could only check if cur_tx has reached dirty_tx, and then call
netif_stop_queue. Does it make sense?


BTW, I worked hard last week in debugging the fcc_enet driver. It was not
handling correctly some transmission errors, resulting in the transmitter
completely stopping, without restarting. This is related to an errata
(CPM37) from Motorola about the 8260, concerning the way of restarting the
transmitter. If someone is interested, I can release a patch for that.



--------------------------------------------
 Jean-Denis Boyer, B.Eng., Technical Leader
 Mediatrix Telecom Inc.
 4229 Garlock Street
 Sherbrooke (Québec)
 J1L 2C8  CANADA
 (819)829-8749 x241
--------------------------------------------

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
