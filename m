Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmfZc5Gp6zDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:11:51 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5CH8pvN068812
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 13:11:49 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b1vhvfvkr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 13:11:48 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Tue, 13 Jun 2017 03:11:46 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5CHBhXQ7143934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:11:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5CHBZP7014728
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 03:11:35 +1000
Date: Mon, 12 Jun 2017 22:41:38 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH 13/14] powerpc/64: runlatch CTRL[RUN] set optimisation
Reply-To: svaidy@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-14-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170611235835.7400-14-npiggin@gmail.com>
Message-Id: <20170612171138.GB4340@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nicholas Piggin <npiggin@gmail.com> [2017-06-12 09:58:34]:

> The CTRL register is read-only except bit 63 which is the run latch
> control. This means it can be updated with a mtspr rather than
> mfspr/mtspr.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/process.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index baae104b16c7..a44ea034c226 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -1960,12 +1960,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
>  void notrace __ppc64_runlatch_on(void)
>  {
>  	struct thread_info *ti = current_thread_info();
> -	unsigned long ctrl;
> -
> -	ctrl = mfspr(SPRN_CTRLF);
> -	ctrl |= CTRL_RUNLATCH;
> -	mtspr(SPRN_CTRLT, ctrl);
> 
> +	mtspr(SPRN_CTRLT, CTRL_RUNLATCH);
>  	ti->local_flags |= _TLF_RUNLATCH;
>  }
> 
> @@ -1973,13 +1969,9 @@ void notrace __ppc64_runlatch_on(void)
>  void notrace __ppc64_runlatch_off(void)
>  {
>  	struct thread_info *ti = current_thread_info();
> -	unsigned long ctrl;
> 
>  	ti->local_flags &= ~_TLF_RUNLATCH;
> -
> -	ctrl = mfspr(SPRN_CTRLF);
> -	ctrl &= ~CTRL_RUNLATCH;
> -	mtspr(SPRN_CTRLT, ctrl);
> +	mtspr(SPRN_CTRLT, 0);

Good idea.  Writing to CTRL register can change only the RUN field.
Was this any different in older generations?  Anton and Ben kept the
mfspr/mtspr part in earlier updates to this routine.

--Vaidy
