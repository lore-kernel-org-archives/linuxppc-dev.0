Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe002.messaging.microsoft.com
	[213.199.154.140]) by ozlabs.org (Postfix) with ESMTP id D138DB6EF2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 18 Sep 2010 03:45:03 +1000 (EST)
Received: from mail18-db3 (localhost.localdomain [127.0.0.1])	by
	mail18-db3-R.bigfish.com (Postfix) with ESMTP id 91831172025E	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 17 Sep 2010 17:54:19 +0000 (UTC)
Received: from DB3EHSMHS006.bigfish.com (unknown [10.3.81.253])	by
	mail18-db3.bigfish.com (Postfix) with ESMTP id 2F0D0600050	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 17 Sep 2010 17:54:19 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8HHiom4024860	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 17 Sep 2010 10:44:50 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8HI05xe029485	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Sep 2010 13:00:06 -0500 (CDT)
Date: Fri, 17 Sep 2010 12:44:48 -0500
From: Scott Wood <scottwood@freescale.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
Subject: Re: Generating elf kernel ?
Message-ID: <20100917124448.255b08cc@schlenkerla.am.freescale.net>
In-Reply-To: <4C92CB51.5010008@windriver.com>
References: <201009141053.11946.dargaud@lpsc.in2p3.fr>
	<20100914125713.GB5768@radix50.net>
	<201009151007.50706.dargaud@lpsc.in2p3.fr>
	<4C90835E.4050803@windriver.com>
	<20100915114912.06bc7ed1@schlenkerla.am.freescale.net>
	<4C9182EC.5030900@windriver.com>
	<20100916120944.11c45c31@schlenkerla.am.freescale.net>
	<4C92CB51.5010008@windriver.com>
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

On Fri, 17 Sep 2010 09:58:41 +0800
"tiejun.chen" <tiejun.chen@windriver.com> wrote:

> Scott Wood wrote:
> > The guest OS *is* the same as native Linux, as far as TLB handling is
> > concerned.
> 
> Looks you means the TLB exception handler should be same between the native and
> the guest OS. Right?

Yes.

> Here I assume we're talking about e500mc since as far as I know for Freescale
> only e500mc is designed to support virtual machine based on ISA 2.0.6.

Yes, though there's nothing preventing virtualization on cores without
category E.HV (KVM supports this) -- it's just slower.

> I also know all TLB exceptions can direct to the guest OS when we enable
> EPCR[DTLBGS|ITLBGS|DSIGS|ISIGS]. But some TLB instructions (i.e. tlbwe )are the
> privileged instructions. So the guest OS always trap into the hypervisor and
> then the hypervisor should complete the real action with appropriate physical
> address. 

Yes, of course.  But that's not the point.  I was just using it as a
convenient example because that's what I've recently done ELF loading
with...  There's no reason U-Boot couldn't do the same if its ELF
loader were updated to support device trees.  Currently U-Boot loads
bootwrapperless uImages to physical address zero.

And FWIW, we have run setups where our hv loads Linux to true
physical zero (with the hv living elsewhere), not just guest physical.

-Scott
