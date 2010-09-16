Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A1C26B6EFF
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 12:36:19 +1000 (EST)
Message-ID: <4C9182EC.5030900@windriver.com>
Date: Thu, 16 Sep 2010 10:37:32 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Generating elf kernel ?
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>	<20100914125713.GB5768@radix50.net>	<201009151007.50706.dargaud@lpsc.in2p3.fr>	<4C90835E.4050803@windriver.com>
	<20100915114912.06bc7ed1@schlenkerla.am.freescale.net>
In-Reply-To: <20100915114912.06bc7ed1@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org, Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> On Wed, 15 Sep 2010 16:27:10 +0800
> "tiejun.chen" <tiejun.chen@windriver.com> wrote:
> 
>> It's impossible to boot PPC vmlinux format directly if you only change the
>> original entry point address, 0xc0000000.
> 
> Why?  That's pretty much what the bootwrapper does.  Our hypervisor has
> directly booted vmlinux this way.

Maybe you misunderstand what I mean.

Although you can change entry point of vmlinux
1> can you load the Linux vmlinux directly to the physical address '0' on
current bootloader?
2> additionally you have to find a way to pass dtb to the native vmlinux.

I believe the hypervisor can boot vmlinux directly. But your so-called vmlinux
should be guest OS. And the hypervisor will handle/assit TLB exception for the
guest OS on MMU. Right?  So you can use the hypervisor to load vmlinux to any
physical address as you expect. But the guest OS should not be same as the
native Linux.

> 
> Note that in recent kernels physaddr is even set to zero, allowing the
> ELF loader to just use that instead of magically knowing the kernel
> wants to go at address zero.

Sure.

> 
>> For kernel the following is as default:
>> v:0xc0000000 --> p:0x0
> 
> That mapping is set up by code at the entry point of vmlinux, not by
> the bootwrapper.

Absolutely.

Tiejun

> 
> -Scott
> 
> 
