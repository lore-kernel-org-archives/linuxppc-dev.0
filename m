Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 1DC191007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 06:11:44 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
Date: Fri, 16 Jul 2010 22:11:31 +0200
References: <20100713230352.6781.18644.stgit@angua>
	<alpine.LFD.2.00.1007161439240.10598@xanadu.home>
	<AANLkTikqHnyFVJF0Pzwy2xtKeNSXYAPFdPkAkLiXK8Ls@mail.gmail.com>
In-Reply-To: <AANLkTikqHnyFVJF0Pzwy2xtKeNSXYAPFdPkAkLiXK8Ls@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007162211.31973.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>, linux-kbuild@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, Uwe
	=?iso-8859-1?q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 16 July 2010 20:46:17 Linus Torvalds wrote:
> Maybe a full "solver" is unnecessary, for example, but just a simple
> "automatically enable the direct dependencies and scream when it's not
> simple any more" would take care of 99% of the common cases, and then
> warn when it needs some manual help.

I think the recursion should also be limited to cases where the
dependency is a valid selectable option, i.e. not for

# this architecture does not support MMIO
config HAS_IOMEM 
	def_bool 'n'

config PCI
	bool "PCI Device drivers"
	depends on HAS_IOMEM

config FOO
	tristate "Some device driver"
	depends on PCI

In this case, it would be straightforward for the solver to enable PCI
for when something selects CONFIG_FOO, but it should print a warning
if this is attempted while HAS_IOMEM is unconditionally disabled,
since that puts it into the "not simple" category.

	Arnd
