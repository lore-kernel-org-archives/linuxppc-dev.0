Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id C770F2BD46
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Oct 2004 00:56:27 +1000 (EST)
Date: Tue, 19 Oct 2004 07:27:54 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Conor McLoughlin <cml3227@eircom.net>
Message-ID: <20041019072754.A29957@home.com>
References: <1098072098.751.32.camel@nighteyes.localdomain>
	<41738D27.4060007@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41738D27.4060007@eircom.net>;
	from cml3227@eircom.net on Mon, Oct 18, 2004 at 10:30:15AM +0100
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Does kmalloc on MPC82xx work correctly with GFP_DMA?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Oct 18, 2004 at 10:30:15AM +0100, Conor McLoughlin wrote:
> I have been looking at the ethernet device driver (fcc_enet) for the
> mpc82xx platform. This allocates buffer descriptors using kmalloc with
> the GFP_DMA flag. As far as I can see on my platform, this allocates

GFP_DMA has no meaning on PPC. All memory is DMAable.  GFP_DMA is for
PeeCees with a limited ISA DMA space.  Drivers should be using GFP_KERNEL
so they don't confuse people.

> from the regular kernel memory (0xCxxxxxxx). As the attributes of this
> block of memory are controlled by the block address translation
> registers, this cannot be DMA safe, can it?

Sure it can. It works with hardware snooping.

> Is there something I am missing here?

Yes, it's a 603e core and hardware snooping support manages cache
coherency between system memory and devices.

-Matt
