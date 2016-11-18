Return-Path: <kda@linux-powerpc.org>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKyNQ6GVbzDvrS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 23:43:50 +1100 (AEDT)
Received: by mail-yw0-x243.google.com with SMTP id b66so19768487ywh.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 04:43:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8760nmxs6b.fsf@concordia.ellerman.id.au>
References: <cover.1475181427.git.christophe.leroy@c-s.fr>
 <CAOJe8K2bYSGe5ciY75eSbthkXNtQwJ2LBdgWcyqqo_jwhmoUsg@mail.gmail.com>
 <8760nmxs6b.fsf@concordia.ellerman.id.au>
From: Denis Kirjanov <kda@linux-powerpc.org>
Date: Fri, 18 Nov 2016 15:43:48 +0300
Message-ID: <CAOJe8K0DsnoQiiT0CFxhJ8_LV784kMuH7cM88OSAgGXm7_Pysw@mail.gmail.com>
Subject: Re: [PATCH 0/2] powerpc: stack protector (-fstack-protector) support
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Scott Wood <oss@buserror.net>, Nicolas Pitre <nicolas.pitre@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/17/16, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Denis Kirjanov <kda@linux-powerpc.org> writes:
>
>> On Friday, September 30, 2016, Christophe Leroy <christophe.leroy@c-s.fr>
>> wrote:
>>
>>> Add HAVE_CC_STACKPROTECTOR to powerpc. This is copied from ARM.
>>>
>>> Not tested on PPC64, compile ok with ppc64_
>>
>>
>> Hi Christophe,
>>
>> are you going to test it on ppc64? If not, I can take it

Not yet, I've broken my test machine :/ I need some time to recover

>
> Did you get around to testing it?
>
> It seems to be working here:
>
>   root@mpe-ubuntu-le:/sys/kernel/debug/provoke-crash# echo CORRUPT_STACK >
> DIRECT
>   Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in:
> c000000000671ed8
>
>   CPU: 1 PID: 3835 Comm: bash Not tainted
> 4.9.0-rc5-compiler_gcc-6.2.0-00075-gf41db6c7a3c8-dirty #464
>   Call Trace:
>   [c0000000dbf73a30] [c000000000541728] dump_stack+0xb8/0x100 (unreliable)
>
>   [c0000000dbf73a70] [c000000000219ba8] panic+0x14c/0x320
>   [c0000000dbf73b10] [c0000000000c27ec] __stack_chk_fail+0x2c/0x30
>   [c0000000dbf73b70] [c000000000671ed8] lkdtm_CORRUPT_STACK+0x88/0x90
>   [c0000000dbf73bf0] [6161616161616161] 0x6161616161616161
>   Rebooting in 10 seconds..
>
>
> cheers
>
