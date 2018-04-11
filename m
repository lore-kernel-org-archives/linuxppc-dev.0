Return-Path: <srs0=arxf=ha=linaro.org=ard.biesheuvel@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LnBB62zCzF1RX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 00:54:26 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40LnBB4PfZz8tP2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 00:54:26 +1000 (AEST)
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40LnBB0blmz9s3X
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2018 00:54:25 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id y128so2672776iod.4
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2018 07:54:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <40Ln4W304zz9s3X@ozlabs.org>
References: <20180410012206.4395-1-mpe@ellerman.id.au>
 <40Ln4W304zz9s3X@ozlabs.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 11 Apr 2018 16:54:23 +0200
Message-ID: <CAKv+Gu-FTpa9Ykw1Sdroepxp0z2fR2YAsMJzL=jNLoyvGdgqBA@mail.gmail.com>
Subject: Re: powerpc/modules: Fix crashes by adding CONFIG_RELOCATABLE to
 vermagic
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11 April 2018 at 16:49, Michael Ellerman
<patch-notifications@ellerman.id.au> wrote:
> On Tue, 2018-04-10 at 01:22:06 UTC, Michael Ellerman wrote:
>> If you build the kernel with CONFIG_RELOCATABLE=n, then install the
>> modules, rebuild the kernel with CONFIG_RELOCATABLE=y and leave the
>> old modules installed, we crash something like:
>>
>>   Unable to handle kernel paging request for data at address 0xd000000018d66cef
>>   Faulting instruction address: 0xc0000000021ddd08
>>   Oops: Kernel access of bad area, sig: 11 [#1]
>>   Modules linked in: x_tables autofs4
>>   CPU: 2 PID: 1 Comm: systemd Not tainted 4.16.0-rc6-gcc_ubuntu_le-g99fec39 #1
>>   ...
>>   NIP check_version.isra.22+0x118/0x170
>>   Call Trace:
>>     __ksymtab_xt_unregister_table+0x58/0xfffffffffffffcb8 [x_tables] (unreliable)
>>     resolve_symbol+0xb4/0x150
>>     load_module+0x10e8/0x29a0
>>     SyS_finit_module+0x110/0x140
>>     system_call+0x58/0x6c
>>
>> This happens because since commit 71810db27c1c ("modversions: treat
>> symbol CRCs as 32 bit quantities"), a relocatable kernel encodes and
>> handles symbol CRCs differently from a non-relocatable kernel.
>>
>> Although it's possible we could try and detect this situation and
>> handle it, it's much more robust to simply make the state of
>> CONFIG_RELOCATABLE part of the module vermagic.
>>
>> Fixes: 71810db27c1c ("modversions: treat symbol CRCs as 32 bit quantities")
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Applied to powerpc fixes.
>
> https://git.kernel.org/powerpc/c/73aca179d78eaa11604ba0783a6d8b
>
> cheers

Thanks for the cc. I guess this only affects powerpc, given that it is
the only arch that switches between CRC immediate values and CRC
offsets depending on the configuration.
