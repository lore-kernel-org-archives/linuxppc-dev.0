Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yp9Xy4YKkzDrZV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Dec 2017 21:31:14 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/mm: Invalidate subpage_prot() system call on
 radix platforms
In-Reply-To: <20171130061215.22861-1-khandual@linux.vnet.ibm.com>
References: <20171130061215.22861-1-khandual@linux.vnet.ibm.com>
Date: Fri, 01 Dec 2017 21:31:13 +1100
Message-ID: <87r2sebuz2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> Radix enabled platforms don't support subpage_prot() system calls. But
> at present the system calls goes through without an error and fails
> later on while validating expected subpage accesses. Lets not allow
> the system call on powerpc radix platforms to begin with to prevent
> this confusion in user space.
>
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/subpage-prot.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
> index 781532d..4005468 100644
> --- a/arch/powerpc/mm/subpage-prot.c
> +++ b/arch/powerpc/mm/subpage-prot.c
> @@ -195,6 +195,9 @@ long sys_subpage_prot(unsigned long addr, unsigned long len, u32 __user *map)
>  	unsigned long next, limit;
>  	int err;
>  
> +	if (radix_enabled())
> +		return -ENOSYS;

It's considered poor form for syscalls to return ENOSYS. That is meant
to mean one thing only, which is that the syscall does not exist.

See:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/asm-generic/errno.h#n10


Now arguably in this case ENOSYS does make some sense, because we'd
really like it if the syscall didn't exist when radix is enabled.

But I still don't like it, it means without changing the kernel version,
the syscall would appear or disappear based on which MMU mode you booted
into - which is weird.

So I think ENOENT would be better. It says "the thing you're trying to
access doesn't exist", where in this case "the thing" is "the subpage
protection map for this address range". It's better than EINVAL because
there's no implication that changing the arguments would result in
different behaviour.

cheers
