Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQ6zf3BMXzDr7r
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 21:24:30 +1100 (AEDT)
In-Reply-To: <1458095370-26731-1-git-send-email-cyrilbur@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: powerpc: Fix possible unrecoverable exception caused by '70fe3d9'
Message-Id: <3qQ6zf1Kq9z9sDH@ozlabs.org>
Date: Wed, 16 Mar 2016 21:24:30 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-16-03 at 02:29:30 UTC, Cyril Bur wrote:
> Commit 70fe3d9 "powerpc: Restore FPU/VEC/VSX if previously used" introduces a
> call to restore_math() late in the syscall return path, after MSR_RI has been
> cleared. The MSR_RI flag is used to indicate whether the kernel can take
> another exception or not. A cleared MSR_RI flag indicates that the kernel
> cannot.
> 
> Unfortunately when a machine is under high load an SLB miss can occur in
> restore_math() which (with MSR_RI cleared) leads to an unrecoverable exception.
...
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/6e669f085d595cb6053920832c

cheers
