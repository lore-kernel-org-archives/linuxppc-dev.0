Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BBEDDE4AC
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 01:49:28 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7MFnK7N013611
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:49:20 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m7MFnJ1F009389
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 10:49:19 -0500 (CDT)
Date: Fri, 22 Aug 2008 10:49:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jimi Xenidis <jimix@pobox.com>
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
Message-ID: <20080822154919.GC13422@ld0162-tx32.am.freescale.net>
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<81439C52-0CB6-4C46-9A97-3D30B84F58AF@kernel.crashing.org>
	<48AD7815.70107@linux.vnet.ibm.com>
	<9E570AE9-6811-489F-9E2C-EF5A6B95ED5C@kernel.crashing.org>
	<20080821161622.GB15669@ld0162-tx32.am.freescale.net>
	<48AE73E2.2010706@linux.vnet.ibm.com>
	<542DF8C9-8EB7-40D9-AC66-67D4CF7598F6@kernel.crashing.org>
	<08A55D0E-C75A-49F4-9DBF-EB80E1C7755E@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <08A55D0E-C75A-49F4-9DBF-EB80E1C7755E@pobox.com>
Cc: kvm-ppc@vger.kernel.org, hollisb@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 22, 2008 at 09:56:16AM -0400, Jimi Xenidis wrote:
> Sorry, I have not really been following this, I assume you are  
> replacing SPR accesses with load/stores that do not trap.
> I believe thats fine for reading any SPR, but not true for modifying  
> some SPRs, particularly MSR.
> IMHO you must trap on any instruction that modifies the MSR.
> So you should prolly not rewrite mtmsr or wrtee* but let them trap.

You only need to trap when changing MSR[EE] if there's a pending
interrupt.  The hypervisor can change the mapping of the shared page when
it is unable to deliver an interrupt due to the virtual EE value being
zero.

-Scott
