Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Psg75cmnzF1sZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 01:26:41 +1000 (AEST)
Date: Mon, 16 Apr 2018 11:26:36 -0400 (EDT)
Message-Id: <20180416.112636.639759764864229205.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 jallen@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 benh@kernel.crashing.org
Subject: Re: [PATCH] ibmvnic: Clear pending interrupt after device reset
From: David Miller <davem@davemloft.net>
In-Reply-To: <1523836416-16531-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1523836416-16531-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
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

From: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Date: Sun, 15 Apr 2018 18:53:36 -0500

> Due to a firmware bug, the hypervisor can send an interrupt to a
> transmit or receive queue just prior to a partition migration, not
> allowing the device enough time to handle it and send an EOI. When
> the partition migrates, the interrupt is lost but an "EOI-pending"
> flag for the interrupt line is still set in firmware. No further
> interrupts will be sent until that flag is cleared, effectively
> freezing that queue. To workaround this, the driver will disable the
> hardware interrupt and send an H_EOI signal prior to re-enabling it.
> This will flush the pending EOI and allow the driver to continue
> operation.
> 
> Signed-off-by: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>

Applied, thanks Thomas.
