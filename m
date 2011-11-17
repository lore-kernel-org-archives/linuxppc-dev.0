Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id CA7A3B7266
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2011 08:33:13 +1100 (EST)
Date: Thu, 17 Nov 2011 15:33:07 -0600
From: Scott Wood <scottwood@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 3/6] powerpc/85xx: separate MPIC handling code
Message-ID: <20111117213307.GB14736@schlenkerla.am.freescale.net>
References: <1321552581-29773-1-git-send-email-dbaryshkov@gmail.com>
 <1321552581-29773-3-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1321552581-29773-3-git-send-email-dbaryshkov@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 17, 2011 at 09:56:18PM +0400, Dmitry Eremin-Solenikov wrote:
> All mpc85xx boards deal with MPIC initialization in more or less the
> same way. The only difrerences are some flags (WANTS_RESET,
> BROKEN_FRR_NIRQS, SINGLE_DEST_CPU), and some bugs like leaking device
> node counter, etc. To minimize problems, switch all boards to use one
> single instance of code.

SINGLE_DEST_CPU should apply to all 85xx (the boards that omit it are
probably non-SMP where it doesn't matter), and probably BROKEN_FRR_NIRQS
as well (shouldn't hurt, at least).

> +	mpc85xx_init_mpic(0, 1, 1);

This is awkward to read, named flags are better -- and already exist for
this. :-)

Something like this should be clearer and still allow any override the
board wishes (such as for 85xx CAMP):

#define MPC85XX_MPIC_FLAGS (...)

most_boards:

mpc85xx_init_mpic(MPC85XX_MPIC_FLAGS)

85xx CAMP:

mpc85xx_init_mpic(MPC85XX_MPIC_FLAGS & ~MPIC_WANTS_RESET);

-Scott
