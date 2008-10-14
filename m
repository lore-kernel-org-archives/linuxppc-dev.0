Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D75CDDDFF
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Oct 2008 08:23:17 +1100 (EST)
Message-Id: <76A823BD-A9B8-4FB4-B09B-F818687193CA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sebastian Siewior <bigeasy@linutronix.de>
In-Reply-To: <20080901142302.GA13754@www.tglx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: enforce a non-spe kernel build even on broken
	compilers
Date: Tue, 14 Oct 2008 16:23:05 -0500
References: <20080901142302.GA13754@www.tglx.de>
Cc: linuxppc-dev@ozlabs.org, ths@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 1, 2008, at 9:23 AM, Sebastian Siewior wrote:

> From: Thiemo Seufer <ths@linutronix.de>
>
> those two are requried on my fresh gcc 4.3.1
>
> Signed-off-by: Thiemo Seufer <ths@linutronix.de>
> Signed-off-by: Sebastian Siewior <bigeasy@linutronix.de>
> ---
> Not sure if this is intendent or a gcc bug but with -mno-spe
> the spe opcodes were not used floating point anymore but
> for 64bit save/restore for instance.

what code is getting generated for you that is causing issue?

> arch/powerpc/Makefile |    3 +++
> 1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index b7d4c4c..3727e4f 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -108,7 +108,10 @@ endif
> KBUILD_CFLAGS += $(call cc-option,-mno-altivec)
>
> # No SPE instruction when building kernel
> +# (We use all available options to help semi-broken compilers)
> KBUILD_CFLAGS += $(call cc-option,-mno-spe)
> +KBUILD_CFLAGS += $(call cc-option,-mspe=no)

Why does -mno-spe work?

 From my gcc-4.3 info pages:

`-mspe=YES/NO'
      This option has been deprecated.  Use `-mspe' and `-mno-spe'
      instead.

> +KBUILD_CFLAGS += $(call cc-option,-mabi=no-spe)

is the -mabi=no-spe really needed?

- k
