Return-Path: <srs0=cb3y=kz=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41mxdc2dsVzDqww
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 17:31:48 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 41mxdc1xW1z8vRv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 17:31:48 +1000 (AEST)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 41mxdb5Cnkz9s4Z
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 17:31:47 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id a11-v6so3994486pgw.6
 for <linuxppc-dev@ozlabs.org>; Fri, 10 Aug 2018 00:31:47 -0700 (PDT)
Date: Fri, 10 Aug 2018 17:31:37 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.ibm.com>, Michal Suchanek <msuchanek@suse.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev
 <linuxppc-dev@ozlabs.org>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Laurent Dufour
 <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 8/9] powerpc/mce: Add sysctl control for recovery
 action on MCE.
Message-ID: <20180810173137.3a382a52@roar.ozlabs.ibm.com>
In-Reply-To: <20180809122646.2f1a827d@naga.suse.cz>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365146712.14256.11869543914717297278.stgit@jupiter.in.ibm.com>
 <87o9ecaovz.fsf@concordia.ellerman.id.au>
 <d08a7794-e5c2-2b05-c21a-ae5a7baa7d88@linux.ibm.com>
 <87d0us9hgg.fsf@concordia.ellerman.id.au>
 <20180809180253.5665ddf5@roar.ozlabs.ibm.com>
 <20180809080945.5wgxevm5oq7otbpe@in.ibm.com>
 <20180809183333.6097d5ec@roar.ozlabs.ibm.com>
 <20180809122646.2f1a827d@naga.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 9 Aug 2018 12:26:46 +0200
Michal Such=C3=A1nek <msuchanek@suse.de> wrote:

> On Thu, 9 Aug 2018 18:33:33 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
>=20
> > On Thu, 9 Aug 2018 13:39:45 +0530
> > Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com> wrote:
> >  =20
> > > On Thu, Aug 09, 2018 at 06:02:53PM +1000, Nicholas Piggin wrote:   =20
> > > > On Thu, 09 Aug 2018 16:34:07 +1000
> > > > Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > >      =20
> > > > > "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:     =20
> > > > > > On 08/08/2018 08:26 PM, Michael Ellerman wrote:       =20
> > > > > >> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:       =
=20
> > > > > >>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> > > > > >>>
> > > > > >>> Introduce recovery action for recovered memory errors
> > > > > >>> (MCEs). There are soft memory errors like SLB Multihit,
> > > > > >>> which can be a result of a bad hardware OR software BUG.
> > > > > >>> Kernel can easily recover from these soft errors by
> > > > > >>> flushing SLB contents. After the recovery kernel can still
> > > > > >>> continue to function without any issue. But in some
> > > > > >>> scenario's we may keep getting these soft errors until the
> > > > > >>> root cause is fixed. To be able to analyze and find the
> > > > > >>> root cause, best way is to gather enough data and system
> > > > > >>> state at the time of MCE. Hence this patch introduces a
> > > > > >>> sysctl knob where user can decide either to continue after
> > > > > >>> recovery or panic the kernel to capture the dump.       =20
> > > > > >>=20
> > > > > >> I'm not convinced we want this.
> > > > > >>=20
> > > > > >> As we've discovered it's often not possible to reconstruct
> > > > > >> what happened based on a dump anyway.
> > > > > >>=20
> > > > > >> The key thing you need is the content of the SLB and that's
> > > > > >> not included in a dump.
> > > > > >>=20
> > > > > >> So I think we should dump the SLB content when we get the
> > > > > >> MCE (which this series does) and any other useful info, and
> > > > > >> then if we can recover we should.       =20
> > > > > >
> > > > > > The reasoning there is what if we got multi-hit due to some
> > > > > > corruption in slb_cache_ptr. ie. some part of kernel is
> > > > > > wrongly updating the paca data structure due to wrong
> > > > > > pointer. Now that is far fetched, but then possible right?.
> > > > > > Hence the idea that, if we don't have much insight into why a
> > > > > > slb multi-hit occur from the dmesg which include slb content,
> > > > > > slb_cache contents etc, there should be an easy way to force
> > > > > > a dump that might assist in further debug.       =20
> > > > >=20
> > > > > If you're debugging something complex that you can't determine
> > > > > from the SLB dump then you should be running a debug kernel
> > > > > anyway. And if anything you want to drop into xmon and sit
> > > > > there, preserving the most state, rather than taking a dump.     =
=20
> > > >=20
> > > > I'm not saying for a dump specifically, just some form of crash.
> > > > And we really should have an option to xmon on panic, but that's
> > > > another story.     =20
> > >=20
> > > That's fine during development or in a lab, not something we could
> > > enforce in a customer environment, could we?   =20
> >=20
> > xmon on panic? Not something to enforce but IMO (without thinking
> > about it too much but having encountered it several times) it should
> > probably be tied xmon on BUG option. =20
>=20
> You should get that with this patch and xmon=3Don or am I missing
> something?

Oh yeah, I just got a bit side tracked and added something not very
relevant -- a panic() call should drop to xmon if we have xmon=3Don. It
doesn't today (or last I looked), but that's nothing to do with this
patch.

Thanks,
Nick
