Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2wdT18fKzDsQ4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 15:34:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Laurent Vivier <lvivier@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, kvm-ppc@vger.kernel.org, Paul Mackerras
 <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Book3S: fix XIVE migration of pending interrupts
In-Reply-To: <4be897d4-2d54-305b-8416-b32384de73a9@redhat.com>
References: <20171212120204.6799-1-clg@kaod.org>
 <4be897d4-2d54-305b-8416-b32384de73a9@redhat.com>
Date: Fri, 22 Dec 2017 15:34:20 +1100
Message-ID: <878tdvpeib.fsf@concordia.ellerman.id.au>
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

> On 12/12/2017 13:02, C=C3=A9dric Le Goater wrote:
>> When restoring a pending interrupt, we are setting the Q bit to force
>> a retrigger in xive_finish_unmask(). But we also need to force an EOI
>> in this case to reach the same initial state : P=3D1, Q=3D0.
>>=20
>> This can be done by not setting 'old_p' for pending interrupts which
>> will inform xive_finish_unmask() that an EOI needs to be sent.
>>=20
>> Suggested-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>=20
>>  Tested with a guest running iozone.
>>=20
>>  arch/powerpc/kvm/book3s_xive.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> We really need this patch to fix VM migration on POWER9.
> When will it be merged?

Paul is away, so I'll merge it via the powerpc tree.

I'll mark it:

  Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE inter=
rupt controller")
  Cc: stable@vger.kernel.org # v4.12+

cheers
