Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC5Cn6rY0zDvM8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 19:27:33 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paul Burton <paul.burton@imgtec.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Paul Burton <paul.burton@imgtec.com>,
 Andreas Schwab <schwab@linux-m68k.org>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>,
 Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
Subject: Re: [PATCH v3] console: use first console if stdout-path device
 doesn't appear
In-Reply-To: <20161103125758.3415-1-paul.burton@imgtec.com>
References: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
 <20161103125758.3415-1-paul.burton@imgtec.com>
Date: Mon, 07 Nov 2016 19:27:32 +1100
Message-ID: <8737j3n18r.fsf@concordia.ellerman.id.au>
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

Paul Burton <paul.burton@imgtec.com> writes:

> If a device tree specified a preferred device for kernel console output
> via the stdout-path or linux,stdout-path chosen node properties there's
> no guarantee that it will have specified a device for which we have a
> driver. It may also be the case that we do have a driver but it doesn't
> call of_console_check() to register as a preferred console (eg. offb
> driver as used on powermac systems).
>
> In these cases try to ensure that we provide some console output by
> enabling the first usable registered console, which we keep track of
> with the of_fallback_console variable. Affected systems will enable
> their console later than they did prior to commit 05fd007e4629
> ("console: don't prefer first registered if DT specifies stdout-path")
> but should otherwise produce the same output.
>
> Tested in QEMU with a PowerPC pseries_defconfig kernel.

Hi Paul,

This does "work", as in it boots and I get a console. But the delay in
getting output on the VGA is not workable. I get pretty much no output
until the machine is booted entirely to userspace, meaning any crash
prior to that will be undebuggable.

I also note Andreas reports it doesn't work at all on PowerMac.

Please send a revert and we can try again next cycle.

cheers
