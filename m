Return-Path: <srs0=rgjk=jd=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 417tKN0b0YzF09q
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 22:08:08 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 417tKM6kCXz8t2L
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jun 2018 22:08:07 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 417tKM0p12z9s3C
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2018 22:08:06 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a63-v6so6871536pfl.1
 for <linuxppc-dev@ozlabs.org>; Sun, 17 Jun 2018 05:08:06 -0700 (PDT)
Date: Sun, 17 Jun 2018 22:07:57 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/64s: Report SLB multi-hit rather than parity error
Message-ID: <20180617220757.3bafd4c2@roar.ozlabs.ibm.com>
In-Reply-To: <87muvw9t78.fsf@concordia.ellerman.id.au>
References: <20180613132414.32207-1-mpe@ellerman.id.au>
 <20180614004036.7c71cf1b@roar.ozlabs.ibm.com>
 <87muvw9t78.fsf@concordia.ellerman.id.au>
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

On Fri, 15 Jun 2018 21:37:15 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> > On Wed, 13 Jun 2018 23:24:14 +1000
> > Michael Ellerman <mpe@ellerman.id.au> wrote:
> >  
> >> When we take an SLB multi-hit on bare metal, we see both the multi-hit
> >> and parity error bits set in DSISR. The user manuals indicates this is
> >> expected to always happen on Power8, whereas on Power9 it says a
> >> multi-hit will "usually" also cause a parity error.
> >> 
> >> We decide what to do based on the various error tables in mce_power.c,
> >> and because we process them in order and only report the first, we
> >> currently always report a parity error but not the multi-hit, eg:
> >> 
> >>   Severe Machine check interrupt [Recovered]
> >>     Initiator: CPU
> >>     Error type: SLB [Parity]
> >>       Effective address: c000000ffffd4300
> >> 
> >> Although this is correct, it leaves the user wondering why they got a
> >> parity error. It would be clearer instead if we reported the
> >> multi-hit because that is more likely to be simply a software bug,
> >> whereas a true parity error is possibly an indication of a bad core.
> >> 
> >> We can do that simply by reordering the error tables so that multi-hit
> >> appears before parity. That doesn't affect the error recovery at all,
> >> because we flush the SLB either way.  
> >
> > Yeah this is a good idea. I wonder if there are any other conditions
> > like this that should be reordered.  
> 
> Yeah good point, this one just caught my eye because I was testing it.
> Ideally it wouldn't matter and we could actually report multiple, but
> that would be a bit of a bigger change.

Yep this patch looks fine for a minimal fix.

> 
> > I think the i-side should not have to be changed here because it
> > matches the value not bits, so that shouldn't matter.  
> 
> Ah OK, will check.
> 
> > A bit of a shame we don't report i/d side, and ideally we'd be able
> > to report multiple conditions. The reporting APIs really want to be
> > massaged a bit, but for now this is a good step.  
> 
> Ah snap, yep, more detail & multiple conditions would be nice.
> 
> I don't really understand the way we do the reporting now. The
> struct machine_check_event is all carefully laid out with reserved
> fields and a version number and everything as if it's an ABI. But AFAICS
> it's purely internal to the kernel.
> 
> And then we have struct mce_error_info, but that's a separate thing and
> struct machine_check_event doesn't contain one of them?

Yeah I noticed that too a while back, was it an old OPAL API or maybe a
proposed new API that was never implemented? I would like to end up
doing most MCE decoding in firmware at some point, but I don't think
it's worth keeping this existing ABI thing around for it.

Thanks,
Nick
