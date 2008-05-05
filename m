Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9FB59DE091
	for <linuxppc-dev@ozlabs.org>; Tue,  6 May 2008 04:00:39 +1000 (EST)
In-Reply-To: <1209973634-1699-4-git-send-email-Jason.jin@freescale.com>
References: <1209973634-1699-1-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-2-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-3-git-send-email-Jason.jin@freescale.com>
	<1209973634-1699-4-git-send-email-Jason.jin@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <79f7e810cc79d5912587296c4f44b419@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/4] booting-without-of for Freescale MSI
Date: Mon, 5 May 2008 20:00:22 +0200
To: Jason Jin <Jason.jin@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +    - compatible : should be "fsl,MPIC-MSI" for 85xx/86xx cpu,
> +      and "fsl,IPIC-MSI" for 83xx cpu.

Please use a more specific name, "fsl,8599-msi" or similar?

> +    - interrupts : should contain the msi interrupts cascade to the 
> host
> +      interrupt controller.

You should describe that it is one "interrupts" entry per 32 MSIs;
also, it would be nice to say they need "0" as the sense.

> +    - interrupt-parent: should be "&mpic" for 85xx/86xx cpu and 
> "&ipic"
> +      for 83xx cpu.

&Xpic are labels, so something local to specific DTS files; instead, say
that the interrupts are routed to the MPIC/IPIC (it doesn't have to be
via "interrupt-parent", either).


Segher

p.s. On a meta-note, please put the binding doc first in the series, it
makes things easier to review in-order.
