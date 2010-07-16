Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id D24A5B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 03:58:25 +1000 (EST)
Received: by gxk26 with SMTP id 26so1526874gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 16 Jul 2010 10:58:23 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 16 Jul 2010 11:57:55 -0600
Message-ID: <AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
To: Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Daniel Walker <dwalker@codeaurora.org>,
	linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
	Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <rmk@arm.linux.org.uk>,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 16, 2010 at 10:03 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Wed, 2010-07-14 at 00:04 +0100, Grant Likely wrote:
>> - It still doesn't resolve dependencies. =A0A solver would help with thi=
s.
>> =A0 For the time being I work around the problem by running the generate=
d
>> =A0 config through 'oldconfig' and looking for differences. =A0If the fi=
les
>> =A0 differ (ignoring comments and generateconfig_* options) after oldcon=
fig,
>> =A0 then the <board>_defconfig target returns a failure. =A0(but leaves =
the
>> =A0 new .config intact so the user can resolve it with menuconfig). =A0T=
his
>> =A0 way at least the user is told when a Kconfig fragment is invalid.
>
> It's not a solver but I'm pushing a patch to warn on selecting symbols
> with unmet dependencies so that you can select further symbols (manual
> solving). The patch is in linux-next but you also can grab it from:
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/cmarinas/linux-2.6-cm.git;a=
=3Dcommitdiff_plain;h=3D5d87db2d2a332784bbf2b1ec3e141486f4d41d6f

sfr and I were talking about your patch the other day.  Just warning
on incomplete dependencies is enough to make it actually workable for
me (without my ugly post-processing step).  I was very happy to hear
that it is in linux-next.

Last missing piece is being able to do "select FOO =3D n", which Stephen
is currently working on.

g.
