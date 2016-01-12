Return-Path: <munroesj@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 97D131A0D9B
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 03:39:24 +1100 (AEDT)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <munroesj@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 11:39:21 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 08E0F38C8041
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 11:39:20 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0CGdJ1f30736614
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 16:39:19 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0CGdJfP012492
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 11:39:19 -0500
Subject: Re: [PATCH] Add hwcap2 bits for POWER9
From: Steven Munroe <munroesj@linux.vnet.ibm.com>
Reply-To: munroesj@linux.vnet.ibm.com
To: "Carlos O'Donell" <carlos@redhat.com>
Cc: Tulio Magno Quites Machado Filho <tuliom@linux.vnet.ibm.com>,
 Adhemerval Zanella <adhemerval.zanella@linaro.org>,
 libc-alpha@sourceware.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <56941532.9030800@redhat.com>
References: <568C272D.6000705@linux.vnet.ibm.com>
 <87egdsi4om.fsf@totoro.br.ibm.com> <1452267366.5201.12.camel@vnet.ibm.com>
 <568FE3D0.7080008@linaro.org> <87wprgdu3u.fsf@totoro.br.ibm.com>
 <5693C861.9030308@redhat.com> <87bn8revra.fsf@totoro.br.ibm.com>
 <56941532.9030800@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Jan 2016 10:39:17 -0600
Message-ID: <1452616757.29488.10.camel@oc7878010663>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-01-11 at 15:48 -0500, Carlos O'Donell wrote:
> On 01/11/2016 02:55 PM, Tulio Magno Quites Machado Filho wrote:
> > "Carlos O'Donell" <carlos@redhat.com> writes:
> > 
> >> On 01/11/2016 10:16 AM, Tulio Magno Quites Machado Filho wrote:
> >>> Adhemerval Zanella <adhemerval.zanella@linaro.org> writes:
> >>>
> >>>> On 08-01-2016 13:36, Peter Bergner wrote:
> >>>>> On Fri, 2016-01-08 at 11:25 -0200, Tulio Magno Quites Machado Filho wrote:
> >>>>>> Peter, this solves the issue you reported previously [1].
> >>>>>>
> >>>>>> [1] https://sourceware.org/ml/libc-alpha/2015-12/msg00522.html
> >>>>>
> >>>>> Agreed, thanks.  I'll also add the POWER9 support to the GCC side
> >>>>> of the patch now that the glibc code is upstream.
> >>>>
> >>>> I do not see these bits being added in kernel side yet and GLIBC usual
> >>>> only sync these kind of bits *after* they are included in kernel side.
> >>>> So I would advise to either get these pieces (kernel support and hwcap
> >>>> advertise) in kernel before 2.23 release, otherwise revert the patches.
> >>>
> >>> Ack.
> >>> It has just been sent to the correspondent Linux mailing list:
> >>> https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-January/137763.html
> >>
> >> Please revert the changes from glibc until you checkin support to linux
> >> kernel mainline.
> >>
> >> Leaving these bits in increases the risk that someone uses to deploy a glibc
> >> that then may have the wrong value.
> > 
> > Could you clarify this statement, please?
> > I fail to see how they could have the wrong value.
> 
> Until it is checked into the mainline kernel it is not canonical.
> 
> That's the rule. There are no other discussions to be had.
> 
Well is was posted to to powerpc next:
https://git.kernel.org/powerpc/c/e708c24cd01ce80b1609d8bacc

We have agreement between the kernel and GLIBC (and the ABI). 

The issue is just coordination across communities and individuals that
may not being paying attention to other communities dead lines.

Have you ever tried to push a string, up hill. That is open source
development in nutshell. ;)

So it is in flight and glibc is soft/slush freeze. I would hate to
revert this one day just to add it back to the next. Especially if those
days straddle the hard freeze ...

So can we let this ride a day or too?

> The single rule avoids discussions like "it can never be wrong because that's
> what our ABI says it is."
> 
