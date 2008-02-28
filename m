Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0C575DDF73
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 03:44:55 +1100 (EST)
Date: Thu, 28 Feb 2008 17:44:08 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: undefined references to __udivdi3 on powerpc
Message-ID: <20080228164408.GA8813@aepfle.de>
References: <20080228133718.GA8383@aepfle.de>
	<39a171fd2cc7fec9813c5b3070b193ee@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <39a171fd2cc7fec9813c5b3070b193ee@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 28, Segher Boessenkool wrote:

>> While debugging __divdi3 calls in drivers/crypto/hifn_795x.c (due to the
>> ndelay() delay call with a s64), I found even more breakage of that
>> sort. This is after a allnoconfig with ARCH=powerpc in 2.6.25-rc3,
>> plus CONFIG_MODULES=y and CONFIG_CRYPTO_DEV_HIFN_795X=y:
>
> I cannot reproduce this, but my tree has
>
> 	time: prevent the loop in timespec_add_ns() from being optimised away
>
> which is in -mm now.  Could you try that patch?

Yes, this patch fixes it.
Thanks.
