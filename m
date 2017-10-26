Return-Path: <srs0=i7yv=bz=au1.ibm.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMwKy5G2QzDqln
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 16:19:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3yMwKy4bMHz8t1T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2017 16:19:34 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3yMwKx6KrLz9sPm
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2017 16:19:33 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9Q5IowY032020
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2017 01:19:31 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2du8b9trde-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2017 01:19:31 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <npiggin@au1.ibm.com>;
 Thu, 26 Oct 2017 06:19:29 +0100
Date: Thu, 26 Oct 2017 15:19:20 +1000
From: Nicholas Piggin <npiggin@au1.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: Michael Ellerman <michael@ellerman.id.au>, linuxppc-dev@ozlabs.org,
 Markus Trippelsdorf <markus@trippelsdorf.de>
Subject: Re: [PATCH] powerpc: Fix check for copy/paste instructions in
 alignment handler
In-Reply-To: <OFE75272CA.7B26179F-ON002581C4.007CAB23@notes.na.collabserv.com>
References: <OFF18C8ACF.135B0A8D-ON002581C4.002803F5@notes.na.collabserv.com>
 <20171026012237.0320e540@roar.ozlabs.ibm.com>
 <OFE75272CA.7B26179F-ON002581C4.007CAB23@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20171026151920.748762d8@roar.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 Oct 2017 09:41:32 +1100
Paul Mackerras <paulus@ozlabs.org> wrote:

> On Thu, Oct 26, 2017 at 01:22:37AM +1000, Nicholas Piggin wrote:
> > On Wed, 25 Oct 2017 18:16:53 +1100
> > Paul Mackerras <paulus@ozlabs.org> wrote:
> >   
> > > Commit 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
> > > when possible", 2017-06-09) changed the definition of PPC_INST_COPY
> > > and in so doing inadvertently broke the check for copy/paste
> > > instructions in the alignment fault handler.  The check currently
> > > matches no instructions.
> > > 
> > > This fixes it by ANDing both sides of the comparison with the mask.  
> > 
> > Thanks for fixing it. Any reason not to change the mask to 0xfc2006fe
> > to include the 'last' bit that is now mandatory?  
> 
> What does real hardware do if you execute the instruction without that
> bit set?  Does it take the alignment interrupt, or does it take an
> illegal instruction interrupt (i.e. HEAI)?  We need to catch all the
> variants that take an alignment interrupt.  If P9 hardware takes a
> HEAI when that bit isn't set, then I'm fine with changing the mask.

Just tested. Copy without the bit results in an illegal instruction.
Even the valid paste variant causes a sigill because it's set to use
HEA to avoid the thread reconfig problem.

Thanks,
Nick
