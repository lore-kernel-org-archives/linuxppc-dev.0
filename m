Return-Path: <VDavydov@odin.com>
Received: from relay.parallels.com (relay.parallels.com [195.214.232.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2918A1A1760
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 22:05:20 +1000 (AEST)
Date: Mon, 14 Sep 2015 15:04:55 +0300
From: Vladimir Davydov <vdavydov@parallels.com>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
CC: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <anton@samba.org>, <akpm@linux-foundation.org>, <nacc@linux.vnet.ibm.com>,
 <gkurz@linux.vnet.ibm.com>, <zhong@linux.vnet.ibm.com>,
 <grant.likely@linaro.org>, <nikunj@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] mm: Replace nr_node_ids for loop with for_each_node
 in list lru
Message-ID: <20150914120455.GD30743@esperanza>
References: <1441737107-23103-1-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <1441737107-23103-2-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
 <20150914090010.GB30743@esperanza>
 <55F6B1F3.1010702@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <55F6B1F3.1010702@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 14, 2015 at 05:09:31PM +0530, Raghavendra K T wrote:
> On 09/14/2015 02:30 PM, Vladimir Davydov wrote:
> >On Wed, Sep 09, 2015 at 12:01:46AM +0530, Raghavendra K T wrote:
> >>The functions used in the patch are in slowpath, which gets called
> >>whenever alloc_super is called during mounts.
> >>
> >>Though this should not make difference for the architectures with
> >>sequential numa node ids, for the powerpc which can potentially have
> >>sparse node ids (for e.g., 4 node system having numa ids, 0,1,16,17
> >>is common), this patch saves some unnecessary allocations for
> >>non existing numa nodes.
> >>
> >>Even without that saving, perhaps patch makes code more readable.
> >
> >Do I understand correctly that node 0 must always be in
> >node_possible_map? I ask, because we currently test
> >lru->node[0].memcg_lrus to determine if the list is memcg aware.
> >
> 
> Yes, node 0 is always there. So it should not be a problem.

I think it should be mentioned in the comment to list_lru_memcg_aware
then.

Thanks,
Vladimir
