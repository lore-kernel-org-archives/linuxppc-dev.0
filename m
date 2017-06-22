Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtnj503NMzDr1L
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 02:53:44 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5MGmkc3097751
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 12:53:42 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b8ddkxh09-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 12:53:42 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 23 Jun 2017 02:53:38 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5MGrRfg3670412
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 02:53:35 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5MGr2Me016180
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 02:53:03 +1000
Date: Thu, 22 Jun 2017 22:22:44 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 6/6] powerpc/64s: Blacklist rtas entry/exit from kprobes
References: <cover.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <482db382b611b0a97bb1d897b3b38cc083e10965.1498069502.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170622134858.63031e22@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170622134858.63031e22@roar.ozlabs.ibm.com>
Message-Id: <20170622165244.l3i5fd5v6kpjuwlx@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/22 01:48PM, Nicholas Piggin wrote:
> On Thu, 22 Jun 2017 00:08:42 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > We can't take traps with relocation off, so blacklist enter_rtas() and
> > rtas_return_loc(). However, instead of blacklisting all of enter_rtas(),
> > introduce a new symbol __enter_rtas from where on we can't take a trap
> > and blacklist that.
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/kernel/entry_64.S | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > index d376f07153d7..49c35450f399 100644
> > --- a/arch/powerpc/kernel/entry_64.S
> > +++ b/arch/powerpc/kernel/entry_64.S
> > @@ -1076,6 +1076,8 @@ _GLOBAL(enter_rtas)
> >          rldicr  r9,r9,MSR_SF_LG,(63-MSR_SF_LG)
> >  	ori	r9,r9,MSR_IR|MSR_DR|MSR_FE0|MSR_FE1|MSR_FP|MSR_RI|MSR_LE
> >  	andc	r6,r0,r9
> > +
> > +__enter_rtas:
> >  	sync				/* disable interrupts so SRR0/1 */
> >  	mtmsrd	r0			/* don't get trashed */
> 
> Along the lines of the system call patch... For consistency, could we
> put the __enter_rtas right after mtmsrd? And I wonder if we shoul

Sure.

> come up with a common prefix or postfix naming convention for these
> such labels used to control probing?

We could, but I am not sure it will help much. On the other hand, such 
symbols may make backtraces pretty distracting.

I'm just using '__' as a prefix to make it less distracting, though it 
isn't all that great either. I'm clearly hopeless with names o_O

The other option is to just blacklist entire functions, but we will then 
lose the ability to probe in many places where we may have wanted to.

> 
> How do opal calls avoid tracing?

It doesn't yet. I'm still going through the initial few symbols and 
identifying what needs blacklisting. Opal is further down.

Thanks,
Naveen
