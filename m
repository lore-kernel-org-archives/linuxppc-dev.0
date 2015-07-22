Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id E92541A1A2C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2015 15:26:52 +1000 (AEST)
Date: Tue, 21 Jul 2015 22:26:48 -0700 (PDT)
Message-Id: <20150721.222648.171655319967229139.davem@davemloft.net>
To: chris.j.arges@canonical.com
Cc: nacc@linux.vnet.ibm.com, pshelar@nicira.com,
 linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 linux-numa@vger.kernel.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] openvswitch: allocate nr_node_ids flow_stats
 instead of num_possible_nodes
From: David Miller <davem@davemloft.net>
In-Reply-To: <1437500193-10255-1-git-send-email-chris.j.arges@canonical.com>
References: <20150721162418.GM38815@linux.vnet.ibm.com>
 <1437500193-10255-1-git-send-email-chris.j.arges@canonical.com>
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

From: Chris J Arges <chris.j.arges@canonical.com>
Date: Tue, 21 Jul 2015 12:36:33 -0500

> Some architectures like POWER can have a NUMA node_possible_map that
> contains sparse entries. This causes memory corruption with openvswitch
> since it allocates flow_cache with a multiple of num_possible_nodes() and
> assumes the node variable returned by for_each_node will index into
> flow->stats[node].
> 
> Use nr_node_ids to allocate a maximal sparse array instead of
> num_possible_nodes().
> 
> The crash was noticed after 3af229f2 was applied as it changed the
> node_possible_map to match node_online_map on boot.
> Fixes: 3af229f2071f5b5cb31664be6109561fbe19c861
> 
> Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>

Applied, thanks.
