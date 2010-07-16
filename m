Return-Path: <jamie@shareable.org>
Received: from mail2.shareable.org (mail2.shareable.org [80.68.89.115])
	by ozlabs.org (Postfix) with ESMTP id 84ABAB6F17
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 17 Jul 2010 09:49:42 +1000 (EST)
Date: Sat, 17 Jul 2010 00:49:18 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Daniel Walker <dwalker@codeaurora.org>
Subject: Re: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
Message-ID: <20100716234918.GA31060@shareable.org>
References: <20100713230352.6781.18644.stgit@angua>
	<1279062881.4609.34.camel@c-dwalke-linux.qualcomm.com>
	<AANLkTin69tN3NQHD2wvkA0G-lj3f9tSZEnhzdyJdTh9m@mail.gmail.com>
	<1279064008.4609.48.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1007131941140.10598@xanadu.home>
	<1279124563.21162.14.camel@c-dwalke-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1279124563.21162.14.camel@c-dwalke-linux.qualcomm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kbuild@vger.kernel.org,
	Tony Lindgren <tony@atomide.com>,
	Nicolas Pitre <nico@fluxnic.net>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
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

Daniel Walker wrote:
> > But all the rest is arbitrary and could be part of common shared 
> > profiles or the like in defconfig format.
> 
> I'm sure most people will want to have a config isolated to their
> specific device. That to me seems reasonable because everyone wants the
> smallest possible kernel they can get for their given device.

Indeed, but people who want the smallest possible kernel for their
specific device _in a particular use context_ tend to want:

  - To disable support for parts of the device they aren't using.
    For example, an SoC with integrated ethernet that isn't actually
    wired up on their board, or where they're using an external ethernet
    chip instead for some reason.

  - To choose what's modular and what isn't, even for integrated
    parts.  For example to control the bootup sequence, they might
    want to delay integrated USB and IDE initialisation, which is done by
    making those modular and loading them after bringing up a splash
    screen earlier in the boot scripts.

So there is still a need to be able to override the drivers and
settings, but it's still incredibly useful to have defaults which
describe the SoC or board accurately.

-- Jamie
