Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 81EDFDE1AB
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Feb 2008 04:23:34 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20080221200758.62940@gmx.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ebff4ecb45908616728fb5c8ede8b0bf@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: How to dynamically disable/enable CPU features?
Date: Fri, 22 Feb 2008 11:24:38 -0600
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At Fri Feb 22 07:07:58 EST 2008, Gerhard Pircher wrote:
> I'm wondering how to disable or enable CPU features based on the board 
> the
> kernel is running on. In my case I want to disable the
> CPU_FTR_NEED_COHERENT flag for 74xx CPUs, because it locks up the 
> machine.
> I tried to clear the flag in the platform's *_probe() function with the
> following code:
>
> cur_cpu_spec->cpu_features &= ~CPU_FTR_NEED_COHERENT;
>
> First I thought that this works fine, because the kernel booted once 
> till
> the console login prompt (and died afterwards). Therefore I suspected 
> that
> another change or bug in the kernel conflicts with my hardware (usually
> the machine died much earlier on older kernels, if the flag wasn't
> cleared).
> Now I removed all CPU_FTR_NEED_COHERENT entries from the cputable.h 
> file
> and the kernel boots just fine without any lockups (reproducable).
> I don't quite understand the difference between dynamically clearing 
> the
> flag in the platform setup code and removing the flag for all CPU
> defines in cputable.h. I can only suspect that clearing the flag in the
> platform probe function is too late, as the MMU and BATs may already be
> set up.
>
> Can anybody confirm my suspicion or give me a hint how to implement it
> correctly? (I don't want to tinker with cputable.h)

We handle cpu features in a couple of ways:
(1) we replace assembly instructions with nop early in the kernel boot
(2) we test the feature flags in c code

In (2), we form two expressions for features that are
(a) always set
(b) never set
so that the compiler can eliminate the test based on the config.

To change a flag, you must make sure its in POSSIBLE but not ALWAYS, 
and also set it before it is used, either to nop out instructions (see 
early_init in setup-32.c for 32 bit), or tested by c code (in this 
case, maybe the initial_mmu setup is testing NEED_COHERENT, which is 
between early_init and probe).  The code path is a bit
different for 64 bit.

milton
