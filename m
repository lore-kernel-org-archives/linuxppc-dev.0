Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F4C91A0163
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2015 07:20:42 +1000 (AEST)
In-Reply-To: <1440669019-23800-2-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matt Ochs <mrochs@us.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 mikey <mikey@neuling.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 Ian Munsie <imunsie@au1.ibm.com>
Subject: Re: [2/2] cxl: Fix force unmapping mmaps of contexts allocated
 through the kernel api
Message-Id: <20150830212042.0C2DB140273@ozlabs.org>
Date: Mon, 31 Aug 2015 07:20:41 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-27-08 at 09:50:19 UTC, Ian Munsie wrote:
> From: Ian Munsie <imunsie@au1.ibm.com>
> 
> The cxl user api uses the address_space associated with the file when we
> need to force unmap all cxl mmap regions (e.g. on eeh, driver detach,
> etc). Currently, contexts allocated through the kernel api do not do
> this and instead skip the mmap invalidation, potentially allowing them
> to poke at the hardware after such an event, which may cause all sorts
> of trouble.
> 
> This patch allocates an address_space for cxl contexts allocated through
> the kernel api so that the same invalidate path will for these contexts
> as well. We don't use the anonymous inode's address_space, as doing so
> could invalidate any mmaps of completely unrelated drivers using
> anonymous file descriptors.
> 
> This patch also introduces a kernelapi flag, so we know when freeing the
> context if the address_space was allocated by us and needs to be freed.
> 
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/55e07668fbba9466e6a9ef76

cheers
