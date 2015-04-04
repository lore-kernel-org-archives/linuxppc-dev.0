Return-Path: <sowmini.varadhan@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 825E41A0AC8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Apr 2015 22:27:34 +1100 (AEDT)
Date: Sat, 4 Apr 2015 07:27:14 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 1/3] sparc: Break up monolithic iommu table/lock
 into finer graularity pools and lock
Message-ID: <20150404112714.GA2117@oracle.com>
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>
 <8406d119fb885255387a400551de994cb4a4c331.1427761300.git.sowmini.varadhan@oracle.com>
 <1428008044.20500.272.camel@kernel.crashing.org>
 <20150403182852.GI26158@oracle.com>
 <1428095210.20500.291.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428095210.20500.291.camel@kernel.crashing.org>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

One last question before I spin out v9.. the dma_mask code
is a bit confusing to me, so I want to make sure... the code is 

> if (limit + tbl->it_offset > mask) {
>               limit = mask - tbl->it_offset + 1;
>               /* If we're constrained on address range, first try
>                * at the masked hint to avoid O(n) search complexity,
>                * but on second pass, start at 0 in pool 0.
>                */
>               if ((start & mask) >= limit || pass > 0) {
>                       spin_unlock(&(pool->lock));
>                       pool = &(tbl->pools[0]);
>                       spin_lock(&(pool->lock));
>                       start = pool->start;

So here I would need to mark need_flush to true, right?


--Sowmini
