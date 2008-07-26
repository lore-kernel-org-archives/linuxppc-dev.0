Return-Path: <benh@kernel.crashing.org>
Subject: Re: CONFIG_FRAME_POINTER [was [PATCH] x86: BUILD_IRQ say .text]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hugh@veritas.com>
In-Reply-To: <Pine.LNX.4.64.0807261122430.20543@blonde.site>
References: <Pine.LNX.4.64.0807211828470.26173@blonde.site>
	<20080724104459.GI28817@elte.hu>
	<Pine.LNX.4.64.0807251839190.20617@blonde.site>
	<1217022373.11188.115.camel@pasglop>
	<Pine.LNX.4.64.0807261122430.20543@blonde.site>
Content-Type: text/plain
Date: Sat, 26 Jul 2008 22:36:42 +1000
Message-Id: <1217075802.11188.129.camel@pasglop>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org, Ingo Molnar <mingo@elte.hu>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-kernel@vger.kernel.org, Mike Travis <travis@sgi.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-07-26 at 12:02 +0100, Hugh Dickins wrote:
> 
> Hmm, perhaps it is doing sibling calls differently even without the
> explicit -fno-optimize-sibling-calls (but when I add that option,
> the vmlinux size does go up another 4400).
> 
> Sorry, I'm most probably fussing over nothing,
> and wasting your time with my ignorance.

No you aren't, there is indeed something happening. It looks like gcc is
keeping a copy of each stack frame in r31, thus forcing to save/restore
that register, along function calls, possibly to help get reliable
frames for leaf functions. I don't think we use that "feature" in our
backtrace code though... so it won't harm in the sense that it won't
break things, but it will indeed bloat the code a little bit.

Maybe we should totally disable -fno-omit-frame-pointers on powerpc ...
either that or see about actually using that r31 linkage, though I'm not
sure it would be that useful.

I'll have to talk to our toolchain folks to figure out exactly what's
going on there.

Cheers,
Ben.
 
