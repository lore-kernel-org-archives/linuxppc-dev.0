Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4072fy34bWzF0ws
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 23:20:10 +1100 (AEDT)
Subject: Re: [PATCH 14/19] powerpc/altivec: Add missing prototypes for altivec
To: Mathieu Malaterre <malat@debian.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
References: <20180322202007.23088-1-malat@debian.org>
 <20180322202007.23088-15-malat@debian.org>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <97df68d1-d4fe-bf8e-7852-9b418eec042f@c-s.fr>
Date: Fri, 23 Mar 2018 13:19:59 +0100
MIME-Version: 1.0
In-Reply-To: <20180322202007.23088-15-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 22/03/2018 à 21:20, Mathieu Malaterre a écrit :
> Some functions prototypes were missing for the non-altivec code. Add the
> missing prototypes directly in xor_vmx, fix warnings treated as errors with
> W=1:
> 
>    arch/powerpc/lib/xor_vmx_glue.c:18:6: error: no previous prototype for ‘xor_altivec_2’ [-Werror=missing-prototypes]
>    arch/powerpc/lib/xor_vmx_glue.c:29:6: error: no previous prototype for ‘xor_altivec_3’ [-Werror=missing-prototypes]
>    arch/powerpc/lib/xor_vmx_glue.c:40:6: error: no previous prototype for ‘xor_altivec_4’ [-Werror=missing-prototypes]
>    arch/powerpc/lib/xor_vmx_glue.c:52:6: error: no previous prototype for ‘xor_altivec_5’ [-Werror=missing-prototypes]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>   arch/powerpc/lib/xor_vmx.h | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/arch/powerpc/lib/xor_vmx.h b/arch/powerpc/lib/xor_vmx.h
> index 5c2b0839b179..2173e3c84151 100644
> --- a/arch/powerpc/lib/xor_vmx.h
> +++ b/arch/powerpc/lib/xor_vmx.h
> @@ -19,3 +19,17 @@ void __xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
>   void __xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
>   			     unsigned long *v2_in, unsigned long *v3_in,
>   			     unsigned long *v4_in, unsigned long *v5_in);
> +
> +void xor_altivec_2(unsigned long bytes, unsigned long *v1_in,
> +			     unsigned long *v2_in);
> +

Only used in one place, should be static instead of adding it in a .h

Same for the other ones.

Christophe


> +void xor_altivec_3(unsigned long bytes, unsigned long *v1_in,
> +			     unsigned long *v2_in, unsigned long *v3_in);
> +
> +void xor_altivec_4(unsigned long bytes, unsigned long *v1_in,
> +			     unsigned long *v2_in, unsigned long *v3_in,
> +			     unsigned long *v4_in);
> +
> +void xor_altivec_5(unsigned long bytes, unsigned long *v1_in,
> +			     unsigned long *v2_in, unsigned long *v3_in,
> +			     unsigned long *v4_in, unsigned long *v5_in);
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
