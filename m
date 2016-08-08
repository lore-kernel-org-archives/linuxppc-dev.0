Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s777w2bVnzDqS5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 16:40:12 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s777v5p15z9t1G
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 16:40:11 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u786dEpJ127117
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 02:40:09 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24nbrypyac-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Aug 2016 02:40:09 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 16:40:06 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8DC24357805B
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 16:40:04 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u786e4cE17236124
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 16:40:04 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u786e3Gb009799
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 16:40:04 +1000
Date: Mon, 8 Aug 2016 12:09:58 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv: Load correct TOC pointer while waking up from
 winkle.
Reply-To: svaidy@linux.vnet.ibm.com
References: <147040459202.19770.16560483806363144997.stgit@jupiter.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <147040459202.19770.16560483806363144997.stgit@jupiter.in.ibm.com>
Message-Id: <20160808063958.GE19419@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> [2016-08-05 19:13:12]:

> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> The function pnv_restore_hyp_resource() loads the TOC into r2 from
> the invalid PACA pointer before fixing r13 value. This do not affect
> POWER ISA 3.0 but it does have an impact on POWER ISA 2.07 or less
> leading CPU to get stuck forever.
> 
> 	login: [  471.830433] Processor 120 is stuck.
> 
> 
> This can be easily reproducible using following steps:
> - Turn off SMT
> 	$ ppc64_cpu --smt=off
> - offline/online any online cpu (Thread 0 of any core which is online)
> 	$ echo 0 > /sys/devices/system/cpu/cpu<num>/online
> 	$ echo 1 > /sys/devices/system/cpu/cpu<num>/online
> 
> For POWER ISA 2.07 or less, the last bit of HSPRG0 is set indicating
> that thread is waking up from winkle. Hence, the last bit of HSPRG0(r13)
> needs to be clear before accessing it as PACA to avoid loading invalid
> values from invalid PACA pointer.
> 
> Fix this by loading TOC after r13 register is corrected.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>

Acked-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>


> ---
>  arch/powerpc/kernel/idle_book3s.S |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 8a56a51..45784ec 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -363,8 +363,8 @@ _GLOBAL(power9_idle_stop)
>   * cr3 - set to gt if waking up with partial/complete hypervisor state loss
>   */
>  _GLOBAL(pnv_restore_hyp_resource)
> -	ld	r2,PACATOC(r13);
>  BEGIN_FTR_SECTION
> +	ld	r2,PACATOC(r13);
>  	/*
>  	 * POWER ISA 3. Use PSSCR to determine if we
>  	 * are waking up from deep idle state
> @@ -395,6 +395,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  	 */
>  	clrldi	r5,r13,63
>  	clrrdi	r13,r13,1
> +
> +	/* Now that we are sure r13 is corrected, load TOC */
> +	ld	r2,PACATOC(r13);
>  	cmpwi	cr4,r5,1
>  	mtspr	SPRN_HSPRG0,r13
> 

Thanks Mahesh for this fix.

--Vaidy

 
