Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CDF7CDDED4
	for <linuxppc-dev@ozlabs.org>; Thu, 15 May 2008 16:46:18 +1000 (EST)
Subject: Re: Feedback requested on switching the exception wrapper used for
	the PMU interrupt on ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Corey Ashford <cjashfor@us.ibm.com>
In-Reply-To: <482A158A.2010005@us.ibm.com>
References: <OFDA580598.87E2E65B-ON87257448.007AA3F0-88257448.007AB1E1@us.ibm.com>
	<482A158A.2010005@us.ibm.com>
Content-Type: text/plain
Date: Wed, 14 May 2008 23:46:07 -0700
Message-Id: <1210833967.8297.76.camel@pasglop>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-05-13 at 15:26 -0700, Corey Ashford wrote:
> The perfmon2 code is available here: 
> http://sourceforge.net/project/showfiles.php?group_id=144822
> 
> perfmon2's interrupt handler does have a single entry point.  Could I 
> somehow mimic what the MASKABLE_EXCEPTION_PSERIES macro does inside
> of 
> the perfmon2 interrupt handler?  Are there examples of this I can look
> at?
> 
> That would give us the best of both worlds.

You can definitely snapshot as many data as you can, and if interrupts
are soft-disabled, just return to the caller, storing that snapshot in
some per-cpu data structure.

You can then add something to local_irq_restore() that checks whether
some perfmon2 stuff happened and does the actual storing of the data
that were previously collected.

Cheers,
Ben.
