Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B2EAFB6F72
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2011 05:44:59 +1100 (EST)
Received: from mail111-am1 (localhost.localdomain [127.0.0.1])	by
 mail111-am1-R.bigfish.com (Postfix) with ESMTP id 1A1388B0188	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2011 18:44:45 +0000 (UTC)
Received: from AM1EHSMHS013.bigfish.com (unknown [10.3.201.250])	by
 mail111-am1.bigfish.com (Postfix) with ESMTP id 3B9041500053	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2011 18:43:56 +0000 (UTC)
Message-ID: <4EB826F1.50402@freescale.com>
Date: Mon, 7 Nov 2011 12:44:01 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH] powerpc/p1023: set IRQ[4:6, 11] to high level sensitive
 for PCIe
References: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
In-Reply-To: <1320654778-3294-1-git-send-email-tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/07/2011 02:32 AM, Roy Zang wrote:
> P1023 external IRQ[4:6, 11] do not pin out, but the interrupts are
> shared with PCIe controller.
> The silicon internally ties the interrupts to L, so change the
> IRQ[4:6,11] to high level sensitive for PCIe.

Some extra commentary on why this works would be nice.

The manual says:

> If a PCI Express INTx interrupt is being used, then the PIC must be configured so that external interrupts
> are level-sensitive (EIVPRn[S] = 1).

and

> In general, these signals should be considered mutually exclusive. If a PCI Express INTx signal is being
> used, the PIC must be configured so that external interrupts are level sensitive (EIVPRn[S] = 1). If an IRQn
> signal is being used as edge-triggered (EIVPRn[S] = 0), the system must not allow inbound PCI Express
> INTx transactions.
>
> Note that it is possible to share IRQn and INTx if the external interrupt is level sensitive; however, if an
> interrupt occurs, the interrupt service routine must poll both the external sources connected to the IRQn
> input and the PCI Express INTx sources to determine from which path the external interrupt came. In any
> case, IRQn should be pulled to the negated state as determined by the associated polarity setting in
> EIVPRn[P].

So it looks like there's some magic whereby the configuration of the
MPIC affects how the PCIe feeds the interrupt in.

Is there (or will there be) an erratum, or anything in the manual
besides not being documented as external interrupts, about these
specific interrupts being tied low in silicon or needing to be active high?

-Scott
