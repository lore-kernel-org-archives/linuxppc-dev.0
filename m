Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C445D2C00B9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Dec 2013 20:59:19 +1100 (EST)
Date: Sat, 7 Dec 2013 10:59:16 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v6 16/17] powerpc/mpc512x: improve DIU related clock setup
Message-ID: <20131207105916.0d67f7f8@crub>
In-Reply-To: <1385851897-23475-17-git-send-email-gsi@denx.de>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-17-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 30 Nov 2013 23:51:36 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> adapt the DIU clock initialization to the COMMON_CLK approach:
> device tree based clock lookup, prepare and unprepare for clocks,
> work with frequencies not dividers, call the appropriate clk_*()
> routines and don't access CCM registers
> 
> the "best clock" determination now completely relies on the
> platform's clock driver to pick a frequency close to what the
> caller requests, and merely checks whether the desired frequency
> was met (fits the tolerance of the monitor)
> 
> this approach shall succeed upon first try in the usual case,
> will test a few less desirable yet acceptable frequencies in
> edge cases, and will fallback to "best effort" if none of the
> previously tried frequencies pass the test
> 
> provide a fallback clock lookup approach in case the OF based clock
> lookup for the DIU fails, this allows for successful operation in
> the presence of an outdated device tree which lacks clock specs
> 
> Cc: Anatolij Gustschin <agust@denx.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/platforms/512x/mpc512x_shared.c |  169 ++++++++++++++------------
>  1 file changed, 92 insertions(+), 77 deletions(-)

applied to next. Thanks!

Anatolij
