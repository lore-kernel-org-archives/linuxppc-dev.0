Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id E2174B6F77
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  2 Apr 2011 17:53:15 +1100 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Evan Lavelle <sa212+lppc@cyconix.com>
Subject: Re: halt/reset on assert?
References: <4D966C5C.9030409__15236.8285613649$1301704900$gmane$org@cyconix.com>
Date: Sat, 02 Apr 2011 08:53:13 +0200
In-Reply-To: <4D966C5C.9030409__15236.8285613649$1301704900$gmane$org@cyconix.com>
	(Evan Lavelle's message of "Sat, 02 Apr 2011 01:22:52 +0100")
Message-ID: <m2sju1uoti.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Evan Lavelle <sa212+lppc@cyconix.com> writes:

> I'd like to use an assert macro in a device driver for an MPC870 using
> ppcboot; something like:
>
> #define MY_ASSERT(expr)                                         \
>    do {                                                         \
>       if(!(expr)) {                                             \
>          printk(                                                \
>             KERN_EMERG                                          \
>             "assertion failure: %s, line %d\n",                 \
>             __FILE__, __LINE__);                                \
>          asm(--ppc halt/reset?)                                 \
>       }                                                         \
>    } while(0)
>
> However, I've got no idea how to halt or reset the processor here. Anyone
> happen to know?

#define MY_ASSERT(expr) BUG_ON(!(expr))

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
