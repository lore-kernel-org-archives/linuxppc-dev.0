Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound1-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4C586DDED6
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Jun 2007 05:01:05 +1000 (EST)
Message-ID: <4661B964.7060907@am.sony.com>
Date: Sat, 02 Jun 2007 11:39:32 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Maik Nijhuis <maik@cs.vu.nl>
Subject: Re: ps3 64-bit kernel: patched prpmc2800.c (fwd)
References: <Pine.GSO.4.63.0705250829380.19095@hydra.cs.vu.nl>
In-Reply-To: <Pine.GSO.4.63.0705250829380.19095@hydra.cs.vu.nl>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Maik Nijhuis wrote:
> While compiling a 64-bit kernel for the playstation 3 I noticed that
> arch/powerpc/boot/prpmc2800.c doesn't compile. The assembler complains
> about a constant that is too big.
> 
> And then this error follows:
> 
> /tmp/ccYHAOD7.s: Assembler messages:
> /tmp/ccYHAOD7.s:9: Error: operand out of range (0xffffffffffff7fff is not
> between 0x0000000000000000 and 0x00000000ffffffff)
> 
> I managed to fix this issue as follows: At the end of
> arch/powerpc/boot/prpmc2800.c, there is an assembly instruction
> 
> rlwinm  10,10,0,~(1<<15)
> 
> I replaced this by
> 
> rlwinm  10,10,0,~(1<<15) & ((1<<32)-1)
> 
> I am running 64-bit gentoo linux with binutils 2.17.50.0.16. It has been
> compiled on my ps3 using gentoo ebuild scripts.
> 
> Could you please either fix binutils or apply the above patch?

The trouble is that I have no way to test that change.  I don't have the
hardware.  Since that file is not for PS3, the best thing to do
is to not build that file when not building for prpmc2800.  I will
post a patch that does that.

-Geoff
