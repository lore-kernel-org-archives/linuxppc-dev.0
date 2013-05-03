Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C73D72C00DD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 09:53:55 +1000 (EST)
Date: Fri, 3 May 2013 18:53:47 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] kvm/ppc/booke64: Hard disable interrupts when entering
 the guest
To: Scott Wood <scottwood@freescale.com>
References: <1367624723-22456-1-git-send-email-scottwood@freescale.com>
In-Reply-To: <1367624723-22456-1-git-send-email-scottwood@freescale.com>
 (from scottwood@freescale.com on Fri May  3 18:45:23 2013)
Message-ID: <1367625227.19391.16@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2013 06:45:23 PM, Scott Wood wrote:
> While we could just set PACA_IRQ_HARD_DIS after an exit to compensate,
> instead hard-disable interrupts before entering the guest.  This way,
> we won't have to worry about interactions if we take an interrupt
> during the guest entry code.  While I don't see any obvious
> interactions, it could change in the future (e.g. it would be bad if
> the non-hv code were used on 64-bit or if 32-bit guest lazy interrupt
> disabling, since the non-hv code changes IVPR among other things).

s/32-bit guest lazy/32-bit gets lazy/

-Scott=
