Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EB3A7DDEF0
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 10:51:35 +1100 (EST)
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
From: Nate Case <ncase@xes-inc.com>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
In-Reply-To: <1224252131.7879.117.camel@localhost.localdomain>
References: <20080901142302.GA13754@www.tglx.de>
	<76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
	<20081014224946.GA2503@www.tglx.de>
	<20081015085904.GA28369@Chamillionaire.breakpoint.cc>
	<6115D7FB-7500-4F67-B02B-B64B92B33D1A@kernel.crashing.org>
	<20081015144359.GA30649@Chamillionaire.breakpoint.cc>
	<1224252131.7879.117.camel@localhost.localdomain>
Content-Type: text/plain
Date: Fri, 24 Oct 2008 18:51:17 -0500
Message-Id: <1224892277.30047.64.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-17 at 09:02 -0500, Nate Case wrote:
> > With this patch it compiles and boots fine.
> > The option -mabi=no-spe is not required.
> 
> Please don't accept this patch yet.  My past testing showed that
> "-mabi=no-spe" was required for my toolchain.  I'll go back and double
> check though.

OK, I went back and re-tested.

Kernel: 2.6.27
CPU: MPC8572
Toolchain:
    Cross-compiler built using crosstool-ng
    gcc 4.3.1, default target CFLAGS include '-mabi=spe -mspe'
    binutils 2.18.90 snapshot (built with --enable-spe=yes)

Kbuild flags                    Result
------------                    ------
-mno-spe (*)                    FAILED
-mno-spe -mabi=no-spe           FAILED
-mno-spe -mspe=no               OK
-mspe=no                        OK

(*) 2.6.27 default

In the failure case, the kernel would repeatedly dump out "SPE used in
kernel (task=xxxxxxxx, pc=xxxxxxxx)".

I think I was fooled before because I added _both_ "-mspe=no" and
"-mabi=no-spe" to my KBUILD_CFLAGS and saw the problem go away.  Since I
trusted the documentation that -mspe=no and -mno-spe were the same, I
assumed that -mabi=no-spe was the key.

So, I've changed my mind.  I now agree with Sebastian that
"-mabi=no-spe" is not required.  "-mno-spe -mspe=no" is probably the
safe way to go.

-- 
Nate Case <ncase@xes-inc.com>
