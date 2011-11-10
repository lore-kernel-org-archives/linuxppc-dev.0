Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F3659B6F93
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2011 04:11:53 +1100 (EST)
Message-ID: <4EBC05D5.5080302@suse.de>
Date: Thu, 10 Nov 2011 18:11:49 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
Subject: Re: [PATCH] powerpc/kvm: fix build with older toolchains
References: <20111107233656.GB20208@us.ibm.com>
In-Reply-To: <20111107233656.GB20208@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/08/2011 12:36 AM, Nishanth Aravamudan wrote:
> Fix KVM build for older toolchains (found with .powerpc64-unknown-linux-gnu-gcc
> (crosstool-NG-1.8.1) 4.3.2):
>
>    AS      arch/powerpc/kvm/book3s_hv_rmhandlers.o
> arch/powerpc/kvm/book3s_hv_rmhandlers.S: Assembler messages:
> arch/powerpc/kvm/book3s_hv_rmhandlers.S:1388: Error: Unrecognized opcode: `popcntw'
> make[1]: *** [arch/powerpc/kvm/book3s_hv_rmhandlers.o] Error 1
> make: *** [_module_arch/powerpc/kvm] Error 2
>
> Signed-off-by: Nishanth Aravamudan<nacc@us.ibm.com>

Thanks, applied to kvm-ppc-next.


Alex

> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 0607909..a053db1 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1385,7 +1385,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_206)
>   	addi	r6,r5,VCORE_NAPPING_THREADS
>   31:	lwarx	r4,0,r6
>   	or	r4,r4,r0
> -	popcntw	r7,r4
> +	PPC_POPCNTW(r7,r4)
>   	cmpw	r7,r8
>   	bge	2f
>   	stwcx.	r4,0,r6
>
