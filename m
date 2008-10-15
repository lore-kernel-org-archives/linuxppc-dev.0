Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2375DE289
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 03:32:23 +1100 (EST)
Message-Id: <A6C48706-BF92-4CF5-98DF-A51C6726D328@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
In-Reply-To: <20081015144359.GA30649@Chamillionaire.breakpoint.cc>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
Date: Wed, 15 Oct 2008 11:31:59 -0500
References: <20080901142302.GA13754@www.tglx.de>
	<76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
	<20081014224946.GA2503@www.tglx.de>
	<20081015085904.GA28369@Chamillionaire.breakpoint.cc>
	<6115D7FB-7500-4F67-B02B-B64B92B33D1A@kernel.crashing.org>
	<20081015144359.GA30649@Chamillionaire.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 15, 2008, at 9:43 AM, Sebastian Andrzej Siewior wrote:

> * Kumar Gala | 2008-10-15 08:25:54 [-0500]:
>
>>
>> On Oct 15, 2008, at 3:59 AM, Sebastian Andrzej Siewior wrote:
>>
>>> * Sebastian Andrzej Siewior | 2008-10-15 00:49:46 [+0200]:
>>>
>>>>> is the -mabi=no-spe really needed?
>>>> It seems to work the other way around (without -mabi=no-spe but  
>>>> with
>>>> -mabi=no-spe) alteast I did not find anything in do_syslog() or  
>>>> while
>>>> browsing through the dissasm. I do a boot check tomorrow.
>>>
>>> Okay. I recompiled with -mspe=no and was able to boot without  
>>> trouble.
>>> It didn't work with -mabi=no-spe.
>>
>> I'm confused.. what did you change from your patch?
>
> This is the patch it right now:
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -103,6 +103,7 @@ KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
>
> # No SPE instruction when building kernel
> KBUILD_CFLAGS += $(call cc-option,-mno-spe)
> +KBUILD_CFLAGS += $(call cc-option,-mspe=no)
>
> # Enable unit-at-a-time mode when possible. It shrinks the
> # kernel considerably.
> -- 
>
> With this patch it compiles and boots fine.
> The option -mabi=no-spe is not required.

ok.  can post a clean patch w/just this change.

- k
