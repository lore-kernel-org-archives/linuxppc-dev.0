Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7A370DE139
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 04:09:05 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2VIB442025883
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 14:11:04 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2VI90tN223988
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 14:09:00 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2VI908g007535
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Mar 2008 14:09:00 -0400
Date: Mon, 31 Mar 2008 13:05:18 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH] Add idle power save for ppc 4xx
Message-ID: <20080331130518.2a6b0264@zod.rchland.ibm.com>
In-Reply-To: <1206983237.12155.60.camel@vader.jdub.homelinux.org>
References: <10aea37177130bbe5de7.1206969157@thinkpadL>
	<1206983237.12155.60.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 31 Mar 2008 12:07:17 -0500
Josh Boyer <jwboyer@gmail.com> wrote:

> On Mon, 2008-03-31 at 08:12 -0500, Jerone Young wrote:
> > # HG changeset patch
> > # User Jerone Young <jyoung5@us.ibm.com>
> > # Date 1206969060 18000
> > # Node ID 10aea37177130bbe5de7bee6ec06d9010bc5da1f
> > # Parent  1506aa38ddabb0bf73fff3ac3f3db5f9ef6458cc
> > Add idle power save for ppc 4xx
> > 
> > This patch sets the wait state MSR when power_save is called in cpu_idle loop for ppc4xx. This is mainly to help out virtualization solutions such as KVM. This way the virtualization soultions are able to tell if the guest kernel is idle.
> > 
> > I have tested this on hardware & KVM virtual guest.
> 
> I'm not overly thrilled with adding this to all of 4xx.  It doesn't
> actually save much power at all (1% on a project that actually measured
> it with an amp meter recently) and there's really no other benefit to
> doing it outside of the virtual guest case.
> 
> I'm assuming you pass a dtb to the virtual guest when you start it up.
> Could you define a property in the CPU node there that can be parsed to
> use the power_save function instead of always making it the default?

Actually, you probably don't want this as a property in the device
tree.  It doesn't describe hardware.  A Kconfig option might be
warranted though.

josh
