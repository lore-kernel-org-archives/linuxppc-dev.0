Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id CEA3F1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 04:21:49 +1000 (EST)
Received: by gyd10 with SMTP id 10so1528587gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 11:21:47 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <alpine.LFD.2.00.1007161406120.10598@xanadu.home>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 16 Jul 2010 12:21:27 -0600
Message-ID: <AANLkTilY0rvbp7brGsnyuGhPjFvpVYInNWlAlf5tT4zG@mail.gmail.com>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
To: Nicolas Pitre <nico@fluxnic.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <rmk@arm.linux.org.uk>, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 16, 2010 at 12:19 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 16 Jul 2010, Grant Likely wrote:
>
>> On Fri, Jul 16, 2010 at 10:03 AM, Catalin Marinas
>> <catalin.marinas@arm.com> wrote:
>> > On Wed, 2010-07-14 at 00:04 +0100, Grant Likely wrote:
>> >> - It still doesn't resolve dependencies. =A0A solver would help with =
this.
>> >> =A0 For the time being I work around the problem by running the gener=
ated
>> >> =A0 config through 'oldconfig' and looking for differences. =A0If the=
 files
>> >> =A0 differ (ignoring comments and generateconfig_* options) after old=
config,
>> >> =A0 then the <board>_defconfig target returns a failure. =A0(but leav=
es the
>> >> =A0 new .config intact so the user can resolve it with menuconfig). =
=A0This
>> >> =A0 way at least the user is told when a Kconfig fragment is invalid.
>> >
>> > It's not a solver but I'm pushing a patch to warn on selecting symbols
>> > with unmet dependencies so that you can select further symbols (manual
>> > solving). The patch is in linux-next but you also can grab it from:
>> >
>> > http://git.kernel.org/?p=3Dlinux/kernel/git/cmarinas/linux-2.6-cm.git;=
a=3Dcommitdiff_plain;h=3D5d87db2d2a332784bbf2b1ec3e141486f4d41d6f
>>
>> sfr and I were talking about your patch the other day. =A0Just warning
>> on incomplete dependencies is enough to make it actually workable for
>> me (without my ugly post-processing step). =A0I was very happy to hear
>> that it is in linux-next.
>>
>> Last missing piece is being able to do "select FOO =3D n", which Stephen
>> is currently working on.
>
> Instead of (or in addition to) warning for incomplete
> dependencies, I'd much prefer if the prerequisites were recursively
> selected automatically. =A0This way if some options are moved inside a
> submenu at some point with a config symbol for that subcategory
> (e.g. CONFIG_NETDEV_1000), or if the subsystem is reorganized into
> submodules that are required for some driver to work, then my
> config will still be fine.
>
> For example, if I want CONFIG_MTD_CMDLINE_PARTS=3Dy, the system may be
> smart enough to notice and automatically enable CONFIG_MTD and
> CONFIG_MTD_PARTITIONS without having to carry those in the defconfig.

I fully agree.  However, the warnings make the system work now while
we wait for a full solver to be implemented.

g.
