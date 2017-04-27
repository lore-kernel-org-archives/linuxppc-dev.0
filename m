Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDCsC0tCKzDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 20:30:55 +1000 (AEST)
In-Reply-To: <1493122181-20921-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: bhsharma@redhat.com, keescook@chromium.org
Subject: Re: powerpc/mm: Fix possible out-of-bounds shift in arch_mmap_rnd()
Message-Id: <3wDCsC06ZSz9sNS@ozlabs.org>
Date: Thu, 27 Apr 2017 20:30:54 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-04-25 at 12:09:41 UTC, Michael Ellerman wrote:
> The recent patch to add runtime configuration of the ASLR limits added a bug in
> arch_mmap_rnd() where we may shift an integer (32-bits) by up to 33 bits,
> leading to undefined behaviour.
> 
> In practice it exhibits as every process seg faulting instantly, presumably
> because the rnd value hasn't been restricited by the modulus at all. We didn't
> notice because it only happens under certain kernel configurations and if the
> number of bits is actually set to a large value.
> 
> Fix it by switching to unsigned long.
> 
> Fixes: 9fea59bd7ca5 ("powerpc/mm: Add support for runtime configuration of ASLR limits")
> Reported-by: Balbir Singh <bsingharora@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/b409946b2a3c1ddcde75e5f35a77e0

cheers
