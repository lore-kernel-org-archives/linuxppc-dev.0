Return-Path: <cyrilbur@gmail.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg2806760zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 11:31:44 +1000 (AEST)
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rg28022KPz9sD5
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Jun 2016 11:31:43 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id av7so5754298pac.3
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2016 18:31:43 -0700 (PDT)
Date: Thu, 30 Jun 2016 11:31:33 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: Simon Guo <simonguo@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org, mikey@neuling.org, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/5] powerpc: tm: Always use fp_state and vr_state to
 store live registers
Message-ID: <20160630113133.09444a5c@camb691>
In-Reply-To: <20160628035313.GB15160@simonLocalRHEL7.x64>
References: <20160608040036.13064-1-cyrilbur@gmail.com>
 <20160608040036.13064-4-cyrilbur@gmail.com>
 <20160628035313.GB15160@simonLocalRHEL7.x64>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 28 Jun 2016 11:53:13 +0800
Simon Guo <simonguo@linux.vnet.ibm.com> wrote:

> hi Cyril,
> 
> On Wed, Jun 08, 2016 at 02:00:34PM +1000, Cyril Bur wrote:
> > @@ -1108,11 +1084,11 @@ struct task_struct *__switch_to(struct task_struct *prev,
> >  	 */
> >  	save_sprs(&prev->thread);
> >  
> > -	__switch_to_tm(prev);
> > -
> >  	/* Save FPU, Altivec, VSX and SPE state */
> >  	giveup_all(prev);
> >  
> > +	__switch_to_tm(prev);
> > +  
> 

Hi Simon,

> There should be a bug.
> giveup_all() will clear MSR[FP] bit. 
> __switch_to_tm() reads that bit to decide whether the FP 
> register needs to be flushed to thread_struct.
> === tm_reclaim() (invoked by __switch_to_tm)========================
>         andi.   r0, r4, MSR_FP
>         beq     dont_backup_fp
> 
>         addi    r7, r3, THREAD_CKFPSTATE
>         SAVE_32FPRS_VSRS(0, R6, R7)     /* r6 scratch, r7 transact fp
> state */
> 
>         mffs    fr0
>         stfd    fr0,FPSTATE_FPSCR(r7)
> 
> dont_backup_fp:
> =============================
> 
> But now the __switch_to_tm() is moved behind giveup_all().
> So __switch_to_tm() loses MSR[FP] and cannot decide whether saving ckpt FPU or not.
> 

Good catch! Yes it looks that way indeed. I thought I had a test to catch this
because this is the big risk here but upon reflection it looks like I don't
(mostly because it seems a condition to catch that is hard to craft).

I'll add a test and a fix.

Thanks.

Cyril

> The same applies to VMX/VSX.

Yeah.

> 
> Thanks,
> - Simon
> 
