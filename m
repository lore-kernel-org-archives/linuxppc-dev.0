Message-ID: <3E54FECB.5090604@embeddededge.com>
Date: Thu, 20 Feb 2003 11:14:03 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Brian Waite <waite@skycomputers.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Gary Thomas <gary@mlbassoc.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Disable cache on 74xx
References: <Pine.GSO.4.21.0302201507510.27212-100000@vervain.sonytel.be> <3E54F2EF.2080601@embeddededge.com> <200302201047.02490.waite@skycomputers.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Brian Waite wrote:

 > .... The memory controller (gt64260) seems to be
> doing something very wrong and it is thought to be a cache coherency issue.

The problem is cache coherency is central to the operation of processor
bus.  One possibility, especially in the example you described, is the gt
is generating incorrect cache coherency control cycles on the bus.  Disabling
the processor cache isn't going to affect this.

> So to prove this, I was asked to try running without any sort of cache.

Make sure you disable it in the memory controller as well.

> Hopefully between Gary's information and yours, Dan I can convince people
> that it is futile.

Linux is a very poor diagnostic tool.  When I run Linux and discover this
type of problem, I reduce it down into a non-Linux diagnostic that can
generate the same type of bus cycles.  That way you can just flash it into
rom and let some hardware engineer run it over and over without having to
boot up something as complex as Linux and sorting through millions of
bus cycles for the failure mode.  With these types of problems you have
to determine exactly what causes the failure.  Since the processor hangs
so completely it should be easy to see the condition of the failure.  If
it is a memory controller timing problem, you should see exactly what
failed and it should be clear how to program the controller to correct it.

Of course, like Ben said, check the errata.

Good Luck.


	-- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
