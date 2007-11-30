Return-Path: <Tom.Ziomek@motorola.com>
Received: from mail119.messagelabs.com (mail119.messagelabs.com
	[216.82.241.179]) by ozlabs.org (Postfix) with SMTP id 8F9D9DDE0E
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 06:10:05 +1100 (EST)
Received: from il06exr02.mot.com (il06exr02.mot.com [129.188.137.132])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id lAUJA2P2026158
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 12:10:02 -0700 (MST)
Received: from il06vts03.mot.com (il06vts03.mot.com [129.188.137.143])
	by il06exr02.mot.com (8.13.1/Vontu) with SMTP id lAUJA1eP021336
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 13:10:02 -0600 (CST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by il06exr02.mot.com (8.13.1/8.13.0) with ESMTP id lAUJA1ak021330
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 13:10:01 -0600 (CST)
Date: Fri, 30 Nov 2007 13:10:00 -0600 (CST)
From: T Ziomek <ctz001@email.mot.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/24] powerpc: early debug forces console log level to max
In-Reply-To: <20071130061200.4BAF9DDFAE@ozlabs.org>
Message-ID: <Pine.LNX.4.64.0711301306520.5450@gauley.ddna.labs.mot.com>
References: <20071130061200.4BAF9DDFAE@ozlabs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 30 Nov 2007, Benjamin Herrenschmidt wrote:
>
> This patch makes the early debug option force the console loglevel
> to the max. The early debug option is meant to catch messages very
> early in the kernel boot process, in many cases, before the kernel
> has a chance to parse the "debug" command line argument. Thus it
> makes sense when CONFIG_PPC_EARLY_DEBUG is set, to force the console
> log level to the max at boot time.
  . . .
> +#ifdef CONFIG_PPC_EARLY_DEBUG
> +	console_loglevel = 10;
> +#endif
> }

The change makes sense, but wouldn't it also make sense to note it in
arch/powerpc/Kconfig.debug?  Otherwise it's really hard to figure out why,
after bringing up a new board, removing "debug" from the kernel cmd line
does, well, nothing.

Tom
-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
