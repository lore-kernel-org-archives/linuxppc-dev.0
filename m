Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w9ntB1314zDqCC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Apr 2017 21:53:22 +1000 (AEST)
In-Reply-To: <1492698980-19510-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: bhsharma@redhat.com, keescook@chromium.org,
 kernel-hardening@lists.openwall.com
Subject: Re: [v2] powerpc/mm: Add support for runtime configuration of ASLR
 limits
Message-Id: <3w9nt9601Wz9s2P@ozlabs.org>
Date: Sun, 23 Apr 2017 21:53:21 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-04-20 at 14:36:20 UTC, Michael Ellerman wrote:
> Add powerpc support for mmap_rnd_bits and mmap_rnd_compat_bits, which are two
> sysctls that allow a user to configure the number of bits of randomness used for
> ASLR.
> 
> Because of the way the Kconfig for ARCH_MMAP_RND_BITS is defined, we have to
> construct at least the MIN value in Kconfig, vs in a header which would be more
> natural. Given that we just go ahead and do it all in Kconfig.
> 
> At least according to the code (the documentation makes no mention of it), the
> value is defined as the number of bits of randomisation *of the page*, not the
> address. This makes some sense, with larger page sizes more of the low bits are
> forced to zero, which would reduce the randomisation if we didn't take the
> PAGE_SIZE into account. However it does mean the min/max values have to change
> depending on the PAGE_SIZE in order to actually limit the amount of address
> space consumed by the randomisation.
> 
> The result of that is that we have to define the default values based on both
> 32-bit vs 64-bit, but also the configured PAGE_SIZE. Furthermore now that we
> have 128TB address space support on Book3S, we also have to take that into
> account.
> 
> Finally we can wire up the value in arch_mmap_rnd().
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/9fea59bd7ca541e5d0851f0b6dbca8

cheers
