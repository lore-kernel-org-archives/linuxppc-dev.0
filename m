Return-Path: <srs0=btpr=hg=linaro.org=ard.biesheuvel@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QSfD434MzF1sR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 00:42:58 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40QSf84Dpwz8wMW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Apr 2018 00:42:56 +1000 (AEST)
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40QSf360SPz9s2R
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2018 00:42:51 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id u62-v6so16491660ita.5
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2018 07:42:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87in8ri6nf.fsf@concordia.ellerman.id.au>
References: <20180410012206.4395-1-mpe@ellerman.id.au>
 <40Ln4W304zz9s3X@ozlabs.org>
 <CAKv+Gu-FTpa9Ykw1Sdroepxp0z2fR2YAsMJzL=jNLoyvGdgqBA@mail.gmail.com>
 <87in8ri6nf.fsf@concordia.ellerman.id.au>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 17 Apr 2018 16:42:48 +0200
Message-ID: <CAKv+Gu9L0_Q4vfc=iFFZ=HGPgsNMika9FPA9Bs4TfR1TA7kZ3w@mail.gmail.com>
Subject: Re: powerpc/modules: Fix crashes by adding CONFIG_RELOCATABLE to
 vermagic
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16 April 2018 at 16:10, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Ard Biesheuvel <ard.biesheuvel@linaro.org> writes:
>
>> On 11 April 2018 at 16:49, Michael Ellerman
>> <patch-notifications@ellerman.id.au> wrote:
>>> On Tue, 2018-04-10 at 01:22:06 UTC, Michael Ellerman wrote:
>>>> If you build the kernel with CONFIG_RELOCATABLE=n, then install the
>>>> modules, rebuild the kernel with CONFIG_RELOCATABLE=y and leave the
>>>> old modules installed, we crash something like:
>>>>
>>>>   Unable to handle kernel paging request for data at address 0xd000000018d66cef
>>>>   Faulting instruction address: 0xc0000000021ddd08
>>>>   Oops: Kernel access of bad area, sig: 11 [#1]
>>>>   Modules linked in: x_tables autofs4
>>>>   CPU: 2 PID: 1 Comm: systemd Not tainted 4.16.0-rc6-gcc_ubuntu_le-g99fec39 #1
>>>>   ...
>>>>   NIP check_version.isra.22+0x118/0x170
>>>>   Call Trace:
>>>>     __ksymtab_xt_unregister_table+0x58/0xfffffffffffffcb8 [x_tables] (unreliable)
>>>>     resolve_symbol+0xb4/0x150
>>>>     load_module+0x10e8/0x29a0
>>>>     SyS_finit_module+0x110/0x140
>>>>     system_call+0x58/0x6c
>>>>
>>>> This happens because since commit 71810db27c1c ("modversions: treat
>>>> symbol CRCs as 32 bit quantities"), a relocatable kernel encodes and
>>>> handles symbol CRCs differently from a non-relocatable kernel.
>>>>
>>>> Although it's possible we could try and detect this situation and
>>>> handle it, it's much more robust to simply make the state of
>>>> CONFIG_RELOCATABLE part of the module vermagic.
>>>>
>>>> Fixes: 71810db27c1c ("modversions: treat symbol CRCs as 32 bit quantities")
>>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>
>>> Applied to powerpc fixes.
>>>
>>> https://git.kernel.org/powerpc/c/73aca179d78eaa11604ba0783a6d8b
>>
>> Thanks for the cc. I guess this only affects powerpc, given that it is
>> the only arch that switches between CRC immediate values and CRC
>> offsets depending on the configuration.
>
> No worries.
>
> Is there any reason we shouldn't always turn on CONFIG_MODULE_REL_CRCS?
> It seems to work, but I wanted to test it more before switching to that,
> hence the quick fix above.
>
>
> arch/um looks like it might be switching based on config, but I don't
> know enough to say:
>
>   config LD_SCRIPT_STATIC
>         bool
>         default y
>         depends on STATIC_LINK
>
>   config LD_SCRIPT_DYN
>         bool
>         default y
>         depends on !LD_SCRIPT_STATIC
>           select MODULE_REL_CRCS if MODVERSIONS
>

The only reason not to enable it is that it ends up taking more space
on a 32-bit architecture with CONFIG_RELOCATABLE=n, given that you
need to record both the relative offset and the actual CRC value (both
32-bit quantities) rather than just the CRC itself. On a 64-bit arch
with CONFIG_RELOCATABLE=n, you end up replacing a single 64-bit
quantity with two 32-bit quantities, so it doesn't really matter.
