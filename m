Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpSDl44bFzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 01:32:39 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5FFSwrC007578
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 11:32:37 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b3vrwgjnf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 11:32:36 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 16 Jun 2017 01:32:34 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5FFWVgR64487450
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 01:32:31 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5FFWNCV007187
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 01:32:23 +1000
Date: Thu, 15 Jun 2017 21:02:29 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/4] powerpc/kprobes_on_ftrace: Skip
 livepatch_handler() for jprobes
References: <cover.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
 <354168131ffd13a9109172f616255fe1e0983387.1496309487.git.naveen.n.rao@linux.vnet.ibm.com>
 <87y3sto5w8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87y3sto5w8.fsf@concordia.ellerman.id.au>
Message-Id: <20170615153229.GB2800@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/15 09:19PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > diff --git a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> > index fa0921410fa4..e6837e85ec28 100644
> > --- a/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> > +++ b/arch/powerpc/kernel/trace/ftrace_64_mprofile.S
> > @@ -99,13 +99,37 @@ ftrace_call:
> >  	bl	ftrace_stub
> >  	nop
> >  
> > -	/* Load ctr with the possibly modified NIP */
> > -	ld	r3, _NIP(r1)
> > -	mtctr	r3
> > +	/* Load the possibly modified NIP */
> > +	ld	r15, _NIP(r1)
> > +
> >  #ifdef CONFIG_LIVEPATCH
> > -	cmpd	r14,r3		/* has NIP been altered? */
> > +	cmpd	r14, r15		/* has NIP been altered? */
> > +#endif
> > +
> > +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_KPROBES_ON_FTRACE)
> > +	beq	1f
> > +
> > +	/* Check if there is an active kprobe on us */
> > +	subi	r3, r14, 4
> > +	bl	is_current_kprobe_addr
> > +	nop
> > +
> > +	/*
> > +	 * If r3 == 1, then this is a kprobe/jprobe.
> > +	 * else, this is livepatched function.
> > +	 *
> > +	 * The subsequent conditional branch for livepatch_handler
> > +	 * will use the result of this compare. For kprobe/jprobe,
> > +	 * we just need to branch to the new NIP, so nothing special
> > +	 * is needed.
> > +	 */
> > +	cmpdi	r3, 1
> > +1:
> >  #endif
> 
> I added some more comments. Hopefully I got them right :D
> 
>  #if defined(CONFIG_LIVEPATCH) && defined(CONFIG_KPROBES_ON_FTRACE)
> +       /* NIP has not been altered, skip over further checks */
>         beq     1f
> 
>         /* Check if there is an active kprobe on us */
> @@ -118,10 +119,11 @@ ftrace_call:
>          * If r3 == 1, then this is a kprobe/jprobe.
>          * else, this is livepatched function.
>          *
> -        * The subsequent conditional branch for livepatch_handler
> -        * will use the result of this compare. For kprobe/jprobe,
> -        * we just need to branch to the new NIP, so nothing special
> -        * is needed.
> +        * The conditional branch for livepatch_handler below will use the
> +        * result of this comparison. For kprobe/jprobe, we just need to branch to
> +        * the new NIP, not call livepatch_handler. The branch below is bne, so we
> +        * want CR0[EQ] to be true if this is a kprobe/jprobe. Which means we want
> +        * CR0[EQ] = (r3 == 1).
>          */
>         cmpdi   r3, 1
>  1:
> @@ -147,7 +149,10 @@ ftrace_call:
>         addi r1, r1, SWITCH_FRAME_SIZE
> 
>  #ifdef CONFIG_LIVEPATCH
> -        /* Based on the cmpd above, if the NIP was altered handle livepatch */
> +        /*
> +        * Based on the cmpd or cmpdi above, if the NIP was altered and we're
> +        * not on a kprobe/jprobe, then handle livepatch.
> +        */
>         bne-    livepatch_handler
>  #endif

Oh yes, this makes the code logic a whole lot more clearer and explicit.  
Thanks for expanding on it!

- Naveen
