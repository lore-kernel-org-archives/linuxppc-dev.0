Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t9Dt824ztzDvYc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Nov 2016 19:05:51 +1100 (AEDT)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Paul Burton <paul.burton@imgtec.com>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov <bp@suse.de>,
 Petr Mladek <pmladek@suse.com>, Tejun Heo <tj@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3] console: use first console if stdout-path device
 doesn't appear
References: <2c67e39b-fc33-918a-774e-d9238e837c03@lwfinger.net>
 <20161103125758.3415-1-paul.burton@imgtec.com>
Date: Fri, 04 Nov 2016 09:05:38 +0100
In-Reply-To: <20161103125758.3415-1-paul.burton@imgtec.com> (Paul Burton's
 message of "Thu, 3 Nov 2016 12:57:58 +0000")
Message-ID: <87y40zd60d.fsf@linux-m68k.org>
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

On Nov 03 2016, Paul Burton <paul.burton@imgtec.com> wrote:

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

Unfortunately, that still doesn't work on PowerMac.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
