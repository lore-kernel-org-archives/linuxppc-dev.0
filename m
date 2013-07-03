Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 121A52C0089
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 04:36:23 +1000 (EST)
Date: Wed, 3 Jul 2013 13:36:15 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/6] KVM: PPC: Book3E: Add AltiVec support
To: Alexander Graf <agraf@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-5-git-send-email-mihai.caraman@freescale.com>
 <BE4790D6-AC7E-4483-9853-139B8BFBCFD7@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A3D41@039-SN2MPN1-013.039d.mgd.msft.net>
 <FA08EF79-D31B-4998-B7FE-BB2BFE3FB65E@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A3E93@039-SN2MPN1-013.039d.mgd.msft.net>
 <098F899F-54BF-4172-958B-C52C015F5142@suse.de>
In-Reply-To: <098F899F-54BF-4172-958B-C52C015F5142@suse.de> (from
 agraf@suse.de on Wed Jul  3 12:07:30 2013)
Message-ID: <1372876575.8183.137@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2013 12:07:30 PM, Alexander Graf wrote:
>=20
> On 03.07.2013, at 18:49, Caraman Mihai Claudiu-B02008 wrote:
>=20
> >>>> Do we need to do this even when the guest doesn't use Altivec? =20
> Can't
> >> we
> >>>> just load it on demand then once we fault? This code path really
> >> should
> >>>> only be a prefetch enable when MSR_VEC is already set in guest
> >> context.
> >>>
> >>> No we can't, read 6/6.
> >>
> >> So we have to make sure we're completely unlazy when it comes to a =20
> KVM
> >> guest. Are we?
> >
> > Yes, because MSR[SPV] is under its control.
>=20
> Oh, sure, KVM wants it unlazy. That part is obvious. But does the =20
> kernel always give us unlazyness? The way I read the code, process.c =20
> goes lazy when !CONFIG_SMP.
>=20
> So the big question is why we're manually enforcing FPU giveup, but =20
> not Altivec giveup? One of the 2 probably is wrong :).

Why do you think we're not enforcing it for Altivec?  Is there some =20
specific piece of code you're referring to that is different in this =20
regard?

-Scott=
