Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401RBy512BzF0W6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 20:24:58 +1100 (AEDT)
In-Reply-To: <20180313231411.9537-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: sukadev@linux.vnet.ibm.com, npiggin@gmail.com
Subject: Re: powerpc/64s: Fix NULL AT_BASE_PLATFORM when using DT CPU features
Message-Id: <401RBx67Bzz9sVK@ozlabs.org>
Date: Wed, 14 Mar 2018 20:24:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-03-13 at 23:14:11 UTC, Michael Ellerman wrote:
> When running virtualised the powerpc kernel is able to run the system
> in "compat mode" - which means the kernel and hardware are pretending
> to userspace that the CPU is an older version than it actually is.
> 
> AT_BASE_PLATFORM is an AUXV entry that we export to userspace for use
> when we're running in that mode, which tells userspace the "platform"
> string for the real CPU version, as opposed to the faked version.
> 
> Although we don't support compat mode when using DT CPU features, and
> arguably don't need to set AT_BASE_PLATFORM, the existing cputable
> based code always sets it even when we're running bare metal. That
> means the lack of AT_BASE_PLATFORM is a user-visible artifact of the
> fact that the kernel is using DT CPU features, which we don't want.
> 
> So set it in the DT CPU features code also.
> 
> This results in eg:
>   $ LD_SHOW_AUXV=1 /bin/true | grep "AT_.*PLATFORM"
>   AT_PLATFORM:     power9
>   AT_BASE_PLATFORM:power9
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/e4b79900222b8cccd4da4a7a89581f

cheers
