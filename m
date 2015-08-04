Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 399981A076F
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Aug 2015 20:08:58 +1000 (AEST)
In-Reply-To: <1438677058-12883-1-git-send-email-ego@linux.vnet.ibm.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: powerpc: Add an inline function to update HID0
Message-Id: <20150804100858.1F272140306@ozlabs.org>
Date: Tue,  4 Aug 2015 20:08:58 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-04-08 at 08:30:58 UTC, "Gautham R. Shenoy" wrote:
> Section 3.7 of Version 1.2 of the Power8 Processor User's Manual
> prescribes that updates to HID0 be preceded by a SYNC instruction and
> followed by an ISYNC instruction (Page 91).
> 
> Create a function name update_hid0() which follows this recipe and
> invoke it from the static split core path.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_ppc.h       | 11 +++++++++++

Why is it in there? It's not KVM related per se.

Where should it go? I think reg.h would be best, ideally near the definition
for HID0, though that's probably not possible because of ASSEMBLY requirements.
So at the bottom of reg.h ?

> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index c6ef05b..325f1d6 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -685,4 +685,15 @@ static inline ulong kvmppc_get_ea_indexed(struct kvm_vcpu *vcpu, int ra, int rb)
>  
>  extern void xics_wake_cpu(int cpu);
>  
> +static inline void update_hid0(unsigned long hid0)
> +{
> +	/*
> +	 *  The HID0 update should at the very least be preceded by a
> +	 *  a SYNC instruction followed by an ISYNC instruction
> +	 */
> +	mb();
> +	mtspr(SPRN_HID0, hid0);
> +	isync();

That's going to turn into three separate inline asm blocks, which is maybe a
bit unfortunate. Have you checked the generated code is what we want, ie. just
sync, mtspr, isync ?

cheers
