Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z35hQ3x56zF0CC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 22:22:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Vivier <lvivier@redhat.com>, Paul Mackerras <paulus@ozlabs.org>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 kvm-ppc@vger.kernel.org, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Book3S: fix XIVE migration of pending interrupts
In-Reply-To: <f7e4d221-aa4a-5166-62f7-b0eec735cb57@redhat.com>
References: <20171212120204.6799-1-clg@kaod.org>
 <4be897d4-2d54-305b-8416-b32384de73a9@redhat.com>
 <878tdvpeib.fsf@concordia.ellerman.id.au>
 <20171222075430.GB6945@fergus.ozlabs.ibm.com>
 <f7e4d221-aa4a-5166-62f7-b0eec735cb57@redhat.com>
Date: Fri, 22 Dec 2017 22:22:29 +1100
Message-ID: <87tvwjnh1m.fsf@concordia.ellerman.id.au>
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

Laurent Vivier <lvivier@redhat.com> writes:

> On 22/12/2017 08:54, Paul Mackerras wrote:
>> On Fri, Dec 22, 2017 at 03:34:20PM +1100, Michael Ellerman wrote:
>>> Laurent Vivier <lvivier@redhat.com> writes:
>>>
>>>> On 12/12/2017 13:02, C=C3=A9dric Le Goater wrote:
>>>>> When restoring a pending interrupt, we are setting the Q bit to force
>>>>> a retrigger in xive_finish_unmask(). But we also need to force an EOI
>>>>> in this case to reach the same initial state : P=3D1, Q=3D0.
>>>>>
>>>>> This can be done by not setting 'old_p' for pending interrupts which
>>>>> will inform xive_finish_unmask() that an EOI needs to be sent.
>>>>>
>>>>> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>>>> ---
>>>>>
>>>>>  Tested with a guest running iozone.
>>>>>
>>>>>  arch/powerpc/kvm/book3s_xive.c | 4 ++--
>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> We really need this patch to fix VM migration on POWER9.
>>>> When will it be merged?
>>>
>>> Paul is away, so I'll merge it via the powerpc tree.
>>>
>>> I'll mark it:
>>>
>>>   Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE i=
nterrupt controller")
>>>   Cc: stable@vger.kernel.org # v4.12+
>>=20
>> Thanks for doing that.
>>=20
>> If you felt like merging Alexey's patch "KVM: PPC: Book3S PR: Fix WIMG
>> handling under pHyp" with my acked-by, that would be fine too.  The
>> commit message needs a little work - the reason for using HPTE_R_M is
>> not just because it seems to work, but because current POWER
>> processors require M set on mappings for normal pages, and pHyp
>> enforces that.
>
> We also need:
>
> KVM: PPC: Book3S HV: Fix pending_pri value in kvmppc_xive_get_icp()

I've merged that one.

cheers
