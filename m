Return-Path: <neko@genesi-usa.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.236])
	by ozlabs.org (Postfix) with ESMTP id A5C45DDF81
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 03:49:59 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id s6so41965wxc.15
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 09:49:58 -0700 (PDT)
Message-ID: <48EE3636.7020305@genesi-usa.com>
Date: Thu, 09 Oct 2008 11:49:58 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
References: <1223495845-14149-1-git-send-email-timur@freescale.com>	
	<1223496186.8157.82.camel@pasglop>	
	<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>	
	<1223498380.8157.86.camel@pasglop>
	<48ED1B9E.3020907@freescale.com>	 <48EE2A49.10405@genesi-usa.com>
	<ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
In-Reply-To: <ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Timur Tabi wrote:
> On Thu, Oct 9, 2008 at 10:59 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> 
>> If you really want to build a single-cpu single-board kernel, disable CHRP
>> and PMAC for those board configs, but the default definitely should be to
>> enable them all within reason
> 
> The problem is that this is inconsistent with most Kconfig options.
> Last I heard, the kernel community generally frowns on "default y" in
> Kconfig options.
> 
> I'm waiting for someone to explain to me what's so special about CHRP
> and PMAC that these two platforms should be enabled by default, when
> all other PowerPC platforms are disabled by default.
> 
> This is what I see in menuconfig when I create a fresh .config for PowerPC:
> 
>   │ │    [*] Common Hardware Reference Platform (CHRP) based machines (NEW)
>   │ │    [ ] Freescale MPC5121E ADS (NEW)
>   │ │    [ ] Generic support for simple MPC5121 based boards (NEW)
>   │ │    [ ] 52xx-based boards (NEW)
>   │ │    [*] Apple PowerMac based machines (NEW)
>   │ │    [ ] 82xx-based boards (PQ II) (NEW)  --->
>   │ │    [ ] 83xx-based boards (NEW)  --->
>   │ │    [ ] 86xx-based boards (NEW)  --->
>   │ │    [ ] Embedded 6xx/7xx/7xxx-based boards (NEW)
> 
> CHRP and PMAC aren't following the rules that everyone else is following.  Why?

Because they are by far the historically most common configuration, and
still in production as the defacto standard PowerPC system configuration.
IBM blades etc. with SLOF will boot up as a CHRP-ish system, as well as the
Efika and Pegasos and anything else Genesi produces. Since Linux distributions
generally do not support tiny embedded boards, you can imagine why it's
disabled by default, but there's no reason it can't be ENABLED by default
and turned off by a distribution, the same way it can't be enabled by
default and turned off by YOU (compare and contrast having to manually
select which board you want to build for every time).

But, turning them all on would not matter. You would build a kernel for
every one and a device tree for every one increasing your build time a
bit for a default kernel, but you would be guaranteed to get a kernel
binary somewhere in the tree that would work on all of them :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
