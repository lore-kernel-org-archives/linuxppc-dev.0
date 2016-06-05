Return-Path: <olof@lixom.net>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNBgw3YsBzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 08:04:28 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id n127so342336iof.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Jun 2016 15:04:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160511175110.GC996@raspberrypi.musicnaut.iki.fi>
References: <1461601157-27478-1-git-send-email-raj.khem@gmail.com>
 <20160511175110.GC996@raspberrypi.musicnaut.iki.fi>
Date: Sun, 5 Jun 2016 15:04:26 -0700
Message-ID: <CAOesGMjBMNyJcSBVfr9h5UcXgTdLHdfGeGMVZ9Ti63ReoNfkkw@mail.gmail.com>
Subject: Re: [PATCH V2] powerpc/ptrace: Fix out of bounds array access warning
From: Olof Johansson <olof@lixom.net>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Khem Raj <raj.khem@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 11, 2016 at 10:51 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Mon, Apr 25, 2016 at 09:19:17AM -0700, Khem Raj wrote:
>> gcc-6 correctly warns about a out of bounds access
>>
>> arch/powerpc/kernel/ptrace.c:407:24: warning: index 32 denotes an offset greater than size of 'u64[32][1] {aka long long unsigned int[32][1]}' [-Warray-bounds]
>>         offsetof(struct thread_fp_state, fpr[32][0]));
>>                         ^
>>
>> check the end of array instead of beginning of next element to fix this
>>
>> Signed-off-by: Khem Raj <raj.khem@gmail.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Segher Boessenkool <segher@kernel.crashing.org>
>
> This patch fixes PPC kernel build failure with GCC 6.1.
>
> Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

I question the usefulness of this BUG_BUILD_ON() to be honest, but I'd
like to see _a_ fix go in for it for 4.7-rc3 or so to fix the GCC 6.1
build breakage.

So, consider that an:

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
