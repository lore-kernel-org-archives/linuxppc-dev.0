Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 9B41BB6F14
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 06:08:15 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
Date: Fri, 16 Jul 2010 22:01:09 +0200
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
In-Reply-To: <AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201007162201.09629.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <rmk@arm.linux.org.uk>, Uwe
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

On Friday 16 July 2010 19:57:55 Grant Likely wrote:
> On Fri, Jul 16, 2010 at 10:03 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Wed, 2010-07-14 at 00:04 +0100, Grant Likely wrote:
> 
> sfr and I were talking about your patch the other day.  Just warning
> on incomplete dependencies is enough to make it actually workable for
> me (without my ugly post-processing step).  I was very happy to hear
> that it is in linux-next.
> 
> Last missing piece is being able to do "select FOO = n", which Stephen
> is currently working on.

Are there a lot of symbols for which this is needed? If there is only
a handful, you could work around this by selectively adding

config FOO
	bool "foo"
	default !FOO_DISABLE

config FOO_DISABLE
	def_bool "n"


		Arnd
