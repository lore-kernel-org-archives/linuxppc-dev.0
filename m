Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.180])
	by ozlabs.org (Postfix) with ESMTP id E9614DE844
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 06:28:13 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1834419pyg.27
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 13:28:12 -0700 (PDT)
Subject: Re: [PATCH] Add idle power save for ppc 4xx
From: Josh Boyer <jwboyer@gmail.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <fsrdp7$958$1@ger.gmane.org>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
	<20080331130518.2a6b0264@zod.rchland.ibm.com>
	<fsrdp7$958$1@ger.gmane.org>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 15:28:08 -0500
Message-Id: <1206995288.12155.74.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-03-31 at 19:24 +0000, Hollis Blanchard wrote:
> On Mon, 31 Mar 2008 13:05:18 -0500, Josh Boyer wrote:
> 
> > On Mon, 31 Mar 2008 12:07:17 -0500
> > Josh Boyer <jwboyer@gmail.com> wrote:
> > 
> >> On Mon, 2008-03-31 at 08:12 -0500, Jerone Young wrote:
> >> > # HG changeset patch
> >> > # User Jerone Young <jyoung5@us.ibm.com> # Date 1206969060 18000
> >> > # Node ID 10aea37177130bbe5de7bee6ec06d9010bc5da1f # Parent 
> >> > 1506aa38ddabb0bf73fff3ac3f3db5f9ef6458cc Add idle power save for ppc
> >> > 4xx
> >> > 
> >> > This patch sets the wait state MSR when power_save is called in
> >> > cpu_idle loop for ppc4xx. This is mainly to help out virtualization
> >> > solutions such as KVM. This way the virtualization soultions are able
> >> > to tell if the guest kernel is idle.
> >> > 
> >> > I have tested this on hardware & KVM virtual guest.
> >> 
> >> I'm not overly thrilled with adding this to all of 4xx.  It doesn't
> >> actually save much power at all (1% on a project that actually measured
> >> it with an amp meter recently) and there's really no other benefit to
> >> doing it outside of the virtual guest case.
> 
> So it slightly helps hardware, and it helps virtualization a *lot*. 
> What's the problem?

There's 0 publicly available documentation on exactly what "Wait State
Enable" means other than the description for the MSR register bit in the
4xx UM.  I'm a very paranoid person.

Explain to me what it really provides with some kind of concrete numbers
on real hardware and I'll think about it as the default.  Until then, I
think a Kconfig option (or DT property) is acceptable for now.  I didn't
say "no", I just said "make it optional."

> >> I'm assuming you pass a dtb to the virtual guest when you start it up.
> >> Could you define a property in the CPU node there that can be parsed to
> >> use the power_save function instead of always making it the default?
> > 
> > Actually, you probably don't want this as a property in the device tree.
> >  It doesn't describe hardware.  A Kconfig option might be warranted
> > though.
> 
> There will be a device tree binding for hypervisor properties, so if it's 
> not always enabled, having a hypervisor node (for any hypervisor) in the 
> device tree would be an indicator. Far better than a Kconfig option, at 
> any rate.

But you want this in the guests, right?  Not the hypervisor...

josh
