Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 1344A2C00B3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 04:45:43 +1000 (EST)
Subject: Re: [PATCH 4/6] KVM: PPC: Book3E: Add AltiVec support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1372876575.8183.137@snotra>
Date: Wed, 3 Jul 2013 20:45:38 +0200
Message-Id: <E95352A0-AC32-4CFE-BBDF-8AD9014B88DD@suse.de>
References: <1372855359-13452-1-git-send-email-mihai.caraman@freescale.com>
 <1372855359-13452-5-git-send-email-mihai.caraman@freescale.com>
 <BE4790D6-AC7E-4483-9853-139B8BFBCFD7@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A3D41@039-SN2MPN1-013.039d.mgd.msft.net>
 <FA08EF79-D31B-4998-B7FE-BB2BFE3FB65E@suse.de>
 <300B73AA675FCE4A93EB4FC1D42459FF0A2A3E93@039-SN2MPN1-013.039d.mgd.msft.net>
 <098F899F-54BF-4172-958B-C52C015F5142@suse.de> <1372876575.8183.137@snotra>
To: Scott Wood <scottwood@freescale.com>
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


On 03.07.2013, at 20:36, Scott Wood wrote:

> On 07/03/2013 12:07:30 PM, Alexander Graf wrote:
>> On 03.07.2013, at 18:49, Caraman Mihai Claudiu-B02008 wrote:
>> >>>> Do we need to do this even when the guest doesn't use Altivec? =
Can't
>> >> we
>> >>>> just load it on demand then once we fault? This code path really
>> >> should
>> >>>> only be a prefetch enable when MSR_VEC is already set in guest
>> >> context.
>> >>>
>> >>> No we can't, read 6/6.
>> >>
>> >> So we have to make sure we're completely unlazy when it comes to a =
KVM
>> >> guest. Are we?
>> >
>> > Yes, because MSR[SPV] is under its control.
>> Oh, sure, KVM wants it unlazy. That part is obvious. But does the =
kernel always give us unlazyness? The way I read the code, process.c =
goes lazy when !CONFIG_SMP.
>> So the big question is why we're manually enforcing FPU giveup, but =
not Altivec giveup? One of the 2 probably is wrong :).
>=20
> Why do you think we're not enforcing it for Altivec?  Is there some =
specific piece of code you're referring to that is different in this =
regard?

Well, apparently because I misread the code :). All is well.


Alex
