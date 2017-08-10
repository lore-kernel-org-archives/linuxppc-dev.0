Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSpfK5xLjzDqkX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 23:20:25 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
 benh@kernel.crashing.org, paulus@samba.org, davem@davemloft.net,
 dave.hansen@linux.intel.com
Cc: Khalid Aziz <khalid.aziz@oracle.com>, bsingharora@gmail.com, dja@axtens.net,
 tglx@linutronix.de, mgorman@suse.de, aarcange@redhat.com,
 kirill.shutemov@linux.intel.com, heiko.carstens@de.ibm.com, ak@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, sparclinux@vger.kernel.org,
 Khalid Aziz <khalid@gonehiking.org>
Subject: Re: [PATCH v7 7/9] mm: Add address parameter to arch_validate_prot()
In-Reply-To: <43c120f0cbbebd1398997b9521013ced664e5053.1502219353.git.khalid.aziz@oracle.com>
References: <cover.1502219353.git.khalid.aziz@oracle.com>
 <43c120f0cbbebd1398997b9521013ced664e5053.1502219353.git.khalid.aziz@oracle.com>
Date: Thu, 10 Aug 2017 23:20:24 +1000
Message-ID: <87tw1flftz.fsf@concordia.ellerman.id.au>
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

Khalid Aziz <khalid.aziz@oracle.com> writes:

> A protection flag may not be valid across entire address space and
> hence arch_validate_prot() might need the address a protection bit is
> being set on to ensure it is a valid protection flag. For example, sparc
> processors support memory corruption detection (as part of ADI feature)
> flag on memory addresses mapped on to physical RAM but not on PFN mapped
> pages or addresses mapped on to devices. This patch adds address to the
> parameters being passed to arch_validate_prot() so protection bits can
> be validated in the relevant context.
>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: Khalid Aziz <khalid@gonehiking.org>
> ---
> v7:
> 	- new patch
>
>  arch/powerpc/include/asm/mman.h | 2 +-
>  arch/powerpc/kernel/syscalls.c  | 2 +-
>  include/linux/mman.h            | 2 +-
>  mm/mprotect.c                   | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
> index 30922f699341..bc74074304a2 100644
> --- a/arch/powerpc/include/asm/mman.h
> +++ b/arch/powerpc/include/asm/mman.h
> @@ -40,7 +40,7 @@ static inline bool arch_validate_prot(unsigned long prot)
>  		return false;
>  	return true;
>  }
> -#define arch_validate_prot(prot) arch_validate_prot(prot)
> +#define arch_validate_prot(prot, addr) arch_validate_prot(prot)

This can be simpler, as just:

#define arch_validate_prot arch_validate_prot

cheers
