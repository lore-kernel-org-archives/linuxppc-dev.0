Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wryRt69y0zDq7c
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 03:20:58 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id d5so18259613pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 10:20:58 -0700 (PDT)
Date: Tue, 20 Jun 2017 03:20:43 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/9] powerpc/64s: SLB miss already has CTR saved for
 relocatable kernel
Message-ID: <20170620032043.13bbd2fa@roar.ozlabs.ibm.com>
In-Reply-To: <877f08urp9.fsf@concordia.ellerman.id.au>
References: <20170521131550.25813-1-npiggin@gmail.com>
 <20170521131550.25813-4-npiggin@gmail.com>
 <877f08urp9.fsf@concordia.ellerman.id.au>
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

On Mon, 19 Jun 2017 21:45:06 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > The EXCEPTION_PROLOG_1 used by SLB miss already saves CTR when the
> > kernel is built with CONFIG_RELOCATABLE. So it does not have to be
> > saved and reloaded when branching to slb_miss_realmode. It can be
> > restored from the PACA as usual.
> >
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  arch/powerpc/kernel/exceptions-64s.S | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> > index a4a71bce35d6..486e205cc762 100644
> > --- a/arch/powerpc/kernel/exceptions-64s.S
> > +++ b/arch/powerpc/kernel/exceptions-64s.S
> > @@ -519,7 +519,7 @@ EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
> >  	 * because the distance from here to there depends on where
> >  	 * the kernel ends up being put.
> >  	 */
> > -	mfctr	r11
> > +	/* CTR is saved if RELOCATABLE */
> >  	LOAD_HANDLER(r10, slb_miss_realmode)
> >  	mtctr	r10
> >  	bctr  
> 
> AFAICS these can all use BRANCH_TO_COMMON().
> 
> So I'll drop all the comment additions from this and do a follow-up to
> switch to BRANCH_TO_COMMON().

That will tidy up those ifdefs nicely. Good catch.

Thanks,
Nick
