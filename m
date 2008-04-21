Return-Path: <david-b@pacbell.net>
Received: from smtp117.sbc.mail.sp1.yahoo.com (smtp117.sbc.mail.sp1.yahoo.com
	[69.147.64.90]) by ozlabs.org (Postfix) with SMTP id 61DEEDE0C5
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 06:04:19 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
Date: Mon, 21 Apr 2008 13:01:12 -0700
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<fa686aa40804210758r70a5906eqb090cd3d8b797317@mail.gmail.com>
	<20080421164128.GA28561@polina.dev.rtsoft.ru>
In-Reply-To: <20080421164128.GA28561@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804211301.13026.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 21 April 2008, Anton Vorontsov wrote:
>  From: J. Random Hacker
>  Subject: [POWERPC] cleanup board initialization code
> 
>  This patch removes vast amount of machine_arch_initcall()s that were
>  used to solely initialize some hardware, like this:
> 
>  qe_add_gpio_chips();
>  fsl_gtm_init();
>  fsl_spi_init();
>  ...
> 
>  So, instead of calling this stuff from the board files, we implement
>  own arch_initcalls for these functions.

The way other platforms do this is to hav SOC-specific
init code, and have board-specific initcalls call the
relevant SOC-specific setup.

Among other things that facilitates kernels that handle
multiple SOCs (if they're closely-enough related).  That
may not be used by many distros (handhelds.org being at
least a partial exception), but it certainly helps cut
the number of configurations that need build-testing.

- Dave
