Date: Mon, 19 Apr 2004 11:56:34 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org
Subject: PPC440GX GigE support
Message-ID: <20040419115634.A19863@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I've pushed a bunch of code for this to the linux-2.5-ocp tree. It
overhauls the EMAC driver a bit and adds a number of fields to the
new OCP EMAC .additions field that are set per SoC or by the board
specific code.  There's support for GigE on EMAC2/3, the TAH,
zerocopy, and jumbo frames.

There's still work to be done on jumbo frames > 4062 MTU since
the RX side requires a copy. If we get some assumptions about
linear skbs in various protocol implementations removed, this can
be fixed. TSO support is the only major thing unimplemented.

Performance is right on par with an e1000 in the same platform,
showing anywhere from 700-850Mbps TX throughput depending on
MTU size and sendfile usage. RX range is slightly less.

Pull from bk://source.mvista.com/linux-2.5-ocp

Once the new OCP stuff goes into linux-2.5, I'll send some
version of this (plus previous EMAC driver work for 2.6) to
jgarzik.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
