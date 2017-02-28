Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vXXDb27NDzDqGy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 19:43:59 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id y23so716204pfk.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 00:43:59 -0800 (PST)
Date: Tue, 28 Feb 2017 18:43:34 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] powerpc/64s: fix handling of non-synchronous
 machine checks
Message-ID: <20170228184334.717ca813@roar.ozlabs.ibm.com>
In-Reply-To: <15d128c9-f574-0104-d47e-37e2dced8d8f@linux.vnet.ibm.com>
References: <20170228020048.8862-1-npiggin@gmail.com>
 <20170228020048.8862-2-npiggin@gmail.com>
 <15d128c9-f574-0104-d47e-37e2dced8d8f@linux.vnet.ibm.com>
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

On Tue, 28 Feb 2017 11:27:29 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 02/28/2017 07:30 AM, Nicholas Piggin wrote:
> > A synchronous machine check is an exception raised by the attempt to
> > execute the current instruction. If the error can't be corrected, it
> > can make sense to SIGBUS the currently running process.
> > 
> > In other cases, the error condition is not related to the current
> > instruction, so killing the current process is not the right thing to
> > do.
> > 
> > Today, all machine checks are MCE_SEV_ERROR_SYNC, so this has no
> > practical change. It will be used to handle POWER9 asynchronous
> > machine checks.
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/platforms/powernv/opal.c | 21 ++++++---------------
> >  1 file changed, 6 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> > index 86d9fde93c17..e0f856bfbfe8 100644
> > --- a/arch/powerpc/platforms/powernv/opal.c
> > +++ b/arch/powerpc/platforms/powernv/opal.c
> > @@ -395,7 +395,6 @@ static int opal_recover_mce(struct pt_regs *regs,
> >  					struct machine_check_event *evt)
> >  {
> >  	int recovered = 0;
> > -	uint64_t ea = get_mce_fault_addr(evt);
> > 
> >  	if (!(regs->msr & MSR_RI)) {
> >  		/* If MSR_RI isn't set, we cannot recover */
> > @@ -404,26 +403,18 @@ static int opal_recover_mce(struct pt_regs *regs,
> >  	} else if (evt->disposition == MCE_DISPOSITION_RECOVERED) {
> >  		/* Platform corrected itself */
> >  		recovered = 1;
> > -	} else if (ea && !is_kernel_addr(ea)) {
> > +	} else if (evt->severity == MCE_SEV_FATAL) {
> > +		/* Fatal machine check */
> > +		pr_err("Machine check interrupt is fatal\n");
> > +		recovered = 0;  
> 
> Setting recovered = 0 would trigger kernel panic. Should we panic the
> kernel for asynchronous errors ?

If it's not recoverable, I don't see what other option we have. SRR0 is
meaningless for async machine checks. So it's much the same thing we do
as if we don't have a process to kill or were running in kernel when a
synchronous MCE occurred.

Thanks,
Nick
