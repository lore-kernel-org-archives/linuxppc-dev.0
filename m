Return-Path: <srs0=mzro=3f=au1.ibm.com=sam.bobroff@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsbhZ5VdczDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 14:18:54 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vsbhZ4f6nz8swH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 14:18:54 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vsbhZ1SPtz9s79
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2017 14:18:53 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2S3DZM9036037
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Mar 2017 23:18:45 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ff16th95-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Mar 2017 23:18:45 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sam.bobroff@au1.ibm.com>;
 Tue, 28 Mar 2017 13:13:42 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2S3DX4O39649388
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2017 14:13:41 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2S3D9Y8030481
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Mar 2017 14:13:09 +1100
Date: Tue, 28 Mar 2017 14:12:43 +1100
From: Sam Bobroff <sam.bobroff@au1.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 01/12] powerpc: Disable HFSCR:TM if TM not supported
References: <20170320065053.6CB64112051@b01ledav004.gho.pok.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170320065053.6CB64112051@b01ledav004.gho.pok.ibm.com>
Message-Id: <20170328031243.GA5808@tungsten.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 20, 2017 at 05:49:03PM +1100, Benjamin Herrenschmidt wrote:
> Otherwise KVM guests might mess with it even when told not
> to causing bad thing interrupts in the host
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

I've tested this on a P8, with a kernel and QEMU close to their
respective current master branches, and if:
* the host is configured without CONFIG_PPC_TRANSACTIONAL_MEM,
* and the guest is configured with CONFIG_PPC_TRANSACTIONAL_MEM,
* and the guest runs a program that uses HTM (in my tests, just a loop
  doing some floating point multiplies in a transaction)...

Without the patch the host will OOPS, usually in __kvmppc_vcore_entry,
and kill QEMU. On a busy host this is sometimes followed by "Oops: Bad
kernel stack pointer, sig: 6" and the host dies.

With the patch the userspace test program is killed with a SIGILL. The
guest and host are unaffected.

Cheers,
Sam.
> ---
>  arch/powerpc/kernel/setup_64.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 9cfaa8b..b372b23 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -236,6 +236,16 @@ static void cpu_ready_for_interrupts(void)
>  		mtspr(SPRN_LPCR, lpcr | LPCR_AIL_3);
>  	}
>  
> +	/*
> +	 * Fixup HFSCR:TM based on CPU features. The bit is set by our
> +	 * early asm init because at that point we haven't updated our
> +	 * CPU features from firmware and device-tree. Here we have,
> +	 * so let's do it
> +	 */
> +	if (early_cpu_has_feature(CPU_FTR_HVMODE) &&
> +	    !early_cpu_has_feature(CPU_FTR_TM_COMP))
> +		mtspr(SPRN_HFSCR, mfspr(SPRN_HFSCR) & ~HFSCR_TM);
> +
>  	/* Set IR and DR in PACA MSR */
>  	get_paca()->kernel_msr = MSR_KERNEL;
>  }
> -- 
> 2.9.3
