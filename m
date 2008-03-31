Return-Path: <hollisb@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F2337DE215
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 06:34:49 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2VKYkf8019413
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 16:34:46 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2VKYk05310948
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 16:34:46 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2VKYjsm031148
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 16:34:46 -0400
Subject: Re: [PATCH] Add idle power save for ppc 4xx
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <1206995288.12155.74.camel@vader.jdub.homelinux.org>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
	<20080331130518.2a6b0264@zod.rchland.ibm.com>
	<fsrdp7$958$1@ger.gmane.org>
	<1206995288.12155.74.camel@vader.jdub.homelinux.org>
Content-Type: text/plain
Date: Mon, 31 Mar 2008 15:34:45 -0500
Message-Id: <1206995685.5919.45.camel@basalt>
Mime-Version: 1.0
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	linuxppc-dev@ozlabs.org
Reply-To: Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-03-31 at 15:28 -0500, Josh Boyer wrote:
> On Mon, 2008-03-31 at 19:24 +0000, Hollis Blanchard wrote:
> > On Mon, 31 Mar 2008 13:05:18 -0500, Josh Boyer wrote:
> > 
> > > On Mon, 31 Mar 2008 12:07:17 -0500
> > > Josh Boyer <jwboyer@gmail.com> wrote:
> > > 
> > >> On Mon, 2008-03-31 at 08:12 -0500, Jerone Young wrote:
> > >> > # HG changeset patch
> > >> > # User Jerone Young <jyoung5@us.ibm.com> # Date 1206969060 18000
> > >> > # Node ID 10aea37177130bbe5de7bee6ec06d9010bc5da1f # Parent 
> > >> > 1506aa38ddabb0bf73fff3ac3f3db5f9ef6458cc Add idle power save for ppc
> > >> > 4xx
> > >> > 
> > >> > This patch sets the wait state MSR when power_save is called in
> > >> > cpu_idle loop for ppc4xx. This is mainly to help out virtualization
> > >> > solutions such as KVM. This way the virtualization soultions are able
> > >> > to tell if the guest kernel is idle.
> > >> > 
> > >> > I have tested this on hardware & KVM virtual guest.
> > >> 
> > >> I'm not overly thrilled with adding this to all of 4xx.  It doesn't
> > >> actually save much power at all (1% on a project that actually measured
> > >> it with an amp meter recently) and there's really no other benefit to
> > >> doing it outside of the virtual guest case.
> > 
> > So it slightly helps hardware, and it helps virtualization a *lot*. 
> > What's the problem?
> 
> There's 0 publicly available documentation on exactly what "Wait State
> Enable" means other than the description for the MSR register bit in the
> 4xx UM.  I'm a very paranoid person.
> 
> Explain to me what it really provides with some kind of concrete numbers
> on real hardware and I'll think about it as the default.  Until then, I
> think a Kconfig option (or DT property) is acceptable for now.  I didn't
> say "no", I just said "make it optional."

You can be paranoid about all new features, and then new development
ceases.

Did your project that measured it report any suspicious problems?

> > >> I'm assuming you pass a dtb to the virtual guest when you start it up.
> > >> Could you define a property in the CPU node there that can be parsed to
> > >> use the power_save function instead of always making it the default?
> > > 
> > > Actually, you probably don't want this as a property in the device tree.
> > >  It doesn't describe hardware.  A Kconfig option might be warranted
> > > though.
> > 
> > There will be a device tree binding for hypervisor properties, so if it's 
> > not always enabled, having a hypervisor node (for any hypervisor) in the 
> > device tree would be an indicator. Far better than a Kconfig option, at 
> > any rate.
> 
> But you want this in the guests, right?  Not the hypervisor...

Not sure what you mean. The hypervisor will create device tree
properties for the guests, so the guest could use that property to
initialize the power_save hook.

-- 
Hollis Blanchard
IBM Linux Technology Center
