Return-Path: <simonguo@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsWsx0CtBzDqNB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 13:25:57 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rsWsw3Wgmz9sdn
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Jul 2016 13:25:54 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6H3OCdl136566
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Jul 2016 23:25:50 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 247h3jsena-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sat, 16 Jul 2016 23:25:50 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <simonguo@linux.vnet.ibm.com>;
 Sat, 16 Jul 2016 21:25:49 -0600
Date: Sun, 17 Jul 2016 11:25:43 +0800
From: Simon Guo <simonguo@linux.vnet.ibm.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: Re: [PATCH 3/5] powerpc: tm: Always use fp_state and vr_state to
 store live registers
References: <20160608040036.13064-1-cyrilbur@gmail.com>
 <20160608040036.13064-4-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160608040036.13064-4-cyrilbur@gmail.com>
Message-Id: <20160717032543.GB3843@simonLocalRHEL7.x64>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Cyril,
On Wed, Jun 08, 2016 at 02:00:34PM +1000, Cyril Bur wrote:
> @@ -917,24 +907,10 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
>  		 "(new->msr 0x%lx, new->origmsr 0x%lx)\n",
>  		 new->pid, new->thread.regs->msr, msr);
>  
> -	/* This loads the checkpointed FP/VEC state, if used */
>  	tm_recheckpoint(&new->thread, msr);
>  
> -	/* This loads the speculative FP/VEC state, if used */
> -	if (msr & MSR_FP) {
> -		do_load_up_transact_fpu(&new->thread);
> -		new->thread.regs->msr |=
> -			(MSR_FP | new->thread.fpexc_mode);
> -	}
> -#ifdef CONFIG_ALTIVEC
> -	if (msr & MSR_VEC) {
> -		do_load_up_transact_altivec(&new->thread);
> -		new->thread.regs->msr |= MSR_VEC;
> -	}
> -#endif
> -	/* We may as well turn on VSX too since all the state is restored now */
> -	if (msr & MSR_VSX)
> -		new->thread.regs->msr |= MSR_VSX;
> +	/* Won't restore math get called later? */
> +	restore_math(new->thread.regs);

I have some question for the "restore_math" in tm_recheckpoint_new_task().

Per my understanding, now after tm_recheckpoint, the fp_state content
is obsolete.  However restore_math() will try to restore FP/Vec/VSX state 
from fp_state, (orginally it is right, since fp_state was the valid
checkpointed state and consistent with FP register ). Should we remove
the restore_math() here?

And, should the thread's MSR now set FP bit in tm_recheckpoint(), to 
indicate that FP register content is "fresh" in contrast to thread.fp_state?

Please correct me if I am wrong.

Thanks,
- Simon
