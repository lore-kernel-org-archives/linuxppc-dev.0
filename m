Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysJcL0rKBzDqkv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 00:00:02 +1100 (AEDT)
In-Reply-To: <20171204052725.28195-1-david@gibson.dropbear.id.au>
To: David Gibson <david@gibson.dropbear.id.au>, npiggin@gmail.com
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mahesh@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Revert "powerpc: Do not call ppc_md.panic in fadump panic
 notifier"
Message-Id: <3ysJcK4XMCz9sRW@ozlabs.org>
Date: Thu,  7 Dec 2017 00:00:00 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-12-04 at 05:27:25 UTC, David Gibson wrote:
> This reverts commit a3b2cb30f252b21a6f962e0dd107c8b897ca65e4.
> 
> The earlier patch tried to fix problems with panic on powerpc in
> certain circumstances, where some output from the generic panic code
> was being dropped.
> 
> Unfortunately, it breaks things worse in other circumstances.  In
> particular when running a PAPR guest, it will now attempt to reboot
> instead of informing the hypervisor (KVM or PowerVM) that the guest
> has crashed.  The crash notification is important to some
> virtualization management layers.
> 
> Since the circumstances in which the original patch helped are
> somewhat obscure, revert it for now until we figure out how to do it
> properly.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/ab9dbf771ff9b6b7e814e759213ed0

cheers
