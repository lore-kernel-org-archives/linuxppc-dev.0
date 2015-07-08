Return-Path: <catalin.marinas@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 8099C1A18AD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2015 21:06:59 +1000 (AEST)
Date: Wed, 8 Jul 2015 12:06:51 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Eric B Munson <emunson@akamai.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org,
 Michal Hocko <mhocko@suse.cz>, linux-am33-list@redhat.com,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-cris-kernel@axis.com, linux-mips@linux-mips.org,
 linux-s390@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-mm@kvack.org,
 linux-m68k@lists.linux-m68k.org, Vlastimil Babka <vbabka@suse.cz>,
 linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-api@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V3 2/5] mm: mlock: Add new mlock, munlock, and munlockall
 system calls
Message-ID: <20150708110651.GC6944@e104818-lin.cambridge.arm.com>
References: <1436288623-13007-1-git-send-email-emunson@akamai.com>
 <1436288623-13007-3-git-send-email-emunson@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436288623-13007-3-git-send-email-emunson@akamai.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 07, 2015 at 01:03:40PM -0400, Eric B Munson wrote:
> diff --git a/arch/arm/kernel/calls.S b/arch/arm/kernel/calls.S
> index 05745eb..514e77b 100644
> --- a/arch/arm/kernel/calls.S
> +++ b/arch/arm/kernel/calls.S
> @@ -397,6 +397,9 @@
>  /* 385 */	CALL(sys_memfd_create)
>  		CALL(sys_bpf)
>  		CALL(sys_execveat)
> +		CALL(sys_mlock2)
> +		CALL(sys_munlock2)
> +/* 400 */	CALL(sys_munlockall2)

s/400/390/

> diff --git a/arch/arm64/include/asm/unistd32.h b/arch/arm64/include/asm/unistd32.h
> index cef934a..318072aa 100644
> --- a/arch/arm64/include/asm/unistd32.h
> +++ b/arch/arm64/include/asm/unistd32.h
> @@ -797,3 +797,9 @@ __SYSCALL(__NR_memfd_create, sys_memfd_create)
>  __SYSCALL(__NR_bpf, sys_bpf)
>  #define __NR_execveat 387
>  __SYSCALL(__NR_execveat, compat_sys_execveat)
> +#define __NR_mlock2 388
> +__SYSCALL(__NR_mlock2, sys_mlock2)
> +#define __NR_munlock2 389
> +__SYSCALL(__NR_munlock2, sys_munlock2)
> +#define __NR_munlockall2 390
> +__SYSCALL(__NR_munlockall2, sys_munlockall2)

These look fine.

Catalin
