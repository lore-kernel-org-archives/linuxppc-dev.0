Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [184.105.139.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yTfbg22fQzDrF3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Nov 2017 00:21:16 +1100 (AEDT)
Date: Sat, 04 Nov 2017 22:21:07 +0900 (KST)
Message-Id: <20171104.222107.1124370080560433601.davem@davemloft.net>
To: desnesn@linux.vnet.ibm.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 tlfalcon@linux.vnet.ibm.com, nfont@linux.vnet.ibm.com,
 jallen@linux.vnet.ibm.com
Subject: Re: [PATCH] [net-next,v2] ibmvnic: Feature implementation of Vital
 Product Data (VPD) for the ibmvnic driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20171101210332.7278-1-desnesn@linux.vnet.ibm.com>
References: <20171101210332.7278-1-desnesn@linux.vnet.ibm.com>
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

From: Desnes Augusto Nunes do Rosario <desnesn@linux.vnet.ibm.com>
Date: Wed,  1 Nov 2017 19:03:32 -0200

> +	substr = strnstr(adapter->vpd->buff, "RM", adapter->vpd->len);
> +	if (!substr) {
> +		dev_info(dev, "No FW level provided by VPD\n");
> +		complete(&adapter->fw_done);
> +		return;
> +	}
> +
> +	/* get length of firmware level ASCII substring */
> +	fw_level_len = *(substr + 2);
> +
> +	/* copy firmware version string from vpd into adapter */
> +	ptr = strncpy((char *)adapter->fw_version,
> +		      substr + 3, fw_level_len);

You have to be more careful here, making sure first that
(substr + 2) < (adapter->vpd->buff + adapter->vpd->len),
and next that (substr + 2 + fw_level_len) is in range
as well.
