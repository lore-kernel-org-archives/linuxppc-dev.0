From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15612.5934.333737.934644@argo.ozlabs.ibm.com>
Date: Tue, 4 Jun 2002 11:26:06 +1000 (EST)
To: Dan Malek <dan@embeddededge.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: CONFIG_PIN_TLB and telnet problems
In-Reply-To: <3CFC0FDD.1060607@embeddededge.com>
References: <20020531071550.GF16537@zax>
	<3CFC0FDD.1060607@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:

> As I mentioned in the first message, I suspect the problem is with the
> multiple mapping/access of data in the pinned and remapped areas.  Linux
> tends to allocate memory from the high end down, so if you consistent_alloc()
> some space on large memory systems, you are just remapping the attributes
> of a page.  If you do this on memory that is also covered by a large page,
> sometimes you will get the access through this large page, and others through
> an alternate mapping, which I believe confuses the MMU/cache with different
> attributes (which I was assured wouldn't cause problems on 4xx).

We have reproduced the problem using a ramdisk root and loopback, with
the ethernet disabled, so the only I/O device that is active is the
serial port, which doesn't use DMA.  So it doesn't look like it is
anything to do with DMA or with consistent_alloc.

Paul.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
