Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net
 [IPv6:2001:4f8:3:36:211:85ff:fe63:a549])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CC6F1A02B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 09:16:21 +1100 (AEDT)
Date: Tue, 24 Mar 2015 18:16:17 -0400 (EDT)
Message-Id: <20150324.181617.1094177939652695812.davem@davemloft.net>
To: sowmini.varadhan@oracle.com
Subject: Re: [PATCH v6 0/3] Generic IOMMU pooled allocator
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1427210772.git.sowmini.varadhan@oracle.com>
References: <cover.1427210772.git.sowmini.varadhan@oracle.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 24 Mar 2015 13:10:27 -0400

> Deltas from patchv5:
> - removed iommu_tbl_ops, and instead pass the ->flush_all as
>   an indirection to iommu_tbl_pool_init()
> - only invoke ->flush_all when there is no large_pool, based on
>   the assumption that large-pool usage is infrequently encountered.

Generally this looks fine to me.

But about patch #2, I see no reason to have multiple iommu_pool_hash
tables.  Even from a purely sparc perspective, we can always just do
with just one of them.

Furthermore, you can even probably move it down into lib/iommu-common.c
itself.  iommu_tbl_pool_init() can do the one time initialization.
