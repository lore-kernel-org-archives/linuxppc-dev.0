Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EE1DDDDDFB
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Aug 2008 08:52:46 +1000 (EST)
Subject: Re: Why does one "stw" fail with address translation disabled in
	PPC405EP?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhou Rui <vancasperz@yahoo.com.cn>
In-Reply-To: <1219479992.7565.17.camel@localhost>
References: <1219429635.8882.22.camel@zr.gii.upv.es>
	<20080822184213.GA24526@yoda.jdub.homelinux.org>
	<1219479992.7565.17.camel@localhost>
Content-Type: text/plain
Date: Sun, 24 Aug 2008 08:49:23 +1000
Message-Id: <1219531763.21386.202.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-08-23 at 10:26 +0200, Zhou Rui wrote:
> My board only has 32MB DRAM. Do you mean 32MB is not enough for that?
> The same codes can run well in a PPC440EP (Yosemite Board) which owns
> 256MB DRAM. At the beginning of my work, I thought memory size may be
> the cause of failure. But I did not know how to demonstrate it. So if
> the limitation of 32MB DRAM leads to the failure, are there any methods
> for the codes to solve it?

Well, it looks like the kernel is trying to access memory beyond 32M,
which would mean that the problem is that your kernel port or your
bootloader somewhat thinks there is more memory than there really is.

You need to look there... whatever passes the amount of memory to
the kernel at boot needs to be fixed.

Ben.
