Return-Path: <shhuiw@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C7243B6FBB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 May 2012 09:35:57 +1000 (EST)
Received: by obbup19 with SMTP id up19so3267698obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 03 May 2012 16:35:55 -0700 (PDT)
Message-ID: <4FA31653.5090103@gmail.com>
Date: Fri, 04 May 2012 07:35:47 +0800
From: Wang Sheng-Hui <shhuiw@gmail.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: use local var instead of local_paca->irq_happened
 directly in __check_irq_replay
References: <4FA1E527.1090807@gmail.com> <1336011306.2653.3.camel@pasglop>	
 <1336018961.2653.11.camel@pasglop> <4FA226A8.1080903@gmail.com>	
 <4FA22CC5.3010107@gmail.com> <1336032561.18712.1.camel@pasglop>
In-Reply-To: <1336032561.18712.1.camel@pasglop>
Content-Type: text/plain; charset=UTF-8
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2012年05月03日 16:09, Benjamin Herrenschmidt wrote:
> On Thu, 2012-05-03 at 14:59 +0800, Wang Sheng-Hui wrote:
>> On 2012年05月03日 14:33, Wang Sheng-Hui wrote:
>>> if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
>>>> 		__hard_irq_disable();
>>
>> I have commented out the 2 lines.
> 
> No, Only comment the test, you must absolutely leave the
> __hard_irq_disable() call ! That's the whole point of the test, make
> sure we unconditionally disable to see if that fixes the problem, in
> which case that will tell us that we somewhere accidentally leave
> irq_happened set to 0x01 while irqs are hard enabled.

It can work.
My system has been running for about 15 hours without crash.

> 
> Cheers,
> Ben.
> 
> 
