Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zs3fs1kpPzF1dC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Mar 2018 05:16:37 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1SIFV4i118424
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 13:16:34 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ge0n6tgxa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 13:16:33 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Wed, 28 Feb 2018 18:16:31 -0000
Date: Wed, 28 Feb 2018 23:46:23 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 2/3] powerpc/64s/idle: avoid sync for KVM state when
 waking from idle
Reply-To: svaidy@linux.vnet.ibm.com
References: <20171117140807.22105-1-npiggin@gmail.com>
 <20171117140807.22105-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20171117140807.22105-3-npiggin@gmail.com>
Message-Id: <20180228181623.GA20168@drishya.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Nicholas Piggin <npiggin@gmail.com> [2017-11-18 00:08:06]:

> When waking from a CPU idle instruction (e.g., nap or stop), the sync
> for ordering the KVM secondary thread state can be avoided if there
> wakeup is coming from a kernel context rather than KVM context.
> 
> This improves performance for ping-pong benchmark with the stop0 idle
> state by 0.46% for 2 threads in the same core, and 1.02% for different
> cores.

Cool, the improvement comes from avoiding the "sync" alone?
 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/kernel/idle_book3s.S | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 2f8364e7b489..07a306173c5a 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -532,6 +532,9 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
>  	mr	r3,r12
> 
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	lbz	r0,HSTATE_HWTHREAD_STATE(r13)
> +	cmpwi	r0,KVM_HWTHREAD_IN_KERNEL
> +	beq	1f
>  	li	r0,KVM_HWTHREAD_IN_KERNEL
>  	stb	r0,HSTATE_HWTHREAD_STATE(r13)
>  	/* Order setting hwthread_state vs. testing hwthread_req */

With this change, we will not check for HSTATE_HWTHREAD_REQ != 0 
condition but unconditionally goto host kernel if
HSTATE_HWTHREAD_STATE == KVM_HWTHREAD_IN_KERNEL at wakeup.

Host is in ST mode and sibling thread got a wakeup event (door bell) to execute
a new vcpu by calling kvm_start_guest, what will HSTATE_HWTHREAD_STATE be?

Just to clarify, what will the flags looks like for

(a) Host cpu sibling thread is offline and need to execute guest
(b) Host cpu sibling thread is idle and need to execute guest

--Vaidy
