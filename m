Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZSwW1cmnzDw6Q
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 08:21:31 +1100 (AEDT)
Date: Fri, 9 Dec 2016 08:21:27 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fixup wrong LPCR_VRMASD value
Message-ID: <20161208212127.GB18411@fergus.ozlabs.ibm.com>
References: <20161208034213.21700-1-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161208034213.21700-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 08, 2016 at 09:12:13AM +0530, Aneesh Kumar K.V wrote:
> In commit a4b349540a26af ("powerpc/mm: Cleanup LPCR defines") we updated
> LPCR_VRMASD wrongly as below.
> 
> -#define   LPCR_VRMASD  (0x1ful << (63-16))
> +#define   LPCR_VRMASD_SH       47
> +#define   LPCR_VRMASD          (ASM_CONST(1) << LPCR_VRMASD_SH)
> 
> We initialize the VRMA bits in LPCR to 0x00 in kvm. Hence using a different
> mask value as above while updating lpcr should not have any impact.
> 
> This patch updates it to the correct value
> Fixes: a4b349540a26af ("powerpc/mm: Cleanup LPCR defines") we updated
> 
> Reported-by: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/reg.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 9e1499f98def..1c17e208db78 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -337,7 +337,7 @@
>  #define   LPCR_DPFD_SH		52
>  #define   LPCR_DPFD		(ASM_CONST(7) << LPCR_DPFD_SH)
>  #define   LPCR_VRMASD_SH	47
> -#define   LPCR_VRMASD		(ASM_CONST(1) << LPCR_VRMASD_SH)
> +#define   LPCR_VRMASD		(ASM_CONST(1f) << LPCR_VRMASD_SH)

Don't you need an 0x in there?  Did you compile-test this?

Paul.
