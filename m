Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 72D982C02B8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 07:40:18 +1000 (EST)
Date: Wed, 10 Jul 2013 16:40:03 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: enable the math emulation for the
 corenet64_smp_defconfig
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <1373420992-25167-1-git-send-email-haokexin@gmail.com> (from
 haokexin@gmail.com on Tue Jul  9 20:49:52 2013)
Message-ID: <1373492403.8183.234@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/09/2013 08:49:52 PM, Kevin Hao wrote:
> I got the following error on my t4240qds board.
>   ntpd[2713]: unhandled signal 4 at 0fd5b448 nip 0fd5b448 lr 0fd5b424 =20
> code 30001
>=20
> The root cause is that the float point instruction 'fsqrt' is used.
> But this instruction is not implemented on e6500 core. Even this
> does seem a gcc bug, I would like to enable the math emulation
> in the kernel to workaround this kind of issue.

I'll apply this, but we should add PPC_WARN_EMULATED to math-emu so =20
that people know when their toolchain is emitting things that require =20
emulation.

It'd also be nice if we had an option to only include the portions of =20
math-emu that are known to be missing in some CPUs (excluding CPUs that =20
are missing the entire FPU, of course).  Besides its effect on kernel =20
image size, in my experience math-emu adds a non-trivial amount of time =20
to a kernel build.

-Scott=
