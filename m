Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wdpC14Ld2zDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jun 2017 23:31:09 +1000 (AEST)
In-Reply-To: <1496022790-2017-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: mikey@neuling.org, paulus@samba.org, npiggin@gmail.com
Subject: Re: powerpc/64: Reclaim CPU_FTR_SUBCORE
Message-Id: <3wdpC13Z4cz9s8J@ozlabs.org>
Date: Thu,  1 Jun 2017 23:31:09 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-05-29 at 01:53:10 UTC, Michael Ellerman wrote:
> We are running low on CPU feature bits, so we only want to use them when
> it's really necessary.
> 
> CPU_FTR_SUBCORE is only used in one place, and only in C, so we don't
> need it in order to make asm patching work. It can only be set on
> "Power8" CPUs, which in practice means POWER8, POWER8E and POWER8NVL.
> There are no plans to implement it on future CPUs, but if there ever
> were we could retrofit it then.
> 
> Although KVM uses subcores, it never looks at the CPU feature, it either
> looks at the ISA level or the threads_per_subcore value.
> 
> So drop the CPU feature and do a PVR check instead. Drop the device tree
> "subcore" feature as we no longer support doing anything with it, and we
> will drop it from skiboot too.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Balbir Singh <bsingharora@gmail.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/0e5e7f5e9700661c3ddd95501743fb

cheers
