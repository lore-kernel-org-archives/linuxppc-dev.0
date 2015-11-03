Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 2350A1A03BE
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 15:17:55 +1100 (AEDT)
Date: Mon, 02 Nov 2015 23:17:50 -0500 (EST)
Message-Id: <20151102.231750.1882562463767220834.davem@davemloft.net>
To: igal.liberman@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scottwood@freescale.com,
 madalin.bucur@freescale.com, pebolle@tiscali.nl,
 joakim.tjernlund@transmode.se, ppc@mindchasers.com,
 stephen@networkplumber.org
Subject: Re: [v7, 2/6] fsl/fman: Add FMan support
From: David Miller <davem@davemloft.net>
In-Reply-To: <1446467416-15992-3-git-send-email-igal.liberman@freescale.com>
References: <1446467416-15992-1-git-send-email-igal.liberman@freescale.com>
 <1446467416-15992-3-git-send-email-igal.liberman@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: <igal.liberman@freescale.com>
Date: Mon, 2 Nov 2015 14:30:12 +0200

> +static int clear_iram(struct fman *fman)
> +{
> +	struct fman_iram_regs __iomem *iram;
> +	int i, count;
> +
> +	iram = (struct fman_iram_regs __iomem *)(fman->base_addr + IMEM_OFFSET);

"fman->base_addr" is of type "void __iomem *", therefore no cast should
be necessary at all.

Please audit your entire driver submission for this problem.

THanks.
