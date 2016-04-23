Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qsQYk474pzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Apr 2016 18:26:18 +1000 (AEST)
Message-ID: <1461399949.3135.52.camel@kernel.crashing.org>
Subject: Re: [PATCH V2] powerpc/infiniband: Use cache inhibitted and guarded
 mapping on powerpc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, Mike Marciniszyn
 <infinipath@intel.com>, Doug Ledford <dledford@redhat.com>, Sean Hefty
 <sean.hefty@intel.com>,
 Hal Rosenstock <hal.rosenstock@gmail.com>, linux-rdma@vger.kernel.org
Date: Sat, 23 Apr 2016 18:25:49 +1000
In-Reply-To: <20160422160927.GB12897@obsidianresearch.com>
References: <1461139097-10213-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1461278876.3135.18.camel@kernel.crashing.org>
 <20160422160927.GB12897@obsidianresearch.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-22 at 10:09 -0600, Jason Gunthorpe wrote:
> On Fri, Apr 22, 2016 at 08:47:56AM +1000, Benjamin Herrenschmidt
> wrote:
> > 
> > On Wed, 2016-04-20 at 03:58 -0400, Aneesh Kumar K.V wrote:
> > > 
> > > The driver was requesting for a writethrough mapping. But with
> > > thoses
> > > flags we will end up with a SAO mapping because we now have
> > > memory
> > > conherence always enabled. ie, the existing mapping will end up
> > > with
> > > a WIMG value 0b1110 which is Strong Access Order.
> > > 
> > > Update this to use cache inhibitted guarded mapping
> > Why guarded ? If it's performance sensitive (and the driver has
> > appropriate barriers where needed), you will get write combining
> > without guarded, you won't with it.
> This driver uses uncached write combining on x86

Right so if you want something similar on power, use the _wc variant,
and make sure you have the appropriate barriers when you need to
break combining.

Cheers,
Ben.
