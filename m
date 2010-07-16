Return-Path: <Catalin.Marinas@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
	[217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 5ED89B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 06:10:03 +1000 (EST)
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <AANLkTikqHnyFVJF0Pzwy2xtKeNSXYAPFdPkAkLiXK8Ls@mail.gmail.com>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
	<20100716183028.GB26854@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1007161439240.10598@xanadu.home>
	<AANLkTikqHnyFVJF0Pzwy2xtKeNSXYAPFdPkAkLiXK8Ls@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Jul 2010 21:09:36 +0100
Message-ID: <1279310976.18579.8.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Nicolas Pitre <nico@fluxnic.net>, lkml <linux-kernel@vger.kernel.org>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-07-16 at 19:46 +0100, Linus Torvalds wrote:
> On Fri, Jul 16, 2010 at 11:40 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >
> > DOH.
> 
> Well, it's possible that the correct approach is a mixture.
> 
> Automatically do the trivial cases (recursive selects, dependencies
> that are simple or of the form "x && y" etc), and warn about the cases
> that aren't trivial (where "not trivial" may not necessarily be about
> fundamentally ambiguous ones, but just "complex enough that I won't
> even try").

There is still a risk with this approach when the Kconfig isn't entirely
correct. For example, on ARM we have (I pushed a patch already):

config CPU_32v6K
	depends on CPU_V6

config CPU_V7
	select CPU_32v6K

In this simple approach, we end up selecting CPU_V6 when we only need
CPU_V7. There other places like this in the kernel.

Of course, kbuild could still warn but if people rely on this feature to
select options automatically I suspect they would ignore the warnings.

-- 
Catalin
