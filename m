Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 31DD9B70A6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 19 Sep 2010 11:38:53 +1000 (EST)
Message-ID: <4C9569FF.6090807@windriver.com>
Date: Sun, 19 Sep 2010 09:40:15 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Generating elf kernel ?
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>	<20100914125713.GB5768@radix50.net>	<201009151007.50706.dargaud@lpsc.in2p3.fr>	<4C90835E.4050803@windriver.com>	<20100915114912.06bc7ed1@schlenkerla.am.freescale.net>	<4C9182EC.5030900@windriver.com>	<20100916120944.11c45c31@schlenkerla.am.freescale.net>	<4C92CB51.5010008@windriver.com>
	<20100917124448.255b08cc@schlenkerla.am.freescale.net>
In-Reply-To: <20100917124448.255b08cc@schlenkerla.am.freescale.net>
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
> On Fri, 17 Sep 2010 09:58:41 +0800
> "tiejun.chen" <tiejun.chen@windriver.com> wrote:
> 
>> Scott Wood wrote:
>>> The guest OS *is* the same as native Linux, as far as TLB handling is
>>> concerned.
>> Looks you means the TLB exception handler should be same between the native and
>> the guest OS. Right?
> 
> Yes.

I don't think so. The HY should assist the guest OS on MMU since I already point
the guest OS have no authority to create a real TLB directly as I previously said.

> 
>> Here I assume we're talking about e500mc since as far as I know for Freescale
>> only e500mc is designed to support virtual machine based on ISA 2.0.6.
> 
> Yes, though there's nothing preventing virtualization on cores without
> category E.HV (KVM supports this) -- it's just slower.

Absolutely.

> 
>> I also know all TLB exceptions can direct to the guest OS when we enable
>> EPCR[DTLBGS|ITLBGS|DSIGS|ISIGS]. But some TLB instructions (i.e. tlbwe )are the
>> privileged instructions. So the guest OS always trap into the hypervisor and
>> then the hypervisor should complete the real action with appropriate physical
>> address. 
> 
> Yes, of course.  But that's not the point.  I was just using it as a
> convenient example because that's what I've recently done ELF loading
> with...  There's no reason U-Boot couldn't do the same if its ELF
> loader were updated to support device trees.  Currently U-Boot loads
> bootwrapperless uImages to physical address zero.

I never doubt the U-boot can do this for uImage. But I think we're always
talking about vmlinux, a bare Image.

Here you already assume so many conditions for vmlinux before we were
discussing. Such as bootwrapperlee uImage, its ELF loader can update/support
dtb, the HY... I think this is just why I say we cannot boot vmlinux based on
common boot loader if only change entry point of vmlinux.

> 
> And FWIW, we have run setups where our hv loads Linux to true
> physical zero (with the hv living elsewhere), not just guest physical.

That's true. The HY should be allowed to access any address.

Best Regards
Tiejun

> 
> -Scott
> 
> 
