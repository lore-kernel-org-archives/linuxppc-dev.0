Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3D5B1A0175
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Dec 2015 17:38:18 +1100 (AEDT)
In-Reply-To: <1448495096-24759-4-git-send-email-warrier@linux.vnet.ibm.com>
To: "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>, kvm@vger.kernel.org,
 linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: warrier@linux.vnet.ibm.com, paulus@samba.org, agraf@suse.de
Subject: Re: [v2,3/9] powerpc/powernv: Add icp_native_cause_ipi_rm
Message-Id: <20151207063818.69F79140319@ozlabs.org>
Date: Mon,  7 Dec 2015 17:38:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Subject would be better as "powerpc/xics".

On Wed, 2015-25-11 at 23:44:50 UTC, "Suresh E. Warrier" wrote:
> Function to cause an IPI. Requires kvm_hstate.xics_phys
> to be initialized with physical address of XICS.

Please expand the change log a bit, this is a bit terse.

> diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
> index eae3265..e39b18a 100644
> --- a/arch/powerpc/sysdev/xics/icp-native.c
> +++ b/arch/powerpc/sysdev/xics/icp-native.c
> @@ -159,6 +159,25 @@ static void icp_native_cause_ipi(int cpu, unsigned long data)
>  	icp_native_set_qirr(cpu, IPI_PRIORITY);
>  }
>  
> +void icp_native_cause_ipi_rm(int cpu)
> +{
> +	/*
> +	 * Currently not used to send IPIs to another CPU
> +	 * on the same core. Only caller is KVM real mode.
> +	 * Need the physical address of the XICS to be
> +	 * previously saved in kvm_hstate in the paca.
> +	 */
> +	unsigned long xics_phys;
> +
> +	/*
> +	 * Just like the cause_ipi functions, it is required to
> +	 * include a full barrier (out8 includes a sync) before
> +	 * causing the IPI.
> +	 */
> +	xics_phys = paca[cpu].kvm_hstate.xics_phys;
> +	out_rm8((u8 *)(xics_phys + XICS_MFRR), IPI_PRIORITY);
> +}

This doesn't build without KVM:

  arch/powerpc/sysdev/xics/icp-native.c:177:23: error: 'struct paca_struct' has no member named 'kvm_hstate'


Probably the whole function should be #ifdef CONFIG_KVM_BOOK3S_64_HV or
something.

cheers
