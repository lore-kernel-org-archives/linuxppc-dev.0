Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0116.outbound.protection.outlook.com [65.55.169.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 21F321A056E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 08:58:06 +1100 (AEDT)
Message-ID: <1422395873.10544.61.camel@freescale.com>
Subject: Re: [PATCH v2] powerpc/mpic: Add DT option to skip readback after EOI
From: Scott Wood <scottwood@freescale.com>
To: Bogdan Purcareata <bogdan.purcareata@freescale.com>
Date: Tue, 27 Jan 2015 15:57:53 -0600
In-Reply-To: <1422371952-1126-1-git-send-email-bogdan.purcareata@freescale.com>
References: <1422371952-1126-1-git-send-email-bogdan.purcareata@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-01-27 at 15:19 +0000, Bogdan Purcareata wrote:
> The readback acts as a synchronization mechanism in handling external
> interrupts, making sure the core waits until EOI write completion. This is
> required in certain scenarios, such as when the MPIC communicates with a PCI
> device in posted write mode. If the device uses legacy interrupts, and the CPU
> returns from the interrupt as soon as it fires the EOI write, there is a chance
> to receive spurious interrupts because the line isn't deasserted yet.

The line was deasserted when IACK was read, before the EOI.  The issue
is (in theory at least) the timing of the write to the device versus the
write to EOI, not the timing of MPIC receiving the EOI versus when the
CPU executes rfi.

> +  - mpic-eoi-no-readback
> +      Usage: optional
> +      Value type: <empty>
> +      Definition: The presence of this property specifies that the
> +          MPIC will not issue a readback

s/will not/does not need to/

At this point, given the previous discussion, does anyone object to
removing the readback entirely?  Do we have any evidence that reading
WHOAMI is effective at addressing whatever problem reading EOI made go
away on the relevant platform?

>  when delivering the EOI for an
> +          external interrupt. The readback operation is done by reading
> +          the CPU WHOAMI register after writing to the CPU EOI register.
> +          Originally, this was required due to the fact that the MPIC
> +          operates at lower frequencies,

Why?

-Scott
