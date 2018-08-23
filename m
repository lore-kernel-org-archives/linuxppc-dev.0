Return-Path: <srs0=iwkb=lg=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ws7V5DcqzF2Py
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 14:36:38 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41ws7V4dRGz8wRV
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Aug 2018 14:36:38 +1000 (AEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41ws7V1Ll2z9s7X
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2018 14:36:38 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id z25-v6so1935663pgu.7
 for <linuxppc-dev@ozlabs.org>; Wed, 22 Aug 2018 21:36:37 -0700 (PDT)
Date: Thu, 23 Aug 2018 14:36:31 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Ellerman
 <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] poewrpc/mce: Fix SLB rebolting during MCE recovery path.
Message-ID: <20180823143631.37fcc582@roar.ozlabs.ibm.com>
In-Reply-To: <4dc90537-0fde-ab1a-8372-aba2d82ebd8c@linux.vnet.ibm.com>
References: <153449765953.21426.6928471250286444535.stgit@jupiter.in.ibm.com>
 <20180821202702.4198d426@roar.ozlabs.ibm.com>
 <4dc90537-0fde-ab1a-8372-aba2d82ebd8c@linux.vnet.ibm.com>
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

On Thu, 23 Aug 2018 09:58:31 +0530
Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:

> On 08/21/2018 03:57 PM, Nicholas Piggin wrote:
> > On Fri, 17 Aug 2018 14:51:47 +0530
> > Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> >   
> >> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >>
> >> With the powrpc next commit e7e81847478 (poewrpc/mce: Fix SLB rebolting
> >> during MCE recovery path.), the SLB error recovery is broken. The
> >> commit missed a crucial change of OR-ing index value to RB[52-63] which
> >> selects the SLB entry while rebolting. This patch fixes that.
> >>
> >> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> >> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> >> ---
> >>  arch/powerpc/mm/slb.c |    5 ++++-
> >>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> >> index 0b095fa54049..6dd9913425bc 100644
> >> --- a/arch/powerpc/mm/slb.c
> >> +++ b/arch/powerpc/mm/slb.c
> >> @@ -101,9 +101,12 @@ void __slb_restore_bolted_realmode(void)
> >>  
> >>  	 /* No isync needed because realmode. */
> >>  	for (index = 0; index < SLB_NUM_BOLTED; index++) {
> >> +		unsigned long rb = be64_to_cpu(p->save_area[index].esid);
> >> +
> >> +		rb = (rb & ~0xFFFul) | index;
> >>  		asm volatile("slbmte  %0,%1" :
> >>  		     : "r" (be64_to_cpu(p->save_area[index].vsid)),
> >> -		       "r" (be64_to_cpu(p->save_area[index].esid)));
> >> +		       "r" (rb));
> >>  	}
> >>  }
> >>  
> >>  
> > 
> > I'm just looking at this again. The bolted save areas do have the
> > index field set. So for the OS, your patch should be equivalent to
> > this, right?
> > 
> >  static inline void slb_shadow_clear(enum slb_index index)
> >  {
> > -       WRITE_ONCE(get_slb_shadow()->save_area[index].esid, 0);
> > +       WRITE_ONCE(get_slb_shadow()->save_area[index].esid, index);
> >  }
> > 
> > Which seems like a better fix.  
> 
> Yeah this also fixes the issue. The only additional change required is
> cpu_to_be64(index).

Ah yep.

> As long as we maintain index in bolted save areas
> (for valid/invalid entries) we should be ok. Will respin v2 with this
> change.

Cool, Reviewed-by: Nicholas Piggin <npiggin@gmail.com> in that case :)

Thanks,
Nick
