Return-Path: <glikely@secretlab.ca>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179]) by ozlabs.org (Postfix) with ESMTP id 99627B6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 09:22:21 +1000 (EST)
Received: by gyd10 with SMTP id 10so3750616gyd.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Jul 2010 16:22:19 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1279062881.4609.34.camel@c-dwalke-linux.qualcomm.com>
References: <20100713230352.6781.18644.stgit@angua>
	<1279062881.4609.34.camel@c-dwalke-linux.qualcomm.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 13 Jul 2010 17:21:59 -0600
Message-ID: <AANLkTin69tN3NQHD2wvkA0G-lj3f9tSZEnhzdyJdTh9m@mail.gmail.com>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
To: Daniel Walker <dwalker@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kbuild@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
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

On Tue, Jul 13, 2010 at 5:14 PM, Daniel Walker <dwalker@codeaurora.org> wro=
te:
> On Tue, 2010-07-13 at 17:04 -0600, Grant Likely wrote:
>
>> - I haven't figured out a way for the fragment to force an option to
>> =A0 be "n", or to set a value, for example "CONFIG_LOG_BUF_SHIFT=3D16".
>> =A0 This may require changing the syntax.
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
> The solver would fix the whole issues with the defconfigs , we wouldn't
> need this Kconfig change .. From my perspective we shouldn't be fooling
> around with anything but the solver approach ..

The solver would complement Kconfig fragments, but it doesn't
implement all the functionality.  For instance, it doesn't help a
board config picking up a bunch of options from an SoC or Architecture
config file, especially things that are developer/maintainer choices
as opposed to hard requirements).  Solver on its own is an incremental
improvement over what we currently have, but it doesn't solve the
whole problem.

> It just doesn't feel like Kconfig was meant to do this, it feel like
> somewhat of an abuse ..

Why?  It uses the Kconfig language itself to specify additional
constraints on the final configuration.  Seems to be the essence of
elegance to me.  :-)

g.
