Date: Tue, 21 Nov 2000 15:20:56 +0100
From: Andi Kleen <ak@suse.de>
To: Todd Inglett <tinglett@vnet.ibm.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: bitops porting question
Message-ID: <20001121152056.A21375@gruyere.muc.suse.de>
References: <3A1A6E42.43E8663D@vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A1A6E42.43E8663D@vnet.ibm.com>; from tinglett@vnet.ibm.com on Tue, Nov 21, 2000 at 06:44:50AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 21, 2000 at 06:44:50AM -0600, Todd Inglett wrote:
> So set_bit(2, &b_state) will set a bit in the 4th byte of the virtual
> doubleword.  Not good.  A simple fix seems to be to change the
> set_bit(), etc, functions to 64 bit.  In general I think this is the
> best approach, but consider what will happen with the following:
>
>     int flags;		/* 32 bits */
>
>     set_bit(2, &flags);  /* bad memory ref! */
>
> On a little endian machine this won't happen since the low order bytes
> come first.

iirc David Miller did a big sweep of such things in the generic source
when doing the sparc64 port which has exactly the same problem.
To make sure you should probably define the macro so that you get
a warning for &flags being anything that unsigned long, e.g. using
a inline with a prototype and do a regular grep of the tree if anything
shows these warnings.


-Andi

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
