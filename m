Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 5B5CBDDE34
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 10:19:09 +1100 (EST)
Date: Fri, 9 Nov 2007 17:19:27 -0600
From: Olof Johansson <olof@lixom.net>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH] Avoid unpaired stwcx. on some processors
Message-ID: <20071109231927.GA19415@lixom.net>
References: <11946460863124-git-send-email-becky.bruce@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11946460863124-git-send-email-becky.bruce@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 09, 2007 at 04:08:06PM -0600, Becky Bruce wrote:
> The context switch code in the kernel issues a dummy stwcx. to clear the
> reservation, as recommended by the architecture. However, some processors
> can have issues if this stwcx to address A occurs while the reservation
> is already held to a different address B.  To avoid this problem, the dummy
> stwcx. needs to be paired with a dummy lwarx to the same address.
> 
> This patch adds the dummy lwarx, and creates a cpu feature bit to indicate
> which cpus are affected. Tested on mpc8641_hpcn_defconfig in arch/powerpc;
> build tested in arch/ppc.

You're still exposed even with this patch. The stwcx is there to protect
from the cases where process 1 does lwarx and get context switched
out to process 2 that by pure random chance does a stwcx. to the same
reservation granule and succeeds, in spite of not having done the lwarx
(on this side of the context switch).

In exactly that case, process 2 will instead of doing a store to a
reservation it didn't take on it's own, do a dangling stwcx, which is
your erratum. Right?

Seems like a "better" (but still ugly) workaround would be to create a
_new_ reservation to a RA that's unavailable to any userspace process,
so that they could never do a successful store to it. That way you would
have stray reservations, but never dangling stwcx:es. No?


-Olof
