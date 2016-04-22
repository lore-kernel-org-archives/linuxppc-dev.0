Return-Path: <jgunthorpe@obsidianresearch.com>
Received: from quartz.orcorp.ca (quartz.orcorp.ca [184.70.90.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qs1cs1QcGzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 02:42:37 +1000 (AEST)
Date: Fri, 22 Apr 2016 10:09:27 -0600
From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 Mike Marciniszyn <infinipath@intel.com>,
 Doug Ledford <dledford@redhat.com>, Sean Hefty <sean.hefty@intel.com>,
 Hal Rosenstock <hal.rosenstock@gmail.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH V2] powerpc/infiniband: Use cache inhibitted and guarded
 mapping on powerpc
Message-ID: <20160422160927.GB12897@obsidianresearch.com>
References: <1461139097-10213-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461278876.3135.18.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461278876.3135.18.camel@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 22, 2016 at 08:47:56AM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2016-04-20 at 03:58 -0400, Aneesh Kumar K.V wrote:
> > The driver was requesting for a writethrough mapping. But with thoses
> > flags we will end up with a SAO mapping because we now have memory
> > conherence always enabled. ie, the existing mapping will end up with
> > a WIMG value 0b1110 which is Strong Access Order.
> > 
> > Update this to use cache inhibitted guarded mapping
> 
> Why guarded ? If it's performance sensitive (and the driver has
> appropriate barriers where needed), you will get write combining
> without guarded, you won't with it.

This driver uses uncached write combining on x86

Jason
