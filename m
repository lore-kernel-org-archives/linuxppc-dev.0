Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E564BDDFB6
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 09:51:08 +1100 (EST)
Subject: Re: [RFC/PATCH] [POWERPC] Make lmb support large physical addressing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <bgill@freescale.com>
In-Reply-To: <Pine.LNX.4.64.0802131639200.24317@monty.am.freescale.net>
References: <Pine.LNX.4.64.0802131639200.24317@monty.am.freescale.net>
Content-Type: text/plain
Date: Thu, 14 Feb 2008 09:50:42 +1100
Message-Id: <1202943042.7296.48.camel@pasglop>
Mime-Version: 1.0
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, davem@davemloft.net,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-02-13 at 16:43 -0600, Becky Bruce wrote:
> Convert the lmb code to use phys_addr_t instead of unsigned long for
> physical addresses and sizes.  This is needed to support large amounts
> of RAM on 32-bit systems that support 36-bit physical addressing.
> 
> Built/booted on mpc8641; build tested on pasemi and 44x.
> 
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
> Folks,
> 
> This has been sitting in my tree for a few days, and now it looks like
> David M. has submitted a patch that changes the lmb code to be shared
> between sparc and powerpc.  Sparc has no notion of a phys_addr_t.
> Should we just use u64 everywhere in this code instead?  Thoughts?

An option would be to use resource_size_t, though it's a bit yucky...

Dave, what do you prefer ?

Ben.
