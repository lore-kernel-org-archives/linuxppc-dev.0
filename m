Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E95BDDDD0C
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 02:41:21 +1100 (EST)
In-Reply-To: <20080228133718.GA8383@aepfle.de>
References: <20080228133718.GA8383@aepfle.de>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <39a171fd2cc7fec9813c5b3070b193ee@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: undefined references to __udivdi3 on powerpc
Date: Thu, 28 Feb 2008 16:40:19 +0100
To: Olaf Hering <olaf@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> While debugging __divdi3 calls in drivers/crypto/hifn_795x.c (due to 
> the
> ndelay() delay call with a s64), I found even more breakage of that
> sort. This is after a allnoconfig with ARCH=powerpc in 2.6.25-rc3,
> plus CONFIG_MODULES=y and CONFIG_CRYPTO_DEV_HIFN_795X=y:

I cannot reproduce this, but my tree has

	time: prevent the loop in timespec_add_ns() from being optimised away

which is in -mm now.  Could you try that patch?


Segher
