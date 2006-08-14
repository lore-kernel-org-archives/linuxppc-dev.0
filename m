Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17633.2179.582261.162544@cargo.ozlabs.ibm.com>
Date: Tue, 15 Aug 2006 09:34:27 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [PATCH] no-execute -- please test
In-Reply-To: <787b0d920608132141v729665ayac50674d5ad147f4@mail.gmail.com>
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
	<17631.62819.24167.555967@cargo.ozlabs.ibm.com>
	<787b0d920608132141v729665ayac50674d5ad147f4@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Albert Cahalan writes:

> The first is to avoid taking the initial fault on the segment
> which contains the instruction pointer.

Good idea.

> The second is to avoid cache or TLB invalidates or flushes
> in certain circumstances. OpenBSD developers report that
> this type of optimization is of great benefit on sparc and ppc.
> It's an optimization than is only valid when no-execute is
> in use, so the performance effects go both ways.

We have a bit per page that says if the page is icache dirty or not.
On machines with no-execute support, we already avoid flushing the
page until some process first tries to execute from it.  If we
extended that to this scheme, when we made a segment executable, we
would have to find and flush all icache-dirty pages in the segment (up
to 65536 pages).  We wouldn't want to do that every time we made a
segment executable - it would need to be optimized (e.g. keep a count
per segment of icache-dirty pages in the segment).

Paul.
