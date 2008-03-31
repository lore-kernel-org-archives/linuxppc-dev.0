Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 37CE4DE01A
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 06:05:10 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JgPcP-0002B8-Ml
	for linuxppc-dev@ozlabs.org; Mon, 31 Mar 2008 19:24:33 +0000
Received: from bi01p1.co.us.ibm.com ([32.97.110.142])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 19:24:33 +0000
Received: from hollisb by bi01p1.co.us.ibm.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 19:24:33 +0000
To: linuxppc-dev@ozlabs.org
From: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH] Add idle power save for ppc 4xx
Date: Mon, 31 Mar 2008 19:24:24 +0000 (UTC)
Message-ID: <fsrdp7$958$1@ger.gmane.org>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
	<20080331130518.2a6b0264@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 31 Mar 2008 13:05:18 -0500, Josh Boyer wrote:

> On Mon, 31 Mar 2008 12:07:17 -0500
> Josh Boyer <jwboyer@gmail.com> wrote:
> 
>> On Mon, 2008-03-31 at 08:12 -0500, Jerone Young wrote:
>> > # HG changeset patch
>> > # User Jerone Young <jyoung5@us.ibm.com> # Date 1206969060 18000
>> > # Node ID 10aea37177130bbe5de7bee6ec06d9010bc5da1f # Parent 
>> > 1506aa38ddabb0bf73fff3ac3f3db5f9ef6458cc Add idle power save for ppc
>> > 4xx
>> > 
>> > This patch sets the wait state MSR when power_save is called in
>> > cpu_idle loop for ppc4xx. This is mainly to help out virtualization
>> > solutions such as KVM. This way the virtualization soultions are able
>> > to tell if the guest kernel is idle.
>> > 
>> > I have tested this on hardware & KVM virtual guest.
>> 
>> I'm not overly thrilled with adding this to all of 4xx.  It doesn't
>> actually save much power at all (1% on a project that actually measured
>> it with an amp meter recently) and there's really no other benefit to
>> doing it outside of the virtual guest case.

So it slightly helps hardware, and it helps virtualization a *lot*. 
What's the problem?

>> I'm assuming you pass a dtb to the virtual guest when you start it up.
>> Could you define a property in the CPU node there that can be parsed to
>> use the power_save function instead of always making it the default?
> 
> Actually, you probably don't want this as a property in the device tree.
>  It doesn't describe hardware.  A Kconfig option might be warranted
> though.

There will be a device tree binding for hypervisor properties, so if it's 
not always enabled, having a hypervisor node (for any hypervisor) in the 
device tree would be an indicator. Far better than a Kconfig option, at 
any rate.

-- 
Hollis Blanchard
IBM Linux Technology Center
