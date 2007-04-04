Return-Path: <tytso@thunk.org>
Received: from thunker.thunk.org (THUNK.ORG [69.25.196.29])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C6B8CDDF04
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Apr 2007 03:42:42 +1000 (EST)
Date: Wed, 4 Apr 2007 13:41:53 -0400
From: Theodore Tso <tytso@mit.edu>
To: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404174153.GI31973@thunk.org>
References: <1175663999.2932.8.camel@shinybook.infradead.org>
	<17939.15726.114059.679277@cargo.ozlabs.ibm.com>
	<1175666635.2932.17.camel@shinybook.infradead.org>
	<20070404.011208.120446173.davem@davemloft.net>
	<20070404083803.GA13134@flint.arm.linux.org.uk>
	<20070404122154.GF31973@thunk.org> <4613CF6A.2090407@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4613CF6A.2090407@zytor.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, David Miller <davem@davemloft.net>,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 09:16:42AM -0700, H. Peter Anvin wrote:
> One option would be to move the 8250-based serial ports, to, say, 
> /dev/ttyN* (for National Semiconductors -- the best I could come up 
> with) and redefine /dev/ttyS* as a serial port multiplexer which maps in 
> all the types, for the ones that really want dynamic mapping.

> Of course, now you have the potential of aliasing, again, which tends to 
> cause all kinds of headaches w.r.t. locking.  

That would break the 99.9% of the the world using Intel-based systems
which only have 8250's, for very little gain. 

Like it or not, /dev/ttySx and 8250 UART's are to serial ports what
the PCI is to system buses....

						- Ted
