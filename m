Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tj4mP0dXHzDwMF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 02:37:24 +1100 (AEDT)
Date: Mon, 19 Dec 2016 10:37:12 -0500 (EST)
Message-Id: <20161219.103712.1578523196484939315.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, scott.wood@nxp.com, mpe@ellerman.id.au
Subject: Re: [PATCH net v2 2/5] powerpc: remove fsl,fman from of_device_ids[]
From: David Miller <davem@davemloft.net>
In-Reply-To: <1482139343-8975-3-git-send-email-madalin.bucur@nxp.com>
References: <1482139343-8975-1-git-send-email-madalin.bucur@nxp.com>
 <1482139343-8975-3-git-send-email-madalin.bucur@nxp.com>
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

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Mon, 19 Dec 2016 11:22:20 +0200

> The fsl/fman drivers will use of_platform_populate() on all
> supported platforms.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>

It seems that this creates a failure point between patches #2 and
#3.  If the cases handled by this "fsl,fman" entry are only afterwards
covered by the of_platform_populate() code added in patch #3 then you
cannot split these two changes up like this.

The two changes must be done at the same time, otherwise probing will
fail for some people between patches #2 and #3.
