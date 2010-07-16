Return-Path: <Catalin.Marinas@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
	[217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 68A37B6F07
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 02:24:42 +1000 (EST)
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
From: Catalin Marinas <catalin.marinas@arm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100713230352.6781.18644.stgit@angua>
References: <20100713230352.6781.18644.stgit@angua>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 16 Jul 2010 17:03:41 +0100
Message-ID: <1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
Mime-Version: 1.0
Cc: Daniel Walker <dwalker@codeaurora.org>, linux-kbuild@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <rmk@arm.linux.org.uk>,
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

On Wed, 2010-07-14 at 00:04 +0100, Grant Likely wrote:
> - It still doesn't resolve dependencies.  A solver would help with this.
>   For the time being I work around the problem by running the generated
>   config through 'oldconfig' and looking for differences.  If the files
>   differ (ignoring comments and generateconfig_* options) after oldconfig,
>   then the <board>_defconfig target returns a failure.  (but leaves the
>   new .config intact so the user can resolve it with menuconfig).  This
>   way at least the user is told when a Kconfig fragment is invalid.

It's not a solver but I'm pushing a patch to warn on selecting symbols
with unmet dependencies so that you can select further symbols (manual
solving). The patch is in linux-next but you also can grab it from:

http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-2.6-cm.git;a=commitdiff_plain;h=5d87db2d2a332784bbf2b1ec3e141486f4d41d6f

-- 
Catalin
