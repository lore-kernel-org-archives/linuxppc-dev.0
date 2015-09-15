Return-Path: <VDavydov@odin.com>
Received: from relay.parallels.com (relay.parallels.com [195.214.232.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CF0231A2C31
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 17:59:50 +1000 (AEST)
Date: Tue, 15 Sep 2015 10:59:24 +0300
From: Vladimir Davydov <vdavydov@parallels.com>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
CC: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <anton@samba.org>, <akpm@linux-foundation.org>, <nacc@linux.vnet.ibm.com>,
 <gkurz@linux.vnet.ibm.com>, <grant.likely@linaro.org>,
 <nikunj@linux.vnet.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH V2  1/2] mm: Replace nr_node_ids for loop with
 for_each_node in list lru
Message-ID: <20150915075924.GD16220@esperanza>
References: <1442282917-16893-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1442282917-16893-2-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1442282917-16893-2-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 15, 2015 at 07:38:36AM +0530, Raghavendra K T wrote:
> The functions used in the patch are in slowpath, which gets called
> whenever alloc_super is called during mounts.
> 
> Though this should not make difference for the architectures with
> sequential numa node ids, for the powerpc which can potentially have
> sparse node ids (for e.g., 4 node system having numa ids, 0,1,16,17
> is common), this patch saves some unnecessary allocations for
> non existing numa nodes.
> 
> Even without that saving, perhaps patch makes code more readable.
> 
> [ Take memcg_aware check outside for_each loop: Vldimir]
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>

Reviewed-by: Vladimir Davydov <vdavydov@parallels.com>
