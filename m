Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179]) by ozlabs.org (Postfix) with ESMTP id 00781B6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Jul 2010 15:21:19 +1000 (EST)
Received: by gxk26 with SMTP id 26so2180835gxk.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 18 Jul 2010 22:21:17 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100716234918.GA31060@shareable.org>
References: <20100713230352.6781.18644.stgit@angua>
	<1279062881.4609.34.camel@c-dwalke-linux.qualcomm.com>
	<AANLkTin69tN3NQHD2wvkA0G-lj3f9tSZEnhzdyJdTh9m@mail.gmail.com>
	<1279064008.4609.48.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1007131941140.10598@xanadu.home>
	<1279124563.21162.14.camel@c-dwalke-linux.qualcomm.com>
	<20100716234918.GA31060@shareable.org>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Sun, 18 Jul 2010 23:20:57 -0600
Message-ID: <AANLkTilqZKk_tzGTLqhD7bNVGX_avXwy7_fXvoR96qNL@mail.gmail.com>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
To: Jamie Lokier <jamie@shareable.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniel Walker <dwalker@codeaurora.org>, linux-kbuild@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	=?ISO-8859-1?Q?Uwe_Kleine=2DK=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 16, 2010 at 5:49 PM, Jamie Lokier <jamie@shareable.org> wrote:
> Daniel Walker wrote:
>> > But all the rest is arbitrary and could be part of common shared
>> > profiles or the like in defconfig format.
>>
>> I'm sure most people will want to have a config isolated to their
>> specific device. That to me seems reasonable because everyone wants the
>> smallest possible kernel they can get for their given device.

Just to be clear (specifically for me as a maintainer) the purpose of
defconfigs is not to provide the best optimized kernel configuration
for each given board.  defconfigs are useful as a reasonable working
starting point, and to provide build coverage testing.

> Indeed, but people who want the smallest possible kernel for their
> specific device _in a particular use context_ tend to want:
>
> =A0- To disable support for parts of the device they aren't using.
> =A0 =A0For example, an SoC with integrated ethernet that isn't actually
> =A0 =A0wired up on their board, or where they're using an external ethern=
et
> =A0 =A0chip instead for some reason.
>
> =A0- To choose what's modular and what isn't, even for integrated
> =A0 =A0parts. =A0For example to control the bootup sequence, they might
> =A0 =A0want to delay integrated USB and IDE initialisation, which is done=
 by
> =A0 =A0making those modular and loading them after bringing up a splash
> =A0 =A0screen earlier in the boot scripts.
>
> So there is still a need to be able to override the drivers and
> settings, but it's still incredibly useful to have defaults which
> describe the SoC or board accurately.

Yes.  The defconfig is only a starting point.  Maintaining the actual
config for the shipped kernel is the job of the distribution vendor
and I have zero interest in maintaining those configurations in the
kernel tree.

g.
