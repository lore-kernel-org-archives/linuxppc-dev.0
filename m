Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 267C167DA0
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Nov 2006 09:44:50 +1100 (EST)
Message-ID: <45510C58.3010707@ru.mvista.com>
Date: Wed, 08 Nov 2006 01:44:40 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: clockevents and HRT support
References: <200611080005.08633.sshtylyov@ru.mvista.com>
	<1162938997.28571.534.camel@localhost.localdomain>
In-Reply-To: <1162938997.28571.534.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, greg.weeks@timesys.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

>>+#ifdef CONFIG_PPC_MULTIPLATFORM
>>+	/*
>>+	 * We must write a positive value to the decrementer to clear
>>+	 * the interrupt on the IBM 970 CPU series.  In periodic mode,
>>+	 * this happens when the decrementer gets reloaded later, but
>>+	 * in one-shot mode, we have to do it here since an event handler
>>+	 * may skip loading the new value...
>>+	 */
>>+	if (per_cpu(decrementers, cpu).mode != CLOCK_EVT_PERIODIC)
>>+		set_dec(DECREMENTER_MAX);
>>+#endif

> PPC_MULTIPLATFORM is going away soon (or will be set for all CPU types
> in arch/powerpc). Just make up a macro at the top of the file around the
> lines of

> #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
> #define PPC_BOOKE_DECREMENTER
> #endif

> And use #if(n)def PPC_BOOKE_DECREMENTER in the rest of the code.

    That's not equivalent. What I wanted to cover with this option was 970 
weirdness of the decrementer interrupts being level triggered and effectively 
tied to the MSB of the decremeneter register...
    Also, 40x decrementer is not Book E compatible.

> Also, what's the problem with ppc64 deterministic accounting that you
> can't fix it ?

    Arch-specific accounting hooks which this feature makes use of can't be 
called from the generic clockevents code.

> Ben.

WBR, Sergei
