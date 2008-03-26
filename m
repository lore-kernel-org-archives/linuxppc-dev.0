Return-Path: <phdm@macqel.be>
Received: from mail.macqel.be (mail.macqel.be [194.78.208.39])
	by ozlabs.org (Postfix) with ESMTP id 5FB4FDDEDF
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 19:05:50 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.macqel.be (Postfix) with ESMTP id 26C5E150E3A
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 09:05:48 +0100 (CET)
Received: from mail.macqel.be ([127.0.0.1])
	by localhost (mail.macqel.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H1rGr3v7Mf6S for <linuxppc-dev@ozlabs.org>;
	Wed, 26 Mar 2008 09:05:44 +0100 (CET)
Received: from frolo.macqel.be (frolo.macqel [10.1.40.73])
	by mail.macqel.be (Postfix) with ESMTP id DD25A150E2C
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 09:05:44 +0100 (CET)
Date: Wed, 26 Mar 2008 09:05:44 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Haiying Wang <Haiying.Wang@freescale.com>
Subject: Re: how to use head_fsl_booke.S:abort to restart
Message-ID: <20080326080544.GA22200@frolo.macqel>
References: <20080325161513.GB15991@frolo.macqel>
	<1206462895.2960.10.camel@r54964-12.am.freescale.net>
	<20080325202001.GA31145@frolo.macqel>
	<1206478103.2960.29.camel@r54964-12.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1206478103.2960.29.camel@r54964-12.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Haiying,

On Tue, Mar 25, 2008 at 04:48:23PM -0400, Haiying Wang wrote:
> Ok, I see the problem here. For 8540/60 which has e500 v1 core, it
> doesn't use RSTCR to assert HRESET_REQ signal to reset the whole system.
> We probably need to add abort() in fsl_rstcr_restart() for those
> silicons:
> 
> diff --git a/arch/powerpc/sysdev/fsl_soc.c
> b/arch/powerpc/sysdev/fsl_soc.c
> index 2c5388c..c2d07cd 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -1434,7 +1434,8 @@ void fsl_rstcr_restart(char *cmd)
>         if (rstcr)
>                 /* set reset control register */
>                 out_be32(rstcr, 0x2);   /* HRESET_REQ */
> -
> +       else
> +               abort();
>         while (1) ;
>  }
>  #endif

I have a 8540 board, and that works, but as your patch is written,
compilation fails with :

	arch/powerpc/sysdev/fsl_soc.c: In function 'fsl_rstcr_restart':
	arch/powerpc/sysdev/fsl_soc.c:1445: error: implicit declaration
	of function 'abort'
	arch/powerpc/sysdev/fsl_soc.c:1445: warning: incompatible implicit
	declaration of built-in function 'abort'
	make[1]: *** [arch/powerpc/sysdev/fsl_soc.o] Error 1
	make: *** [arch/powerpc/sysdev] Error 2

and if I fix that with :

	 arch_initcall(setup_rstcr);

	+extern void abort(void);
	+
	 void fsl_rstcr_restart(char *cmd)
	 {

it compiles and does reboot, but at startup I still get the following
annoying message :

	rstcr compatible register does not exist!

Philippe
