Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsn514zRtzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 21:22:13 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2SAJM6L131325
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 06:22:08 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29fnea28rr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 06:22:08 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Mar 2017 20:22:05 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2SALsMs16711822
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 21:22:02 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2SALTrW026339
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 21:21:29 +1100
Date: Tue, 28 Mar 2017 15:51:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Matthew Wilcox <willy@infradead.org>, Paul Mackerras <paulus@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/2] powerpc: string: implement optimized memset variants
References: <20170322193030.GA8008@bombadil.infradead.org>
 <cover.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <d6a1a353de6a87bb5474ca9f1c1ff7ab2c4a1eb4.1490641759.git.naveen.n.rao@linux.vnet.ibm.com>
 <87mvc6b575.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87mvc6b575.fsf@concordia.ellerman.id.au>
Message-Id: <20170328102109.GC4762@naverao1-tp.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017/03/28 11:44AM, Michael Ellerman wrote:
> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > diff --git a/arch/powerpc/lib/mem_64.S b/arch/powerpc/lib/mem_64.S
> > index 85fa9869aec5..ec531de99996 100644
> > --- a/arch/powerpc/lib/mem_64.S
> > +++ b/arch/powerpc/lib/mem_64.S
> > @@ -13,6 +13,23 @@
> >  #include <asm/ppc_asm.h>
> >  #include <asm/export.h>
> >  
> > +_GLOBAL(__memset16)
> > +	rlwimi	r4,r4,16,0,15
> > +	/* fall through */
> > +
> > +_GLOBAL(__memset32)
> > +	rldimi	r4,r4,32,0
> > +	/* fall through */
> > +
> > +_GLOBAL(__memset64)
> > +	neg	r0,r3
> > +	andi.	r0,r0,7
> > +	cmplw	cr1,r5,r0
> > +	b	.Lms
> > +EXPORT_SYMBOL(__memset16)
> > +EXPORT_SYMBOL(__memset32)
> > +EXPORT_SYMBOL(__memset64)
> 
> You'll have to convince me that's better than what GCC produces.

Sure :) I got lazy yesterday night and didn't post the test results...

I hadn't tested zram yesterday, but only done tests with a naive test 
module that memset's a large 1GB buffer with integers. With that test, I 
saw:

without patch:       0.389253910 seconds time elapsed    ( +-  1.49% )
with patch:          0.173269267 seconds time elapsed    ( +-  1.55% )

.. which is better than 2x.

I also tested zram today with the command shared by Wilcox:

without patch:       1.493782568 seconds time elapsed    ( +-  0.08% )
with patch:          1.408457577 seconds time elapsed    ( +-  0.15% )

... which also shows an improvement along the same lines as x86, as 
reported by Minchan Kim.


- Naveen
