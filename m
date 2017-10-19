Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHg7s19cczDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 18:11:04 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9J7A0kZ119869
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 03:11:03 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dppfx2ubp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 03:11:02 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Thu, 19 Oct 2017 08:11:00 +0100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v9J7Au1D28966940
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 07:10:57 GMT
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v9J7An02026126
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 18:10:49 +1100
Subject: Re: [PATCH] powerpc/xmon: check before calling xive functions
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Date: Thu, 19 Oct 2017 09:10:46 +0200
In-Reply-To: <87vajchamw.fsf@concordia.ellerman.id.au>
References: <1508264418-13448-1-git-send-email-leitao@debian.org>
 <87vajchamw.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508397046.25065.313.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-10-19 at 00:02 +1100, Michael Ellerman wrote:
> Breno Leitao <leitao@debian.org> writes:
> 
> > Currently xmon could call XIVE functions from OPAL even if the XIVE is
> > disabled or does not exist in the system, as in POWER8 machines.  This
> > causes the following exception:
> > 
> >  1:mon> dx
> >  cpu 0x1: Vector: 700 (Program Check) at [c000000423c93450]
> >      pc: c00000000009cfa4: opal_xive_dump+0x50/0x68
> >      lr: c0000000000997b8: opal_return+0x0/0x50
> > 
> > This patch simply checks if XIVE is enabled before calling XIVE
> > functions.
> 
> Thanks. I'll merge this.
> 
> But we should also fix it in skiboot.

No that's wrong. xive_enabled() is only set if Linux is using native
xive mode but some of those xmon functions dump the emulated state.

We should fix the actual cause of the crash.

Cheers,
Ben.

> cheers
> 
> > Suggested-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  arch/powerpc/xmon/xmon.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> > index 4679aeb84767..b34976c4a6ba 100644
> > --- a/arch/powerpc/xmon/xmon.c
> > +++ b/arch/powerpc/xmon/xmon.c
> > @@ -2508,6 +2508,12 @@ static void dump_xives(void)
> >  	unsigned long num;
> >  	int c;
> >  
> > +	if (!xive_enabled()) {
> > +		printf("Xive disabled on this system\n");
> > +
> > +		return;
> > +	}
> > +
> >  	c = inchar();
> >  	if (c == 'a') {
> >  		dump_all_xives();
> > -- 
> > 2.14.2
