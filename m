Date: Tue, 20 Nov 2001 16:19:37 -0800 (PST)
Message-Id: <20011120.161937.118616800.davem@redhat.com>
To: benh@kernel.crashing.org
Cc: anton@samba.org, billfink@mindspring.com,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: GigE Performance Comparison of GMAC and SUNGEM Drivers
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011121000518.8434@mailhost.mipsys.com>
References: <20011120.115015.10305322.davem@redhat.com>
	<20011121000518.8434@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   From: benh@kernel.crashing.org
   Date: Wed, 21 Nov 2001 01:05:18 +0100

   Ah, ok, I stand corrected. Is this a bug in the chip or a flaw of
   the GEM chip design ? I mean, is there a chance that later revs
   of the chip or eventually the one used by Apple can support it ?

There is no chance whatsoever of this ever working on any
GEM revision.

Even if it could work, GEM has a 9K transmit and 20K receive fifo in
the largest configuration.  Even the Acenic has 512k or 1MB of total
on-chip ram for packet buffering.

As a result GEM sends pause frames when there is even the slightest
amount of DMA traffic is has to compete with.  On a 33Mhz/32-bit PCI
bus, it is sending pause frames all the time even if it is the only
agent making use of the bus.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
