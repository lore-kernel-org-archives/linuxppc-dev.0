Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0119.hostedemail.com
 [216.40.44.119])
 by lists.ozlabs.org (Postfix) with ESMTP id 98C5A1A03DB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 07:39:55 +1100 (AEDT)
Message-ID: <1446496788.24485.69.camel@perches.com>
Subject: Re: [net-next v4 6/8] dpaa_eth: add ethtool statistics
From: Joe Perches <joe@perches.com>
To: madalin.bucur@freescale.com
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, scottwood@freescale.com,
 igal.liberman@freescale.com, roy.pledge@freescale.com,
 ppc@mindchasers.com,  pebolle@tiscali.nl, joakim.tjernlund@transmode.se,
 gregkh@linuxfoundation.org,  Ioana Ciornei <ioana.ciornei@freescale.com>
Date: Mon, 02 Nov 2015 12:39:48 -0800
In-Reply-To: <1446485500-9782-7-git-send-email-madalin.bucur@freescale.com>
References: <1446485500-9782-1-git-send-email-madalin.bucur@freescale.com>
 <1446485500-9782-7-git-send-email-madalin.bucur@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-11-02 at 19:31 +0200, Madalin Bucur wrote:
> Add a series of counters to be exported through ethtool:
> - add detailed counters for reception errors;
> - add detailed counters for QMan enqueue reject events;
> - count the number of fragmented skbs received from the stack;
> - count all frames received on the Tx confirmation path;
> - add congestion group statistics;
> - count the number of interrupts for each CPU.
[]
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
[]
> +static void dpa_get_strings(struct net_device *net_dev, u32 stringset, u8 *data)
> +{
> +	unsigned int i, j, num_cpus, size;
> +	char string_cpu[ETH_GSTRING_LEN];
> +	u8 *strings;
> +
> +	strings   = data;
> +	num_cpus  = num_online_cpus();
> +	size      = DPA_STATS_GLOBAL_LEN * ETH_GSTRING_LEN;
> +
> +	for (i = 0; i < DPA_STATS_PERCPU_LEN; i++) {
> +		for (j = 0; j < num_cpus; j++) {
> +			snprintf(string_cpu, ETH_GSTRING_LEN, "%s [CPU %d]",
> +				 dpa_stats_percpu[i], j);
> +			memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> +			strings += ETH_GSTRING_LEN;
> +		}
> +		snprintf(string_cpu, ETH_GSTRING_LEN, "%s [TOTAL]",
> +			 dpa_stats_percpu[i]);
> +		memcpy(strings, string_cpu, ETH_GSTRING_LEN);
> +		strings += ETH_GSTRING_LEN;
> +	}
> +	memcpy(strings, dpa_stats_global, size);
> +}

This leaks uninitialized stack via a memcpy of uninitialized
string_cpu bytes into user-space.

Using
	char string_cpu[ETH_GSTRING_LEN] = {};
or a memset before each snprintf would fix it.
