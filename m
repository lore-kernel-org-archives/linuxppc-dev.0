Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF94FC04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 10:35:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A3992054F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 10:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A3992054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YZbT3VPBzF3DQ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 21:35:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YZYH5pt8zF3Cn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 21:33:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42YZYH3f5sz9s55;
 Mon, 15 Oct 2018 21:33:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: 32-bit poweroc compile failure in v4.19-rc7-166-g7ec21823634d
In-Reply-To: <17d36e6c-f99a-abfb-12cd-fa4b14bc7e09@linux.ee>
References: <17d36e6c-f99a-abfb-12cd-fa4b14bc7e09@linux.ee>
Date: Mon, 15 Oct 2018 21:33:49 +1100
Message-ID: <87tvlnzegi.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Meelis Roos <mroos@linux.ee> writes:
> I tried to test the fix to 32-bit poweroc boot hang but found that curren=
t git does not compile on 32bit poweroc at all for me:

That's GCC 8 I think?

I have seen that but couldn't work out what the hell GCC is thinking.

I don't think there's an actual bug, the size of the copy is bounded by
the count parameter, which *doesn't* come from user space, it's hard
coded.

I suspect the logic is just to convoluted for GCC.

We should fix it somehow, but I haven't worked out what's the best option.

cheers


>    CC      arch/powerpc/kernel/ptrace.o
> In file included from ./include/linux/bitmap.h:9,
>                   from ./include/linux/cpumask.h:12,
>                   from ./include/linux/rcupdate.h:44,
>                   from ./include/linux/rculist.h:11,
>                   from ./include/linux/pid.h:5,
>                   from ./include/linux/sched.h:14,
>                   from arch/powerpc/kernel/ptrace.c:19:
> In function =E2=80=98memcpy=E2=80=99,
>      inlined from =E2=80=98user_regset_copyin=E2=80=99 at ./include/linux=
/regset.h:295:4,
>      inlined from =E2=80=98vr_set=E2=80=99 at arch/powerpc/kernel/ptrace.=
c:619:9:
> ./include/linux/string.h:345:9: error: =E2=80=98__builtin_memcpy=E2=80=99=
 offset [-527, -529] is out of the bounds [0, 16] of object =E2=80=98vrsave=
=E2=80=99 with type =E2=80=98union <anonymous>=E2=80=99 [-Werror=3Darray-bo=
unds]
>    return __builtin_memcpy(p, q, size);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/kernel/ptrace.c: In function =E2=80=98vr_set=E2=80=99:
> arch/powerpc/kernel/ptrace.c:614:5: note: =E2=80=98vrsave=E2=80=99 declar=
ed here
>     } vrsave;
>       ^~~~~~
> In file included from ./include/linux/bitmap.h:9,
>                   from ./include/linux/cpumask.h:12,
>                   from ./include/linux/rcupdate.h:44,
>                   from ./include/linux/rculist.h:11,
>                   from ./include/linux/pid.h:5,
>                   from ./include/linux/sched.h:14,
>                   from arch/powerpc/kernel/ptrace.c:19:
> In function =E2=80=98memcpy=E2=80=99,
>      inlined from =E2=80=98user_regset_copyout=E2=80=99 at ./include/linu=
x/regset.h:270:4,
>      inlined from =E2=80=98vr_get=E2=80=99 at arch/powerpc/kernel/ptrace.=
c:572:9:
> ./include/linux/string.h:345:9: error: =E2=80=98__builtin_memcpy=E2=80=99=
 offset [-527, -529] is out of the bounds [0, 16] of object =E2=80=98vrsave=
=E2=80=99 with type =E2=80=98union <anonymous>=E2=80=99 [-Werror=3Darray-bo=
unds]
>    return __builtin_memcpy(p, q, size);
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/powerpc/kernel/ptrace.c: In function =E2=80=98vr_get=E2=80=99:
> arch/powerpc/kernel/ptrace.c:567:5: note: =E2=80=98vrsave=E2=80=99 declar=
ed here
>     } vrsave;
>       ^~~~~~
> cc1: all warnings being treated as errors
> make[1]: *** [scripts/Makefile.build:306: arch/powerpc/kernel/ptrace.o] E=
rror 1
> make: *** [Makefile:1052: arch/powerpc/kernel] Error 2
>
> --=20
> Meelis Roos <mroos@linux.ee>
