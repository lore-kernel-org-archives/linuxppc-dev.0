Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 6CCE01A017D
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Dec 2015 14:25:58 +1100 (AEDT)
Date: Sat, 05 Dec 2015 22:25:51 -0500 (EST)
Message-Id: <20151205.222551.512793392902323297.davem@davemloft.net>
To: tlfalcon@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, brking@linux.vnet.ibm.com, nguyendo@us.ibm.com,
 jallen@linux.vnet.ibm.com
Subject: Re: [PATCH net-next] Driver for IBM System i/p VNIC protocol
From: David Miller <davem@davemloft.net>
In-Reply-To: <1449251386-13476-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
References: <1449251386-13476-1-git-send-email-tlfalcon@linux.vnet.ibm.com>
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
Date: Fri,  4 Dec 2015 11:49:46 -0600

> +static int ibmvnic_buffs_per_pool = IBMVNIC_BUFFS_PER_POOL;
> +module_param(ibmvnic_buffs_per_pool, int, S_IRUGO);
> +MODULE_PARM_DESC(ibmvnic_buffs_per_pool,
> +		 "IBMVNIC number of buffers per rx pool");

Please do not use module parameters for settings that effect
the basic operation of the driver.

Instead use facilities that are generic and provide the same
user interface for all networking drivers, such as ethtool.

Otherwise users would need to learn a different way to configure the
same thing on different devices, which is not acceptable.
