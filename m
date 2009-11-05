Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 353CEB7BB7
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 Nov 2009 16:16:48 +1100 (EST)
Subject: Re: [PATCH] powerpc/mm: Remove debug context clamping from nohash code
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1257377992.13611.77.camel@pasglop>
Date: Wed, 4 Nov 2009 23:16:39 -0600
Message-Id: <6BAA37ED-F9DB-43A6-867B-B63D65926185@kernel.crashing.org>
References: <1257377992.13611.77.camel@pasglop>
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 4, 2009, at 5:39 PM, Benjamin Herrenschmidt wrote:

> I inadvertently left that debug code enabled, causing the number of
> contexts to be clamped to 31 which is going to slow things down on
> 4xx and just plain breaks 8xx
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> arch/powerpc/mm/mmu_context_nohash.c |    4 ++--
> 1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/ 
> mmu_context_nohash.c
> index c2f93dc..be4f34c 100644
> --- a/arch/powerpc/mm/mmu_context_nohash.c
> +++ b/arch/powerpc/mm/mmu_context_nohash.c
> @@ -25,8 +25,8 @@
>  *     also clear mm->cpu_vm_mask bits when processes are migrated
>  */
>
> -#define DEBUG_MAP_CONSISTENCY
> -#define DEBUG_CLAMP_LAST_CONTEXT   31
> +//#define DEBUG_MAP_CONSISTENCY
> +//#define DEBUG_CLAMP_LAST_CONTEXT   31
> //#define DEBUG_HARDER
>
> /* We don't use DEBUG because it tends to be compiled in always  
> nowadays

Can you send this to stable.

- k
