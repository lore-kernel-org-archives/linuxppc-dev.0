Message-ID: <38E2C513.F3A37159@embeddededge.com>
Date: Wed, 29 Mar 2000 22:08:03 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Tiny fix to fec.c for RPX boards using only fast ethernet
References: <20000330024703.3E3C0355E8@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:


> Sure, but there's only provision for a single MAC address in the bd_t
> struct,

The board descriptor is unique to every board configuration.  I have
some boards with three MACs, three unique Ethernet addresses, and the
bd_t has three Ethernet entries.  That's the "right" way.  My latest
change to the RPX Classic is to define two Ethernet addresses, and
these are assigned in the 'embed_config.c' functions.  The FEC just
always chooses the second one (board specific index).

> ....... Otherwise the MAC address the ROM monitor tells
> you about is different to the one the FEC uses.

That is now irrelevant.  The ROM monitor on the RPX boards is going
to be significantly different within weeks.  It will only use the
Ethernet address and the 10 Mbit SCC Ethernet.

> True, it just seemed to me to be a better default for other vendors...

The example will now be in the embedded configuration functions.  Load
your choice of Ethernet addresses there, and the FEC driver is just
built with which to select.  This further flows into the 8260 port
which can support multiple Fast Ethernet controllers.



	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
