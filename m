Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3EFD0B7124
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Oct 2010 08:28:16 +1000 (EST)
Subject: Re: Introduce support for little endian PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20101001220343.GA10494@lixom.net>
References: <1285916771-18033-1-git-send-email-imunsie@au1.ibm.com>
	<2C5357FA-F87F-457E-B5C1-0DCC5A842DE7@kernel.crashing.org>
	<AANLkTinSDMvBb7rnnfwYMkEVOgDUqRetZg86rh-UmSAg@mail.gmail.com>
	<1285935283.2463.78.camel@pasglop>
	<BBD78246-343E-4A96-9E55-3E40AD628C0B@kernel.crashing.org>
	<1285966315.2463.141.camel@pasglop> <20101001220343.GA10494@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 02 Oct 2010 08:28:02 +1000
Message-ID: <1285972082.2463.250.camel@pasglop>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-10-01 at 17:03 -0500, Olof Johansson wrote:
> > Maybe. Most of it doesn't seem to be that bit-rottable.
> > 
> > The changes to the asm stuff in misc_32.S for example are functions we
> > never ever touch once written (libgcc replacements) so I don't see them
> > rotting more with LE support than they did with BE :-)
> 
> Does KVM/qemu support running LE guest on BE host? That'd help keeping
> the bitrot lower. :) 

Not yet I suppose :-) But then, I'm not sure it would make a big
difference, if you have a 440 board in the first place, you can boot
either LE or BE, no need for a special FW or anything.

What we've done is basically keep the zImage wrapper BE (for now at
least), and have it trampoline to LE when executing the actual kernel
(using a cuImage, of course a device-tree enabled u-Boot would probably
need something akin to a proper ePAPR zImage to do that but that's
reasonably easy to do nowadays).


Cheers,
Ben.
