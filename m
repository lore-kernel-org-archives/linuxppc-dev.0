Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [66.141.50.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D13D8B7D5C
	for <linuxppc-dev@ozlabs.org>; Mon,  3 May 2010 11:33:29 +1000 (EST)
Date: Sun, 2 May 2010 20:43:29 -0500
From: Olof Johansson <olof@lixom.net>
To: "Tseng-Hui (Frank) Lin" <thlin@linux.vnet.ibm.com>
Subject: Re: [PATCH] add icswx support
Message-ID: <20100503014329.GA26805@lixom.net>
References: <1272060275.6329.13.camel@flin.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1272060275.6329.13.camel@flin.austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 23, 2010 at 05:04:35PM -0500, Tseng-Hui (Frank) Lin wrote:
> Add Power7 icswx co-processor instruction support.
> 
> Signed-off-by: Sonny Rao <sonnyrao@linux.vnet.ibm.com>
> Signed-off-by: Tseng-Hui (Frank) Lin <thlin@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mmu-hash64.h  |    3 +
>  arch/powerpc/include/asm/mmu_context.h |    4 ++
>  arch/powerpc/include/asm/reg.h         |    3 +
>  arch/powerpc/mm/mmu_context_hash64.c   |   79
> ++++++++++++++++++++++++++++++++
>  4 files changed, 89 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu-hash64.h
> b/arch/powerpc/include/asm/mmu-hash64.h
> index 2102b21..ba5727d 100644
> --- a/arch/powerpc/include/asm/mmu-hash64.h
> +++ b/arch/powerpc/include/asm/mmu-hash64.h
> @@ -421,6 +421,9 @@ typedef struct {
>  #ifdef CONFIG_PPC_SUBPAGE_PROT
>  	struct subpage_prot_table spt;
>  #endif /* CONFIG_PPC_SUBPAGE_PROT */
> +	unsigned long acop;
> +#define HASH64_MAX_PID (0xFFFF)
> +	unsigned int pid;

Way too generic a name. Please call it acop_pid or something similar.

Same with the define.

This is also growing the mm_struct by 16 bytes on all platforms, no
matter if the process in question is using the coprocessor or not.



-Olof
