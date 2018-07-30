Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41f94m1y8MzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Jul 2018 16:43:20 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Menzel <pmenzel@molgen.mpg.de>, linuxppc-dev@ozlabs.org
Cc: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/mm: Don't report PUDs as memory leaks when using
 kmemleak
In-Reply-To: <e653db46-a829-4673-4378-4c0afef03cde@molgen.mpg.de>
References: <20180719143316.23486-1-mpe@ellerman.id.au>
 <e653db46-a829-4673-4378-4c0afef03cde@molgen.mpg.de>
Date: Mon, 30 Jul 2018 16:43:19 +1000
Message-ID: <87zhy9i5q0.fsf@concordia.ellerman.id.au>
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
> Am 19.07.2018 um 16:33 schrieb Michael Ellerman:
...
>>=20
>> The fix is fairly simple. We need to tell kmemleak to ignore PUD
>> allocations and never report them as leaks. We can also tell it not to
>> scan the PGD, because it will never find pointers in there. However it
>> will still notice if we allocate a PGD and then leak it.
>>=20
>> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au> > ---
>>   arch/powerpc/include/asm/book3s/64/pgalloc.h | 23 ++++++++++++++++++++=
+--
>>   1 file changed, 21 insertions(+), 2 deletions(-)
>
> [=E2=80=A6]
>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de> on IBM S822LC

Thanks.

cheers
