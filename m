Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKJkj6x4mzDvnM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 22:27:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>,
 Nicolas Pitre <nicolas.pitre@linaro.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] powerpc: stack protector (-fstack-protector) support
In-Reply-To: <CAOJe8K2bYSGe5ciY75eSbthkXNtQwJ2LBdgWcyqqo_jwhmoUsg@mail.gmail.com>
References: <cover.1475181427.git.christophe.leroy@c-s.fr>
 <CAOJe8K2bYSGe5ciY75eSbthkXNtQwJ2LBdgWcyqqo_jwhmoUsg@mail.gmail.com>
Date: Thu, 17 Nov 2016 22:27:24 +1100
Message-ID: <8760nmxs6b.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Denis Kirjanov <kda@linux-powerpc.org> writes:

> On Friday, September 30, 2016, Christophe Leroy <christophe.leroy@c-s.fr>
> wrote:
>
>> Add HAVE_CC_STACKPROTECTOR to powerpc. This is copied from ARM.
>>
>> Not tested on PPC64, compile ok with ppc64_
>
>
> Hi Christophe,
>
> are you going to test it on ppc64? If not, I can take it

Did you get around to testing it?

It seems to be working here:

  root@mpe-ubuntu-le:/sys/kernel/debug/provoke-crash# echo CORRUPT_STACK > DIRECT
  Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: c000000000671ed8
  
  CPU: 1 PID: 3835 Comm: bash Not tainted 4.9.0-rc5-compiler_gcc-6.2.0-00075-gf41db6c7a3c8-dirty #464
  Call Trace:
  [c0000000dbf73a30] [c000000000541728] dump_stack+0xb8/0x100 (unreliable)
  
  [c0000000dbf73a70] [c000000000219ba8] panic+0x14c/0x320
  [c0000000dbf73b10] [c0000000000c27ec] __stack_chk_fail+0x2c/0x30
  [c0000000dbf73b70] [c000000000671ed8] lkdtm_CORRUPT_STACK+0x88/0x90
  [c0000000dbf73bf0] [6161616161616161] 0x6161616161616161
  Rebooting in 10 seconds..


cheers
