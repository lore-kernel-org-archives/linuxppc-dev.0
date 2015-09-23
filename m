Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0110.outbound.protection.outlook.com [65.55.169.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BDA41A001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2015 14:06:25 +1000 (AEST)
Message-ID: <1442981170.19102.322.camel@freescale.com>
Subject: Re: [PATCH 04/17] powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead
 of redundant mpic_irq_set_wake
From: Scott Wood <scottwood@freescale.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Thomas
 Gleixner" <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Hongtao Jia
 <hongtao.jia@freescale.com>, Marc Zyngier <marc.zyngier@arm.com>,
 <linuxppc-dev@lists.ozlabs.org>, Wang Dongsheng-B40534
 <Dongsheng.Wang@freescale.com>
Date: Tue, 22 Sep 2015 23:06:10 -0500
In-Reply-To: <1442850433-5903-5-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
 <1442850433-5903-5-git-send-email-sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-09-21 at 16:47 +0100, Sudeep Holla wrote:
> mpic_irq_set_wake return -ENXIO for non FSL MPIC and sets IRQF_NO_SUSPEND
> flag for FSL ones. enable_irq_wake already returns -ENXIO if irq_set_wak
> is not implemented. Also there's no need to set the IRQF_NO_SUSPEND flag
> as it doesn't guarantee wakeup for that interrupt.
> 
> This patch removes the redundant mpic_irq_set_wake and sets the
> IRQCHIP_SKIP_SET_WAKE for only FSL MPIC.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Hongtao Jia <hongtao.jia@freescale.com>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/powerpc/sysdev/mpic.c | 23 ++++-------------------
>  1 file changed, 4 insertions(+), 19 deletions(-)

Acked-by: Scott Wood <scottwood@freescale.com>

-Scott
