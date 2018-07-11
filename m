Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41QgzC03jMzF35J
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 00:13:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Klamt <eleon@ele0n.de>, benh@kernel.crashing.org
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kernel@i4.cs.fau.de,
 Daniel Klamt <eleon@ele0n.de>, Bjoern Noetel <bjoern@br3ak3r.de>
Subject: Re: [PATCH] powerpc: Replaced msleep with usleep_range
In-Reply-To: <1531144679-31675-1-git-send-email-eleon@ele0n.de>
References: <1531144679-31675-1-git-send-email-eleon@ele0n.de>
Date: Thu, 12 Jul 2018 00:13:39 +1000
Message-ID: <878t6hami4.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Daniel,

Daniel Klamt <eleon@ele0n.de> writes:
> Replaced msleep for less than 10ms with usleep_range because will
> often sleep longer than intended.
> For original explanation see:
> Documentation/timers/timers-howto.txt
>
> Signed-off-by: Daniel Klamt <eleon@ele0n.de>
> Signed-off-by: Bjoern Noetel <bjoern@br3ak3r.de>
> ---
>  arch/powerpc/sysdev/xive/native.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/powerpc/sysdev/xive/native.c b/arch/powerpc/sysdev/xive/native.c
> index 311185b9960a..b164b1cdf4d6 100644
> --- a/arch/powerpc/sysdev/xive/native.c
> +++ b/arch/powerpc/sysdev/xive/native.c
> @@ -109,7 +109,7 @@ int xive_native_configure_irq(u32 hw_irq, u32 target, u8 prio, u32 sw_irq)
>  		rc = opal_xive_set_irq_config(hw_irq, target, prio, sw_irq);
>  		if (rc != OPAL_BUSY)
>  			break;
> -		msleep(1);
> +		usleep_range(1000, 1100)
>  	}

We have actually recently added OPAL_BUSY_DELAY_MS (see opal.h) and
should convert these to use that. eg:

		msleep(OPAL_BUSY_DELAY_MS);


That has the effect of documenting that this is a short sleep to wait
for opal (our firmware), and we aren't concerned about rounding errors
in msleep().

If you send me a patch doing that I'd be happy to merge it.

cheers
