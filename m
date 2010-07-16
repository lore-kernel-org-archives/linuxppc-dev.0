Return-Path: <nico@fluxnic.net>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by ozlabs.org (Postfix) with ESMTP id 878431007E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 04:19:34 +1000 (EST)
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_U9KoSnX60WFa5f75LV2Wvg)"
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007;
	32bit))
	with ESMTP id <0L5N000ZKXKJ2YD0@VL-MH-MR002.ip.videotron.ca> for
	linuxppc-dev@lists.ozlabs.org; Fri, 16 Jul 2010 14:19:32 -0400 (EDT)
Date: Fri, 16 Jul 2010 14:19:31 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-reply-to: <AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
Message-id: <alpine.LFD.2.00.1007161406120.10598@xanadu.home>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	=?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_U9KoSnX60WFa5f75LV2Wvg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Fri, 16 Jul 2010, Grant Likely wrote:

> On Fri, Jul 16, 2010 at 10:03 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Wed, 2010-07-14 at 00:04 +0100, Grant Likely wrote:
> >> - It still doesn't resolve dependencies.  A solver would help with this.
> >>   For the time being I work around the problem by running the generated
> >>   config through 'oldconfig' and looking for differences.  If the files
> >>   differ (ignoring comments and generateconfig_* options) after oldconfig,
> >>   then the <board>_defconfig target returns a failure.  (but leaves the
> >>   new .config intact so the user can resolve it with menuconfig).  This
> >>   way at least the user is told when a Kconfig fragment is invalid.
> >
> > It's not a solver but I'm pushing a patch to warn on selecting symbols
> > with unmet dependencies so that you can select further symbols (manual
> > solving). The patch is in linux-next but you also can grab it from:
> >
> > http://git.kernel.org/?p=linux/kernel/git/cmarinas/linux-2.6-cm.git;a=commitdiff_plain;h=5d87db2d2a332784bbf2b1ec3e141486f4d41d6f
> 
> sfr and I were talking about your patch the other day.  Just warning
> on incomplete dependencies is enough to make it actually workable for
> me (without my ugly post-processing step).  I was very happy to hear
> that it is in linux-next.
> 
> Last missing piece is being able to do "select FOO = n", which Stephen
> is currently working on.

Instead of (or in addition to) warning for incomplete 
dependencies, I'd much prefer if the prerequisites were recursively 
selected automatically.  This way if some options are moved inside a 
submenu at some point with a config symbol for that subcategory 
(e.g. CONFIG_NETDEV_1000), or if the subsystem is reorganized into 
submodules that are required for some driver to work, then my 
config will still be fine.

For example, if I want CONFIG_MTD_CMDLINE_PARTS=y, the system may be 
smart enough to notice and automatically enable CONFIG_MTD and 
CONFIG_MTD_PARTITIONS without having to carry those in the defconfig.


Nicolas

--Boundary_(ID_U9KoSnX60WFa5f75LV2Wvg)--
