Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99515DE14C
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 09:35:57 +1100 (EST)
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
References: <20080901142302.GA13754@www.tglx.de>
	<76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 14 Oct 2008 17:35:44 -0500
Message-Id: <1224023744.7879.109.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sebastian Siewior <bigeasy@linutronix.de>,
	ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-10-14 at 16:23 -0500, Kumar Gala wrote:
> Why does -mno-spe work?
> 
>  From my gcc-4.3 info pages:
> 
> `-mspe=YES/NO'
>       This option has been deprecated.  Use `-mspe' and `-mno-spe'
>       instead.
> 
> > +KBUILD_CFLAGS += $(call cc-option,-mabi=no-spe)
> 
> is the -mabi=no-spe really needed?

My guess is that the -mabi=no-spe was the real key of what made it work
for him.  I went through the same thing with my toolchain.

You do need -mabi=no-spe if your toolchain defaults to -mabi=spe like
mine does.  I know that the more generic toolchains out there
(CodeSourcery, ELDK) default to -mabi=no-spe, so in that case it would
not be necessary.

I don't know what generated instructions are actually to blame, but I do
know that if you compile certain programs with "-mno-spe -mabi=spe" vs.
"-mno-spe -mabi=no-spe", the results will differ.  In the case of the
kernel, you'll get a bunch of "SPE used in kernel" messages with the
"-mno-spe -mabi=spe" combination.

- Nate Case <ncase@xes-inc.com>
