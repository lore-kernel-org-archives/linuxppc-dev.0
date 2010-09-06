Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [70.86.134.90])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4F223B6F10
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Sep 2010 01:45:28 +1000 (EST)
Date: Mon, 6 Sep 2010 10:45:26 -0500
From: Olof Johansson <olof@lixom.net>
To: Tirumala Marri <tmarri@apm.com>
Subject: Re: [PATCH] APM821xx: Add support for new SoC APM821xx
Message-ID: <20100906154526.GA515@lixom.net>
References: <1283464653-18492-1-git-send-email-tmarri@apm.com>
	<20100903020851.GC29732@hansolo.jdub.homelinux.org>
	<197d4509c0b1206ce2d686c03701a6b4@mail.gmail.com>
	<20100905222340.GC2150@lixom.net>
	<01bb9090932e6984c887273078fd586f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <01bb9090932e6984c887273078fd586f@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 05, 2010 at 10:19:53PM -0700, Tirumala Marri wrote:
> >
> > Then the device tree identifier, and the cpu setup functions, etc,
> > should indicate
> > 464, not APM821xx.
> This is new SoC based on 464 cpu core. All the previous SoC device tree
> CPU portion uses SoC name.

Hm, you're right. Confusing.

Still, the cpu setup functions would make more sense to have the core
name in, not the SoC name. Especially since multiple SoC families might
use the same core, etc.

> > Also, why add yet another defconfig? Isn't the eval board similar to
> > many others and can be supported with just a tweak of some existing
> > common defconfig instead?
> >
> Every new board needs new defconfig. And it is not same as others. It has
> Different features from other.

Actually, it doesn't. Linus has had a strong pushback to the ARM community
because of this mentality. arch/powerpc already has 100 defconfigs.

The use of devicetrees means that only the actual devices on your board,
will be configured, so it doesn't do any damage to compile in more drivers
than you happen to have. Thus generating a defconfig that is a superset
of some of your more common boards, or for example one per family of boards.

One of the arguments for having custom defconfigs per board is that customers that
base designs off of your eval board needs them. But they will make other changes
to the config to add drivers for whatever additional devices they have anyway.


-Olof
