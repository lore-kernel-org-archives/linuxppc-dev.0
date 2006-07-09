Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C205067B54
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jul 2006 11:37:16 +1000 (EST)
Subject: Re: [PATCH] powerpc: EOI and clear IPI fix in xics_teardown_cpu()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Haren Myneni <haren@us.ibm.com>
In-Reply-To: <44B05BD0.304@us.ibm.com>
References: <44B05BD0.304@us.ibm.com>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 11:37:07 +1000
Message-Id: <1152409027.4128.14.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2006-07-08 at 18:28 -0700, Haren Myneni wrote:
> If OK, please sent this patch to upstream.
> 
> Thanks
> Haren
> 
> When invoked kdump boot, plpar_eoi() call is getting failed and calling 
> panic().
> Kernel panic - not syncing: bad return code EOI - rc = -4, value=ff000000
> 
> The issue is with the desc->chip->eoi(XICS_IPI) in xics_teardown_cpu(). 
> Instead of passing the virq to desc->chip->eoi(), XICS_IPI is used. 
> Also, clear IPI in xics_teardown_cpu() got removed recently (in 
> 2.6.17-git25).  Noticed in some crash dump cases (Ex: initiate kdump 
> boot using soft-reset and xmon is enabled), IPI is not cleared for some 
> CPU(s) before starting the kdump boot. Hence, causing the kdump boot 
> failure.

It's already fixed in my latest patch that fixes some issues with the
new irq rework. Hopefully, paul will send the patch upstream tomorrow
after we had a chance to test it a bit more.

Cheers,
Ben
