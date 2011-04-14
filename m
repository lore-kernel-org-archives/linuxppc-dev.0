Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AE666B6F41
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 12:52:17 +1000 (EST)
Subject: Re: Where is CONFIG_BOOT_LOAD ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Joachim =?ISO-8859-1?Q?F=F6rster?= <JOFT@gmx.de>
In-Reply-To: <4DA485CD.6060604@gmx.de>
References: <201104081128.37906.dargaud@lpsc.in2p3.fr>
	<1302255741.5359.7.camel@flotop>
	<201104081458.43831.dargaud@lpsc.in2p3.fr>
	<4DA485CD.6060604@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Apr 2011 12:52:07 +1000
Message-ID: <1302749527.28876.107.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org,
	Florian =?ISO-8859-1?Q?V=F6gel?= <fvoegel@partner.ime-actia.de>,
	Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-04-12 at 19:03 +0200, Joachim Förster wrote:
> Note that the default 0x400... is the link address of the zImage
> wrapper 
> rather than the one of THE kernel.
> 
> Currently the link address seems to be hard-coded into
> arch/powerpc/boot/wrapper
> (a shell script). Since long ago I'm wondering why the maintainers
> did 
> that. But I guess there is a reason, because it wasn't that way in
> the 
> old arch/ppc days ;-) ...
> 
> Is configuring the zImage-piggy-back-loader through menuconfig & co
> evil?

Well, not really evil but if you need a special setting for your board,
you add a case for that board in the wrapper script. The idea is that
the boot wrapper can be build outside of the kernel build tree itself.

IE. A distro could (and sometimes do) ship with the standalone boot
directory, possibly the .o's already built, and will "wrap" the zImage
at install time.

Cheers,
Ben.
