Return-Path: <djiang@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 4230DDDFC0
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 02:58:52 +1000 (EST)
Message-ID: <46322C76.3060903@mvista.com>
Date: Fri, 27 Apr 2007 10:01:42 -0700
From: Dave Jiang <djiang@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>, paulus@samba.org
Subject: Re: [PATCH] add reg and stack dump to booke WD handler
References: <20070413173524.GA17890@blade.az.mvista.com>	<461FCB6F.7010504@ru.mvista.com>	<20070413200659.GA21588@blade.az.mvista.com>	<B8CF9F53-9F51-4DD5-9CB6-16C69502A1CA@kernel.crashing.org>
	<20070413221657.GA23624@blade.az.mvista.com>
In-Reply-To: <20070413221657.GA23624@blade.az.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Dave Jiang wrote:
> > Have the booke watchdog dump some useful information when triggered.
> > Hopefully that'll give the user some hint of what happened rather than just a
> > mysterious reboot.
>
> Why not call either die() or panic()?  Won't they do what you want?

I think the main thing I'm worried about is kexec. Both panic and die handler
can potentially call kexec. The watchdog cannot be killed unless a hardware
reset happens. So it is possible that during the boot of the kexec'd kernel the
watchdog forces a hardware reset. In fact, the watchdog can actually make kdump
rather tricky since the current implementation makes it being kept alive via
userland.

I'm thinking that the only way to get around that is to ping the watchdog
consistently in something such as the timer interrupt. But then we probably
have to move the initialization of the driver into core kernel code and not a
char driver. Do we want to do that?

-- 

------------------------------------------------------
Dave Jiang
Software Engineer
MontaVista Software, Inc.
http://www.mvista.com
------------------------------------------------------
