Subject: 8250  idma problem - cache?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Mon, 17 Mar 2003 14:56:40 -0800
Message-ID: <BD92DBD34D62AC4FA034933E33E53F7E1724D5@grog>
From: "Penn, John" <jpenn@magisnetworks.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am implementing IDMA, 2 channels(rx/tx), between the 8250
and a slow device attached to the local bus.  I seem
to have a transmit problem that could be explained
by the dcache holding the packet, its very small, and
the buffer being transmitted having old data or zeros
in it.

I have been reading through the archives regarding :
	invalidating the dcache - it's a nop for 8260
	snooping - tried enabling it on tx DGBL, no difference
			SIUMCR - ESE is enabled
	using local bus memory instead of 603 memory for buffers
		I would rather use 603 memory
	the 8260 is fully cache coherent so you don't have
		to invalidate the dcache.

Now I am at the point of needing some clarification.

1. 	Do I have to invalidate dcache and if so how?

2. 	Has anyone used the IDMA with 603 memory or must
	I use local bus memory?

John Penn


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
