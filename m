MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: 8xx_io/enet.c
Date: Tue, 10 Dec 2002 10:19:57 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31938190@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@medcare.is>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am hitting the following code (i.e. the printk() is reached) in the interrupt handler for the ethernet on a custom 823e board in arch/ppc/8xx_io/enet.c

	/* Check for receive busy, i.e. packets coming but no place to
	 * put them.  This "can't happen" because the receive interrupt
	 * is tossing previous frames.
	 */
	if (int_events & SCCE_ENET_BSY) {
		cep->stats.rx_dropped++;
		printk("CPM ENET: BSY can't happen.\n");
	}

Clearly this can happen, even though the comment sais otherwise.
This happens for a "high" datarate sunrpc interface operating over TCP/IP.

Is it safe to ignore this "error" or is it a real bug that should be investigated?

I am a litle unclear on the ethernet operation in whole.

Thanks, for any comment.

K.D.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
