Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BE78CDDDE9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 07:08:29 +1100 (EST)
Subject: Re: [PATCH] Fix remainder calculating bug in single floating point
	division
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <11996296134110-git-send-email-Yu.Liu@freescale.com>
References: <11996296134110-git-send-email-Yu.Liu@freescale.com>
Content-Type: text/plain
Date: Mon, 07 Jan 2008 07:07:45 +1100
Message-Id: <1199650065.7291.81.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sun, 2008-01-06 at 22:26 +0800, Liu Yu wrote:
> This bug exists in the emulation of floating point division for powerpc.
> 
> The original code cannot count the remainder correctly. 
> I can provide a test case to trigger this bug. 
> When use fdiv to count 1.1754941e-38f / 0.9999999f, 
> the result is expected to be 1.175494e-38f, 
> but we will get 1.174921e-38f in the original case.

It's nice to see somebody digging in that scary math emu stuff. If you
could also get rid of the warnings, it would be perfect :-)

Now, appart from that, I seem to remember Dan telling me at some point
in the past (I think it was Dan... ) that this code was lifted from
somewhere else (glibc ? gcc soft-float ?), in which case it might be
worth to fix that somewhere else as well, or if it's already been fixed,
maybe resync. 

Cheers,
Ben.
