Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8hCz0hyMzDvRH
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 21:34:22 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA3AXbFU061921
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 06:34:20 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26fyqn0698-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 Nov 2016 06:34:20 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 3 Nov 2016 16:04:17 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 0DA1EE0062
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 16:04:15 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA3AXpqA9371810
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 16:03:51 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA3AYDZZ019536
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Nov 2016 16:04:14 +0530
Date: Thu, 3 Nov 2016 16:04:13 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Denis Kirjanov <kda@linux-powerpc.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: compiling master.
References: <20161103155531.4e86d906@roar.ozlabs.ibm.com>
 <20161103065317.8537-1-naveen.n.rao@linux.vnet.ibm.com>
 <20161103180921.5506327e@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161103180921.5506327e@roar.ozlabs.ibm.com>
Message-Id: <20161103103413.GK6949@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016/11/03 06:09PM, Nicholas Piggin wrote:
> On Thu,  3 Nov 2016 12:23:17 +0530
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > diff --git a/arch/powerpc/include/asm/exception-64s.h 
> > b/arch/powerpc/include/asm/exception-64s.h
> > index 2e4e7d8..9b7b302 100644
> > --- a/arch/powerpc/include/asm/exception-64s.h
> > +++ b/arch/powerpc/include/asm/exception-64s.h
> > @@ -91,7 +91,7 @@
> >   */
> >  #define LOAD_HANDLER(reg, label)					\
> >  	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
> > -	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
> > +	ori	reg,reg,((FIXED_SYMBOL_ABS_ADDR(label)) & 0xffff);
> >  
> >  /* Exception register prefixes */
> >  #define EXC_HV	H
> 
> Thanks for taking a look. Does this patch fix it, or just hide the build
> error? This would presumably hide real bugs too, so it will be good if we
> can make it conditional on older assemblers, or otherwise do a test for
> out of bounds value (you could try asm directives like .if/.error)

It does seem to fix it for me - the built kernel booted fine ;)

My assembly skills are a bit lacking, but is there a specific reason you 
think that AND'ing with 0xffff is different from using @l?

Thanks,
Naveen
