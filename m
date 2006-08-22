Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [80.68.93.146])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3759167BE4
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 03:15:40 +1000 (EST)
Subject: Re: [PATCH ] powerpc: Add tsi108/9 and non standard mpic support
From: Adrian Cox <adrian@humboldt.co.uk>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E19E353@zch01exm23.fsl.freescale.net>
References: <7EA18FDD2DC2154AA3BD6D2F22A62A0E19E353@zch01exm23.fsl.freescale.net>
Content-Type: text/plain
Date: Tue, 22 Aug 2006 18:15:14 +0100
Message-Id: <1156266914.10233.26.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Yang Xin-Xin-r48390 <Xin-Xin.Yang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, Alexandre.Bounine@tundra.com,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-08-22 at 18:07 +0800, Zang Roy-r61911 wrote:
> The patch adds new hardware information table for mpic. This 
> enables mpic code to deal with mpic controller with 
> hardware behavior difference.

> +		TSI108_CPU_BASE,
> +		TSI108_CPU_STRIDE,
> +		TSI108_CPU_IPI_DISPATCH_0,
> +		TSI108_CPU_IPI_DISPATCH_STRIDE,
> +		TSI108_CPU_CURRENT_TASK_PRI,

This isn't actually enough to get SMP working on a Tsi109, as the Tsi109
mailbox and doorbell registers don't behave like standard MPIC IPIs.

So far I've experimented with a hack that uses the doorbell registers:
Doorbell 0 delivers IPI 0 to processor 0
Doorbell 1 delivers IPI 1 to processor 0
Doorbell 2 delivers IPI 0 to processor 1
Doorbell 3 delivers IPI 1 to processor 1

I don't support IPI 2 and IPI 3, though it would be possible to use the
mailbox registers in a similar scheme. This approach works, but I've not
worked out how to cleanly integrate this with the rest of the MPIC
driver, and won't have any time to do this in the near future.

-- 
Adrian Cox <adrian@humboldt.co.uk>
