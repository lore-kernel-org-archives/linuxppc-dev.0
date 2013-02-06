Return-Path: <R1AAHA@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe002.messaging.microsoft.com [216.32.180.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF82F2C02CC
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Feb 2013 14:14:16 +1100 (EST)
Date: Tue, 5 Feb 2013 21:11:27 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/3] powerpc/mpc512x: fix noderef sparse warnings
Message-ID: <20130205211127.63493c48f787fe91dce1517a@freescale.com>
In-Reply-To: <1360048818-3765-1-git-send-email-agust@denx.de>
References: <1360048818-3765-1-git-send-email-agust@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 5 Feb 2013 08:20:16 +0100
Anatolij Gustschin <agust@denx.de> wrote:

> Fix:
> warning: dereference of noderef expression
> 
> Signed-off-by: Anatolij Gustschin <agust@denx.de>
> ---
>  arch/powerpc/platforms/512x/clock.c |   18 +++++++++---------
>  1 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platforms/512x/clock.c
> index 7937361..8a784d4 100644
> --- a/arch/powerpc/platforms/512x/clock.c
> +++ b/arch/powerpc/platforms/512x/clock.c
> @@ -184,7 +184,7 @@ static unsigned long spmf_mult(void)
>  		36, 40, 44, 48,
>  		52, 56, 60, 64
>  	};
> -	int spmf = (clockctl->spmr >> 24) & 0xf;
> +	int spmf = (in_be32(&clockctl->spmr) >> 24) & 0xf;

power arch should start using the more portable i/o accessors
io{read,write}32be instead of the arch-centric {in,out}_be32.  The
io{read,write}32be functions have better sparse annotation, so an
endian check will complain if registers are not defined __be32.

Kim
