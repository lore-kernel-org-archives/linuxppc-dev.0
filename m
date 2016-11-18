Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKwgC1d5szDt0b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:26:31 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAIBOEUW083832
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:26:29 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26svyqtpwf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 06:26:29 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Fri, 18 Nov 2016 21:26:26 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C96162CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:26:23 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAIBQNgT21692642
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:26:23 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAIBQMfc025451
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 22:26:23 +1100
Date: Fri, 18 Nov 2016 16:56:04 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [RFC PATCH 4/4] powerpc: mm/slb: blacklist symbols from kprobe
References: <cover.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <a599d736aa7323a767fd62e1af33b99b235aed39.1479394571.git.naveen.n.rao@linux.vnet.ibm.com>
 <87shqpgmeh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87shqpgmeh.fsf@concordia.ellerman.id.au>
Message-Id: <20161118112604.GG4019@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/18 08:36PM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > We can't really take a trap at this point. So, blacklist these symbols.
> >
> > Reported-by: Anton Blanchard <anton@samba.org>
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > ---
> >  arch/powerpc/mm/slb_low.S | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
> > index c1c7456..c2bae92 100644
> > --- a/arch/powerpc/mm/slb_low.S
> > +++ b/arch/powerpc/mm/slb_low.S
> > @@ -30,7 +30,7 @@
> >   *	r9, r10, r11 are clobbered by this function
> >   * No other registers are examined or changed.
> >   */
> > -_GLOBAL(slb_allocate_realmode)
> > +_GLOBAL_NOKPROBE(slb_allocate_realmode)
> 
> I think I'd prefer we just leave these as is, and add somewhere nearby:
> 
> _ASM_NOKPROBE_SYMBOL(slb_allocate_realmode)
> 
> 
> It means someone reading the code doesn't need to worry about the
> nokprobe part, just to understand the function. It also means we need
> fewer macros :)

:)
Ok.

- Naveen
