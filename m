Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id D96471007D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Sep 2010 03:09:54 +1000 (EST)
Received: from mail85-va3 (localhost.localdomain [127.0.0.1])	by
	mail85-va3-R.bigfish.com (Postfix) with ESMTP id 680C81040584	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 16 Sep 2010 17:09:48 +0000 (UTC)
Received: from VA3EHSMHS012.bigfish.com (unknown [10.7.14.241])	by
	mail85-va3.bigfish.com (Postfix) with ESMTP id 32A3C9E004C	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 16 Sep 2010 17:09:48 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8GH9k5v010336	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 16 Sep 2010 10:09:46 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8GHP0em018138	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 12:25:00 -0500 (CDT)
Date: Thu, 16 Sep 2010 12:09:44 -0500
From: Scott Wood <scottwood@freescale.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: Generating elf kernel ?
Message-ID: <20100916120944.11c45c31@schlenkerla.am.freescale.net>
In-Reply-To: <4C9182EC.5030900@windriver.com>
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>
	<20100914125713.GB5768@radix50.net>
	<201009151007.50706.dargaud@lpsc.in2p3.fr>
	<4C90835E.4050803@windriver.com>
	<20100915114912.06bc7ed1@schlenkerla.am.freescale.net>
	<4C9182EC.5030900@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org, Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 16 Sep 2010 10:37:32 +0800
"tiejun.chen" <tiejun.chen@windriver.com> wrote:

> 1> can you load the Linux vmlinux directly to the physical address '0' on
> current bootloader?

That depends on what bootloader we're talking about -- I don't know
what the original poster's custom loader can do.  Obviously the
bootloader itself would have to be executing from some other address
(e.g. U-Boot runs from the top of RAM).

> 2> additionally you have to find a way to pass dtb to the native vmlinux.

Yes, of course.  But that's a different issue. :-)

> I believe the hypervisor can boot vmlinux directly. But your so-called vmlinux
> should be guest OS. And the hypervisor will handle/assit TLB exception for the
> guest OS on MMU. Right?  So you can use the hypervisor to load vmlinux to any
> physical address as you expect. 

I was just using our hypervisor as an example, since it has an ELF
loader that can pass a device tree.

> But the guest OS should not be same as the native Linux.

The guest OS *is* the same as native Linux, as far as TLB handling is
concerned.

-Scott
