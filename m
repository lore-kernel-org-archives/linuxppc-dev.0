Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wz5l56bN2zDr50
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 03:10:25 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5TH8x7J022727
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 13:10:23 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bd4m33210-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Jun 2017 13:10:23 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 30 Jun 2017 03:10:20 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5THAHoY6554044
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 03:10:17 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5THAGjx006071
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Jun 2017 03:10:17 +1000
Date: Thu, 29 Jun 2017 22:21:46 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 7/7] powerpc/64s: Blacklist rtas entry/exit from kprobes
References: <cover.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
 <39d40efd808c6346b97e5bfe4be47546919cb91b.1498732172.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170629210130.242bd2c3@roar.ozlabs.ibm.com>
 <20170629115414.7avzpd57ficdq3me@naverao1-tp.localdomain>
 <20170629221311.1c1c1dd6@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629221311.1c1c1dd6@roar.ozlabs.ibm.com>
Message-Id: <20170629165146.doyobss2pi4mxdlt@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/06/29 10:13PM, Nicholas Piggin wrote:
> On Thu, 29 Jun 2017 17:24:14 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> 
> > On 2017/06/29 09:01PM, Nicholas Piggin wrote:
> > > On Thu, 29 Jun 2017 16:11:10 +0530
> > > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > >   
> > > > We can't take traps with relocation off, so blacklist enter_rtas() and
> > > > rtas_return_loc(). However, instead of blacklisting all of enter_rtas(),
> > > > introduce a new symbol __enter_rtas from where on we can't take a trap
> > > > and blacklist that.
> > > > 
> > > > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > > > ---
> > > >  arch/powerpc/kernel/entry_64.S | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> > > > index 0c27084800b6..16f4c4a1a294 100644
> > > > --- a/arch/powerpc/kernel/entry_64.S
> > > > +++ b/arch/powerpc/kernel/entry_64.S
> > > > @@ -1082,6 +1082,7 @@ _GLOBAL(enter_rtas)
> > > >  	sync				/* disable interrupts so SRR0/1 */
> > > >  	mtmsrd	r0			/* don't get trashed */
> > > >  
> > > > +__enter_rtas:  
> > > 
> > > Hmm, am I missing something, or is there a reason to put these labels
> > > after the mtmsr? Even if kprobes does the right thing, I think it's
> > > easier to read the code if you cover the mtmsr as well.  
> > 
> > I thought you asked for this, per your previous review comment:
> > https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg119667.html
> > 
> > Or, did I get that wrong?
> 
> No you're right, I'm contradicting myself. Let me start again.
> 
> I think we'd like to put the label before the mtmsrd if possible. So
> in that case, should we adjust the system call code instead (then you
> wouldn't have to add a comment for it).
> 
> And then you could move this label back above the mtmsrd. Sorry for
> the confusion.

Sure - I now get why you were insisting on a comment with the 
system_call_exit symbol. v5 enroute...

Thanks,
Naveen
