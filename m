Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hjmf1VThzF2FB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 20:23:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linuxppc-dev@ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/mm: Don't report PUDs as memory leaks when using
 kmemleak
In-Reply-To: <83c5b57f-f11d-3223-4d24-5030799caa0c@molgen.mpg.de>
References: <20180719143316.23486-1-mpe@ellerman.id.au>
 <e653db46-a829-4673-4378-4c0afef03cde@molgen.mpg.de>
 <87zhy9i5q0.fsf@concordia.ellerman.id.au>
 <83c5b57f-f11d-3223-4d24-5030799caa0c@molgen.mpg.de>
Date: Fri, 03 Aug 2018 20:23:10 +1000
Message-ID: <87h8kbhhpt.fsf@concordia.ellerman.id.au>
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

Paul Menzel <pmenzel@molgen.mpg.de> writes:
> On 07/30/18 08:43, Michael Ellerman wrote:
>> Paul Menzel <pmenzel@molgen.mpg.de> writes:
>>> Am 19.07.2018 um 16:33 schrieb Michael Ellerman:
>> ...
>>>>
>>>> The fix is fairly simple. We need to tell kmemleak to ignore PUD
>>>> allocations and never report them as leaks. We can also tell it not to
>>>> scan the PGD, because it will never find pointers in there. However it
>>>> will still notice if we allocate a PGD and then leak it.
>>>>
>>>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au> > ---
>>>>   arch/powerpc/include/asm/book3s/64/pgalloc.h | 23 ++++++++++++++++++=
+++--
>>>>   1 file changed, 21 insertions(+), 2 deletions(-)
>>>
>>> [=E2=80=A6]
>>>
>>> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> on IBM S822LC
>>=20
>> Thanks.
>
> No problem. I forgot to add, that it=E2=80=99d be great, if you tagged th=
is
> for the stable series too.

Sorry I didn't see this before I applied, so it's not tagged for stable.

We can request a backport though, what stable version(s) are you
running?

cheers
