Date: Wed, 5 Sep 2001 21:20:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: andrew may <acmay@acmay.homeip.net>,
	John Tyner <jtyner@cs.ucr.edu>, linuxppc-commit@source.mvista.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: patch for mktree.c on cross compiles
Message-ID: <20010905212050.K18940@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010905120613.I14548@ecam.san.rr.com> <3B968E75.A63F26EA@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B968E75.A63F26EA@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 05, 2001 at 04:43:33PM -0400, Dan Malek wrote:
> andrew may wrote:
> > I would think everything in arch/ppc/boot/utils should be checked
> > for endian problems on cross compiles.
>
> Are the network-host macros the right things to use?  That's what
> always comes to mind for me, but I suspect there is a more standard
> set of macros from 'endian.h' or something........If it's OK with
> everyone I'll check it in, but it does look kind of weird.

Well, after some quick digging, here's what I found.  If we include
<asm/byteoder.h>, and deal with some __'s, which are exported outside
of the kernel, we can use these.  But, it's getting late and my brain
is giving up after being fried for a while today, so I could be wrong,
but I _think_ we can use asm/byteorder.h, possibly make some changes
to mkbugboot/mkprep/mktree and it'll just work (The first two only work
on big endian or x86.  Not other LE machines, I think :))

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
