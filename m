Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 5A1EAB70F7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Sep 2010 11:57:27 +1000 (EST)
Message-ID: <4C92CB51.5010008@windriver.com>
Date: Fri, 17 Sep 2010 09:58:41 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Generating elf kernel ?
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>	<20100914125713.GB5768@radix50.net>	<201009151007.50706.dargaud@lpsc.in2p3.fr>	<4C90835E.4050803@windriver.com>	<20100915114912.06bc7ed1@schlenkerla.am.freescale.net>	<4C9182EC.5030900@windriver.com>
	<20100916120944.11c45c31@schlenkerla.am.freescale.net>
In-Reply-To: <20100916120944.11c45c31@schlenkerla.am.freescale.net>
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
> On Thu, 16 Sep 2010 10:37:32 +0800
> "tiejun.chen" <tiejun.chen@windriver.com> wrote:
> 
>> 1> can you load the Linux vmlinux directly to the physical address '0' on
>> current bootloader?
> 
> That depends on what bootloader we're talking about -- I don't know
> what the original poster's custom loader can do.  Obviously the
> bootloader itself would have to be executing from some other address
> (e.g. U-Boot runs from the top of RAM).
> 
>> 2> additionally you have to find a way to pass dtb to the native vmlinux.
> 
> Yes, of course.  But that's a different issue. :-)
> 
>> I believe the hypervisor can boot vmlinux directly. But your so-called vmlinux
>> should be guest OS. And the hypervisor will handle/assit TLB exception for the
>> guest OS on MMU. Right?  So you can use the hypervisor to load vmlinux to any
>> physical address as you expect. 
> 
> I was just using our hypervisor as an example, since it has an ELF
> loader that can pass a device tree.
> 
>> But the guest OS should not be same as the native Linux.
> 
> The guest OS *is* the same as native Linux, as far as TLB handling is
> concerned.

Looks you means the TLB exception handler should be same between the native and
the guest OS. Right?

Here I assume we're talking about e500mc since as far as I know for Freescale
only e500mc is designed to support virtual machine based on ISA 2.0.6.

I also know all TLB exceptions can direct to the guest OS when we enable
EPCR[DTLBGS|ITLBGS|DSIGS|ISIGS]. But some TLB instructions (i.e. tlbwe )are the
privileged instructions. So the guest OS always trap into the hypervisor and
then the hypervisor should complete the real action with appropriate physical
address. And also the hypervisor can supervisor if the guest OS want to access
the invalid physical space.

So I don't think the guest OS is same as native Linux :)

Cheers
Tiejun

> 
> -Scott
> 
> 
