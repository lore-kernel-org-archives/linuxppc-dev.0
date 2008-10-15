Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 72D22DE532
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 01:44:10 +1100 (EST)
Date: Wed, 15 Oct 2008 16:43:59 +0200
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
Message-ID: <20081015144359.GA30649@Chamillionaire.breakpoint.cc>
References: <20080901142302.GA13754@www.tglx.de>
	<76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
	<20081014224946.GA2503@www.tglx.de>
	<20081015085904.GA28369@Chamillionaire.breakpoint.cc>
	<6115D7FB-7500-4F67-B02B-B64B92B33D1A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <6115D7FB-7500-4F67-B02B-B64B92B33D1A@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Nate Case <ncase@xes-inc.com>, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Kumar Gala | 2008-10-15 08:25:54 [-0500]:

>
> On Oct 15, 2008, at 3:59 AM, Sebastian Andrzej Siewior wrote:
>
>> * Sebastian Andrzej Siewior | 2008-10-15 00:49:46 [+0200]:
>>
>>>> is the -mabi=no-spe really needed?
>>> It seems to work the other way around (without -mabi=no-spe but with
>>> -mabi=no-spe) alteast I did not find anything in do_syslog() or while
>>> browsing through the dissasm. I do a boot check tomorrow.
>>
>> Okay. I recompiled with -mspe=no and was able to boot without trouble.
>> It didn't work with -mabi=no-spe.
>
> I'm confused.. what did you change from your patch?

This is the patch it right now:
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -103,6 +103,7 @@ KBUILD_CFLAGS += $(call cc-option,-mno-altivec)

 # No SPE instruction when building kernel
 KBUILD_CFLAGS += $(call cc-option,-mno-spe)
+KBUILD_CFLAGS += $(call cc-option,-mspe=no)

 # Enable unit-at-a-time mode when possible. It shrinks the
 # kernel considerably.
-- 

With this patch it compiles and boots fine.
The option -mabi=no-spe is not required.

> - k
Sebastian
