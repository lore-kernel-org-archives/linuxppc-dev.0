Return-Path: <simonguo@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rfbKG51PYzDqvm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 18:23:14 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rfbKG1D56z9t0j
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 18:23:13 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5T8F42B096482
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 04:23:11 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23uwt78ku4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 04:23:11 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <simonguo@linux.vnet.ibm.com>;
 Wed, 29 Jun 2016 04:23:10 -0400
Date: Tue, 28 Jun 2016 11:53:13 +0800
From: Simon Guo <simonguo@linux.vnet.ibm.com>
To: Cyril Bur <cyrilbur@gmail.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/5] powerpc: tm: Always use fp_state and vr_state to
 store live registers
References: <20160608040036.13064-1-cyrilbur@gmail.com>
 <20160608040036.13064-4-cyrilbur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160608040036.13064-4-cyrilbur@gmail.com>
Message-Id: <20160628035313.GB15160@simonLocalRHEL7.x64>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi Cyril,

On Wed, Jun 08, 2016 at 02:00:34PM +1000, Cyril Bur wrote:
> @@ -1108,11 +1084,11 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	 */
>  	save_sprs(&prev->thread);
>  
> -	__switch_to_tm(prev);
> -
>  	/* Save FPU, Altivec, VSX and SPE state */
>  	giveup_all(prev);
>  
> +	__switch_to_tm(prev);
> +

There should be a bug.
giveup_all() will clear MSR[FP] bit. 
__switch_to_tm() reads that bit to decide whether the FP 
register needs to be flushed to thread_struct.
=== tm_reclaim() (invoked by __switch_to_tm)========================
        andi.   r0, r4, MSR_FP
        beq     dont_backup_fp

        addi    r7, r3, THREAD_CKFPSTATE
        SAVE_32FPRS_VSRS(0, R6, R7)     /* r6 scratch, r7 transact fp
state */

        mffs    fr0
        stfd    fr0,FPSTATE_FPSCR(r7)

dont_backup_fp:
=============================

But now the __switch_to_tm() is moved behind giveup_all().
So __switch_to_tm() loses MSR[FP] and cannot decide whether saving ckpt FPU or not.

The same applies to VMX/VSX.

Thanks,
- Simon
