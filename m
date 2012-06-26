Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C92B8B6F5A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2012 08:24:23 +1000 (EST)
Message-ID: <4FEA3688.5030603@freescale.com>
Date: Tue, 26 Jun 2012 17:24:08 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>
Subject: Re: [RFC PATCH 13/17] PowerPC: booke64: Use SPRG0/3 scratch for bolted
 TLB miss & crit int
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-14-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1340627195-11544-14-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2012 07:26 AM, Mihai Caraman wrote:
> Embedded.Hypervisor category defines GSPRG0..3 physical registers for guests.
> Avoid SPRG4-7 usage as scratch in host exception handlers, otherwise guest
> SPRG4-7 registers will be clobbered.
> For bolted TLB miss exception handlers, which is the version currently
> supported by KVM, use SPRN_SPRG_GEN_SCRATCH (aka SPRG0) instead of
> SPRN_SPRG_TLB_SCRATCH (aka SPRG6) and replace TLB with GEN PACA slots to
> keep consitency.
> For critical exception handler use SPRG3 instead of SPRG7.

extlb is in the same cache line as other TLB stuff we need, while exgen
isn't.  Let's stick with extlb.

-Scott
