Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41n2M22chnzDqrN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Aug 2018 21:04:30 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Ananth Narayan <ananth@in.ibm.com>
Subject: Re: [PATCH v7 8/9] powerpc/mce: Add sysctl control for recovery
 action on MCE.
In-Reply-To: <20180808180943.7e8ca319@kitsune.suse.cz>
References: <153365127532.14256.1965469477086140841.stgit@jupiter.in.ibm.com>
 <153365146712.14256.11869543914717297278.stgit@jupiter.in.ibm.com>
 <87o9ecaovz.fsf@concordia.ellerman.id.au>
 <d08a7794-e5c2-2b05-c21a-ae5a7baa7d88@linux.ibm.com>
 <20180808180943.7e8ca319@kitsune.suse.cz>
Date: Fri, 10 Aug 2018 21:04:26 +1000
Message-ID: <87h8k28oud.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michal Such=C3=A1nek <msuchanek@suse.de> writes:
> On Wed, 8 Aug 2018 21:07:11 +0530
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
>> On 08/08/2018 08:26 PM, Michael Ellerman wrote:
>> > Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:=20=20
>> >> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> >>
>> >> Introduce recovery action for recovered memory errors (MCEs).
>> >> There are soft memory errors like SLB Multihit, which can be a
>> >> result of a bad hardware OR software BUG. Kernel can easily
>> >> recover from these soft errors by flushing SLB contents. After the
>> >> recovery kernel can still continue to function without any issue.
>> >> But in some scenario's we may keep getting these soft errors until
>> >> the root cause is fixed. To be able to analyze and find the root
>> >> cause, best way is to gather enough data and system state at the
>> >> time of MCE. Hence this patch introduces a sysctl knob where user
>> >> can decide either to continue after recovery or panic the kernel
>> >> to capture the dump.=20=20
>> >=20
>> > I'm not convinced we want this.
>> >=20
>> > As we've discovered it's often not possible to reconstruct what
>> > happened based on a dump anyway.
>> >=20
>> > The key thing you need is the content of the SLB and that's not
>> > included in a dump.
>> >=20
>> > So I think we should dump the SLB content when we get the MCE (which
>> > this series does) and any other useful info, and then if we can
>> > recover we should.
>>=20
>> The reasoning there is what if we got multi-hit due to some
>> corruption in slb_cache_ptr. ie. some part of kernel is wrongly
>> updating the paca data structure due to wrong pointer. Now that is
>> far fetched, but then possible right?. Hence the idea that, if we
>> don't have much insight into why a slb multi-hit occur from the dmesg
>> which include slb content, slb_cache contents etc, there should be an
>> easy way to force a dump that might assist in further debug.
>
> Nonetheless this turns all MCEs into crashes. Are there any MCEs that
> could happen during normal operation and should be handled by default?

An MCE should always be an indication of an abnormal condition, but
the exact set of things that are reported as MCEs is CPU specific, and
potentially even configurable at the hardware level.

However we only "handle" certain types of MCEs, so if we get an MCE for
something we don't understand then we'll panic already.

SLB multi-hit / parity error is one that we do handle (on bare metal),
because there is a well defined recovery action.

cheers
