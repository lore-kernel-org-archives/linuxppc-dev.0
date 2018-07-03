Return-Path: <wak@google.com>
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Kthg515zzF1Pn
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2018 04:59:30 +1000 (AEST)
Received: by mail-lj1-x229.google.com with SMTP id o26-v6so2387264ljg.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Jul 2018 11:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnigKnVTg5UiEfou=ABL2DH31rFyGZ_1qtqevJqPPw-V-E6-A@mail.gmail.com>
 <20180703184617.GF16221@gate.crashing.org>
In-Reply-To: <20180703184617.GF16221@gate.crashing.org>
From: William Kennington <wak@google.com>
Date: Tue, 3 Jul 2018 11:59:14 -0700
Message-ID: <CAPnigK=HP_F6a3EuM-G8XHH1G_SyLCscT72=yVwtFxDmBZ6WOQ@mail.gmail.com>
Subject: Re: GCC strcmp optimizations causing valgrind uninitialized
 conditional jumps
To: segher@kernel.crashing.org
Cc: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Is there a bug tracking the issue? Also, unless your malloc is
guaranteed to be zeroing out the data or have a strcmp that is writing
doubleworld aligned data to the string, the strcmp implementation is
branching based on data existing after the null terminating character
that may be uninitialized. Both sides of the branch do the right thing
though, and locate the null terminator, throwing away the calculations
done on the uninitialized data.

-fno-builtin-strcmp or -mstring-compare-inline-limit=0 do work fine
but we don't control the binaries we are linking against in all cases
and are seeing the issue pop up there.
On Tue, Jul 3, 2018 at 11:46 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Hi!
>
> On Tue, Jul 03, 2018 at 11:26:55AM -0700, William Kennington wrote:
> > I've noticed while trying to do some valgrind testing on code linked
> > against system libraries that have inlined strcmps that valgrind is
> > unhappy about branches depending on uninitialized memory. I've read
>
> The branches here do *not* depend on uninitialised memory.  Valgrind
> does not realise that however.  The valgrind people are aware of this
> problem.
>
> > Any ideas on how to workaround / fix this?
>
> Does -fno-builtin-strcmp do the trick?
>
>
> Segher
