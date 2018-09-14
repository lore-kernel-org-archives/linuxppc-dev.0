Return-Path: <sathnaga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42BhhD50kkzF3XX
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 03:04:25 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8EGxKnI078815
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 13:04:22 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mgg2vag50-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 13:04:22 -0400
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sathnaga@linux.vnet.ibm.com>;
 Fri, 14 Sep 2018 13:04:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 14 Sep 2018 22:34:39 +0530
From: sathnaga <sathnaga@linux.vnet.ibm.com>
To: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, kvm-ppc@vger.kernel.org, paulus@ozlabs.org,
 sjitindarsingh@gmail.com, mikey@neuling.org
Subject: Re: KVM: PPC: Book3S HV: Fix guest r11 corruption with POWER9 TM
 workarounds
In-Reply-To: <20180914165657.GB6306@MiWiFi-R3L-srv>
References: <20180914165657.GB6306@MiWiFi-R3L-srv>
Message-Id: <b3c1442f7afc59d70fa813e29254f8f7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2018-09-14 22:26, sathnaga@linux.vnet.ibm.com wrote:
> Date: Thu, 13 Sep 2018 15:33:47 +1000
> From: Michael Neuling <mikey@neuling.org>
> To: mpe@ellerman.id.au
> Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
> paulus@ozlabs.org, sjitindarsingh@gmail.com, mikey@neuling.org
> Subject: KVM: PPC: Book3S HV: Fix guest r11 corruption with POWER9 TM
> workarounds
> 
> When we come into the softpatch handler (0x1500), we use r11 to store
> the HSRR0 for later use by the denorm handler.
> 
> We also use the softpatch handler for the TM workarounds for
> POWER9. Unfortunately, in kvmppc_interrupt_hv we later store r11 out
> to the vcpu assuming it's still what we got from userspace.
> 
> This causes r11 to be corrupted in the VCPU and hence when we restore
> the guest, we get a corrupted r11. We've seen this when running TM
> tests inside guests on P9.
> 
> This fixes the problem by only touching r11 in the denorm case.
> 
> Fixes: 4bb3c7a020 ("KVM: PPC: Book3S HV: Work around transactional
> memory bugs in POWER9")
> Cc: <stable@vger.kernel.org> # 4.17+
> Test-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
> Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
Tested-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Test details: 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1792501

Regards,
-Satheesh.

> diff --git a/arch/powerpc/kernel/exceptions-64s.S
> b/arch/powerpc/kernel/exceptions-64s.S
> index ea04dfb8c0..2d8fc8c9da 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1314,9 +1314,7 @@ EXC_REAL_BEGIN(denorm_exception_hv, 0x1500, 
> 0x100)
> 
>  #ifdef CONFIG_PPC_DENORMALISATION
>  	mfspr	r10,SPRN_HSRR1
> -	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
>  	andis.	r10,r10,(HSRR1_DENORM)@h /* denorm? */
> -	addi	r11,r11,-4		/* HSRR0 is next instruction */
>  	bne+	denorm_assist
>  #endif
> 
> @@ -1382,6 +1380,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_207S)
>   */
>  	XVCPSGNDP32(32)
>  denorm_done:
> +	mfspr	r11,SPRN_HSRR0
> +	subi	r11,r11,4
>  	mtspr	SPRN_HSRR0,r11
>  	mtcrf	0x80,r9
>  	ld	r9,PACA_EXGEN+EX_R9(r13)
> 
