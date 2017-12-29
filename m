Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z7JlC32HzzDqlN
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 18:54:30 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
 Logan Gunthorpe <logang@deltatee.com>, Michal Hocko <mhocko@kernel.org>,
 linux-nvdimm@lists.01.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: revamp vmem_altmap / dev_pagemap handling V3
Date: Fri, 29 Dec 2017 08:53:49 +0100
Message-Id: <20171229075406.1936-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

this series started with two patches from Logan that now are in the
middle of the series to kill the memremap-internal pgmap structure
and to redo the dev_memreamp_pages interface to be better suitable
for future PCI P2P uses.  I reviewed them and noticed that there
isn't really any good reason to keep struct vmem_altmap either,
and that a lot of these alternative device page map access should
be better abstracted out instead of being sprinkled all over the
mm code.  But when we got the RCU warnings in V1 I went for yet
another approach, and now struct vmem_altmap is kept for now,
but passed explicitly through the memory hotplug code instead of
having to do unprotected lookups through the radix tree.  The
end result is that only the get_user_pages path ever looks up
struct dev_pagemap, and struct vmem_altmap is now always embedded
into struct dev_pagemap, and explicitly passed where needed.

Please review carefully, this has only been tested with my legacy
e820 NVDIMM system.

Chances since V2:
 - properly pass altmap from dev_devm_memremap_pages through add_pages
   (Dan Williams)
 - small changelog updates
 - a comment type fix
 - dropped the patch to just rely on the radix_tree_insert return value
 - initialize pgmap->type
