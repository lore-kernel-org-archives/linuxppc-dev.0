Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tZSrH49stzDw6L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2016 08:17:50 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uB8LEuTK048635
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 8 Dec 2016 16:17:48 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 277b5h3ye5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Dec 2016 16:17:47 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Thu, 8 Dec 2016 14:17:47 -0700
Date: Thu, 8 Dec 2016 13:17:39 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: Fixup wrong LPCR_VRMASD value
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20161208034213.21700-1-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161208034213.21700-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20161208211739.GA5857@ram.oc3035372033.ibm.com>
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

  actually this was reported by He Jia.

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
						  ^^^^
		Shouldn't this be 0x1f instead of 1f  ?

RP
