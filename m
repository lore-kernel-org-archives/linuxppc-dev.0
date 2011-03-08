Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 033F9B6EF0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 09:14:23 +1100 (EST)
Date: Tue, 8 Mar 2011 15:56:30 -0600
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: RFC: x86: kill binutils 2.16.x?
Message-ID: <20110308155630.1eb6f67d@schlenkerla>
In-Reply-To: <1299619716.22236.32.camel@pasglop>
References: <4D6E8932.1010405@zytor.com>
	<alpine.LFD.2.00.1103022152420.2701@localhost6.localdomain6>
	<4D6EB07C.5040004@zytor.com>
	<alpine.LFD.2.00.1103022216180.2701@localhost6.localdomain6>
	<4D6ECBDB.6090307@zytor.com> <20110303083035.GB14854@elte.hu>
	<AANLkTik4aTN8+Ob_GVwF17v6pDNGg2DEZJubBazs2e3L@mail.gmail.com>
	<1299619716.22236.32.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Kyle Moffett <kyle@moffetthome.net>,
	linux-kbuild <linux-kbuild@vger.kernel.org>,
	Kumar Gala <kumar.gala@freescale.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Kyle Moffett <Kyle.D.Moffett@boeing.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 Mar 2011 08:28:36 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2011-03-08 at 14:57 -0500, Kyle Moffett wrote:
> > 
> > Specifically the e500 doesn't have a normal PowerPC FPU, it has a
> > custom FPU built using extended integer registers instead, and it
> > happens to borrow the AltiVec opcode range to do it.
> > 
> > When trying to port Debian to the platform we were getting SIGILL's
> > all over the place until binutils got updated to reject all of the
> > unsupported opcodes on this particular platform.  Now of course we get
> > build errors, but that's a lot easier to debug and fix. :-D
> > 
> > Basically, binutils no longer supports "-many" (because too many
> > opcodes conflict), and the test itself would fail anyways (because
> > "dssall" is not valid on "any" PowerPC). 
> 
> Note that this freescale "SPE" fiasco is just that ... a fiasco :-) I
> don't think there's that many cases of opcode overlap outside of it.
> 
> Now regarding the kernel, the best is probably for nasty cases like that
> to use hand coded opcodes (see ppc-opcodes.h) and stick to a more
> "generic" setting for binutils, since it should be possible to build
> kernels that support multiple types of BookE CPUs with different
> floating point units.

Combined kernels between e500v1/2 and e500mc are currently not supported
for other reasons (current kconfig doesn't prohibit it, but it doesn't
work), such as a cache line size difference (a hardcoded L1_CACHE_BYTES is
used in various places for loops), an inability to enable SPE when e500mc
is enabled, etc.

Kumar recently internally said we're not going to bother making it work.
I'm inclined to agree, given you can't even run the same userspace (unless
you don't use hard floating point at all).  It's one thing to not want to
require a separate kernel for each board, but there's a point of
diminishing returns.

-Scott
