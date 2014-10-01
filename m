Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 805CB1A18EB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:13:31 +1000 (EST)
In-Reply-To: <1412073306-13812-4-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>, greg@kroah.com, arnd@arndb.de,
 mpe@ellerman.id.au, benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 03/17] powerpc/cell: Make spu_flush_all_slbs() generic
Message-Id: <20141001071330.E4262140174@ozlabs.org>
Date: Wed,  1 Oct 2014 17:13:30 +1000 (EST)
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-30-09 at 10:34:52 UTC, Michael Neuling wrote:
> diff --git a/arch/powerpc/include/asm/copro.h b/arch/powerpc/include/asm/copro.h
> index 2858108..f3d338f 100644
> --- a/arch/powerpc/include/asm/copro.h
> +++ b/arch/powerpc/include/asm/copro.h
> @@ -15,4 +15,10 @@ int copro_handle_mm_fault(struct mm_struct *mm, unsigned long ea,
>  
>  int copro_data_segment(struct mm_struct *mm, u64 ea, u64 *esid, u64 *vsid);
>  
> +
> +#ifdef CONFIG_PPC_COPRO_BASE
> +void copro_flush_all_slbs(struct mm_struct *mm);
> +#else
> +#define copro_flush_all_slbs(mm) do {} while(0)

This can be a static inline, so it should be. That way you get type checking on
the argument for CONFIG_PPC_COPRO_BASE=n.


cheers
