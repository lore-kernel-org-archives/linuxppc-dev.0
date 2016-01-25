Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id D808B1A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 05:47:31 +1100 (AEDT)
Date: Mon, 25 Jan 2016 10:47:28 -0800 (PST)
Message-Id: <20160125.104728.1314622892837934779.davem@davemloft.net>
To: martin.roth@motorolasolutions.com
Cc: pantelis.antoniou@gmail.com, vbordug@ru.mvista.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] 82xx: FCC: Fixing a bug causing to FCC port lock-up
 (second try)
From: David Miller <davem@davemloft.net>
In-Reply-To: <1453589779-13187-1-git-send-email-martin.roth@motorolasolutions.com>
References: <1453589779-13187-1-git-send-email-martin.roth@motorolasolutions.com>
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

From: Martin Roth <martin.roth@motorolasolutions.com>
Date: Sun, 24 Jan 2016 00:56:19 +0200

> This is an additional patch to the one already submitted recently.
> The previous patch was not complete, and the FCC port lock-up scenario
> has been reproduced in lab.
> I had an opportunity to check the current patch in lab and the FCC
> port lock no longer freezes, while the previous patch still locks-up the
> FCC port.
> The current patch fixes a pointer arithmetic bug (second bug in the same
> line), which leads FCC port lock-up during underrun/collision handling.
> Within the tx_startup() function in mac-fcc.c, the address of last BD is
> not calculated correctly. As a result of wrong calculation of the last BD
> address, the next transmitted BD may be set to an area out of the transmit
> BD ring. This actually causes to port lock-up and it is not recoverable.
> 
> Signed-off-by: Martin Roth <martin.roth@motorolasolutions.com>

Applied, thank you.
