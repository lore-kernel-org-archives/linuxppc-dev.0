Return-Path: <oohall@gmail.com>
Received: from mail-qk0-x22e.google.com (mail-qk0-x22e.google.com
 [IPv6:2607:f8b0:400d:c09::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSHnk0ZCnzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 22:09:29 +1100 (AEDT)
Received: by mail-qk0-x22e.google.com with SMTP id x71so52579992qkb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 03:09:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <c7b9f444-f7db-c098-0da9-72daeb844546@linux.vnet.ibm.com>
References: <c7b9f444-f7db-c098-0da9-72daeb844546@linux.vnet.ibm.com>
From: "Oliver O'Halloran" <oohall@gmail.com>
Date: Tue, 21 Feb 2017 22:09:26 +1100
Message-ID: <CAOSf1CFTW-wmUNDTigcNxxGaDuGSdf8i=s7QgNUvuDS4WA6TGw@mail.gmail.com>
Subject: Re: [PowerPC] 4.10.0 fails to build on BE config
To: abdul <abdhalee@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 fweisbec@gmail.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 21, 2017 at 6:25 PM, abdul <abdhalee@linux.vnet.ibm.com> wrote:
> Hi,
>
> Today's mainline build, breaks on Power6 and Power7 (all BE config) with
> these build errors
>
> arch/powerpc/kernel/time.c: In function =E2=80=98running_clock=E2=80=99:
> arch/powerpc/kernel/time.c:712:2: error: implicit declaration of function
> =E2=80=98cputime_to_nsecs=E2=80=99 [-Werror=3Dimplicit-function-declarati=
on]
> return local_clock() -
> cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIME_STEAL]);
> ^
> cc1: some warnings being treated as errors
> make[1]: *** [arch/powerpc/kernel/time.o] Error 1
>
>
> Regard's
> Abdul Haleem
> IBM Linux Technology Center.

Hi Abdul,

Are there any extra patches in your tree? I briefly tried to reproduce
this, but in my local tree this line:

> return local_clock() - cputime_to_nsecs(kcpustat_this_cpu->cpustat[CPUTIM=
E_STEAL]);

Is at time.c:692 rather than time.c:712

Oliver
