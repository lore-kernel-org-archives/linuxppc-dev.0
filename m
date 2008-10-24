Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C7CDDDE06
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:56:16 +1100 (EST)
Message-Id: <15DE97BA-2254-4553-BEF2-C92D0C18B9DD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1224892277.30047.64.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
Date: Fri, 24 Oct 2008 18:55:56 -0500
References: <20080901142302.GA13754@www.tglx.de>
	<76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
	<20081014224946.GA2503@www.tglx.de>
	<20081015085904.GA28369@Chamillionaire.breakpoint.cc>
	<6115D7FB-7500-4F67-B02B-B64B92B33D1A@kernel.crashing.org>
	<20081015144359.GA30649@Chamillionaire.breakpoint.cc>
	<1224252131.7879.117.camel@localhost.localdomain>
	<1224892277.30047.64.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 24, 2008, at 6:51 PM, Nate Case wrote:

> On Fri, 2008-10-17 at 09:02 -0500, Nate Case wrote:
>>> With this patch it compiles and boots fine.
>>> The option -mabi=no-spe is not required.
>>
>> Please don't accept this patch yet.  My past testing showed that
>> "-mabi=no-spe" was required for my toolchain.  I'll go back and  
>> double
>> check though.
>
> OK, I went back and re-tested.
>
> Kernel: 2.6.27
> CPU: MPC8572
> Toolchain:
>    Cross-compiler built using crosstool-ng
>    gcc 4.3.1, default target CFLAGS include '-mabi=spe -mspe'
>    binutils 2.18.90 snapshot (built with --enable-spe=yes)
>
> Kbuild flags                    Result
> ------------                    ------
> -mno-spe (*)                    FAILED
> -mno-spe -mabi=no-spe           FAILED
> -mno-spe -mspe=no               OK
> -mspe=no                        OK
>
> (*) 2.6.27 default
>
> In the failure case, the kernel would repeatedly dump out "SPE used in
> kernel (task=xxxxxxxx, pc=xxxxxxxx)".
>
> I think I was fooled before because I added _both_ "-mspe=no" and
> "-mabi=no-spe" to my KBUILD_CFLAGS and saw the problem go away.   
> Since I
> trusted the documentation that -mspe=no and -mno-spe were the same, I
> assumed that -mabi=no-spe was the key.
>
> So, I've changed my mind.  I now agree with Sebastian that
> "-mabi=no-spe" is not required.  "-mno-spe -mspe=no" is probably the
> safe way to go.
>
> -- 
> Nate Case <ncase@xes-inc.com>

thanks for testing this all out.

I'll submit a patch to remove the -mabi=.*spe.* foo.

- k
