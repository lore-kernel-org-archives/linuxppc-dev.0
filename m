Return-Path: <linuxdev.baldrick@gmail.com>
Received: from mail-io0-x22b.google.com (mail-io0-x22b.google.com
 [IPv6:2607:f8b0:4001:c06::22b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdxgl1GvBzDqmv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 17:06:59 +1000 (AEST)
Received: by mail-io0-x22b.google.com with SMTP id t74so9111298ioi.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 00:06:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1467086888.32607.9.camel@ellerman.id.au>
References: <CAMzoama3BkAfxqzEt2khiPOcKxkOP1JVSx5UcCwWvGJLGrzLtA@mail.gmail.com>
 <1467086888.32607.9.camel@ellerman.id.au>
From: David Binderman <linuxdev.baldrick@gmail.com>
Date: Tue, 28 Jun 2016 08:06:56 +0100
Message-ID: <CAMzoambZ9wu3orkFfYemTQiMpf+OWPdk8v6_SXsJapS74HE13A@mail.gmail.com>
Subject: Re: arch/powerpc/xmon/dis-asm.h: 2 * wrong specifiers ?
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: benh@kernel.crashing.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dcb314@hotmail.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello there,

On Tue, Jun 28, 2016 at 5:08 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> What config / toolchain are you using? I've never seen these.

A static analyser for C & C++ called cppcheck. Available from sourceforge.

I think you can also get a similar warning if you tweek the gcc compiler warning
flags. -Wformat=2 maybe.

>> static inline int print_insn_powerpc(unsigned long insn, unsigned long memaddr)
>> {
>>     printf("%.8x", insn);
>>     return 0;
>> }
>
> Send me a patch to cast insn to unsigned int?

I don't know the code, but given that insn is unsigned long and so can go
past 32 bits, using a cast to unsigned int might throw away the
possibly important
upper bits.


Regards

David Binderman
