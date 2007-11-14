Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id BC3E4DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Nov 2007 16:18:32 +1100 (EST)
Date: Tue, 13 Nov 2007 21:09:26 -0800 (PST)
Message-Id: <20071113.210926.97725854.davem@davemloft.net>
To: jochen@scram.de
Subject: Re: [PATCH] powerpc: Fix fs_enet module build
From: David Miller <davem@davemloft.net>
In-Reply-To: <4739EDA8.6020800@scram.de>
References: <4739EDA8.6020800@scram.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-embedded@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Jochen Friedrich <jochen@scram.de>
Date: Tue, 13 Nov 2007 19:32:08 +0100

> If fs_enet is build as module, on PPC_CPM_NEW_BINDING platforms
> mii-fec/mii-bitbang should be build as module, as well. On other
> platforms, mii-fec/mii-bitbang must be included into the main module.
> Otherwise some symbols remain undefined. Additionally, fs_enet uses
> libphy, so add a select PHYLIB.
> 
>   Building modules, stage 2.
>   MODPOST 5 modules
> ERROR: "fs_scc_ops" [drivers/net/fs_enet/fs_enet.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> Signed-off-by: Jochen Friedrich <jochen@scram.de>

This is truly ugly and creates an unnecessarily hard to
maintain and complex driver.

Please find a way to fix this for real, so that the
PPC_CPM_NEW_BINDING ifdef is not necessary at all and
things get built modular or not naturally as we handle
things for other cases like this.

THanks.
