Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 367C91A0008
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2015 13:43:59 +1100 (AEDT)
Message-ID: <1444185838.6794.3.camel@ellerman.id.au>
Subject: Re: [PATCH V4 0/6] Redesign SR-IOV on PowerNV
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 benh@kernel.crashing.org, linuxppc-dev@ozlabs.org
Date: Wed, 07 Oct 2015 13:43:58 +1100
In-Reply-To: <560E5761.4070803@ozlabs.ru>
References: <1439949704-8023-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <560E5761.4070803@ozlabs.ru>
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

On Fri, 2015-10-02 at 20:07 +1000, Alexey Kardashevskiy wrote:
> On 08/19/2015 12:01 PM, Wei Yang wrote:
> > In original design, it tries to group VFs to enable more number of VFs in the
> > system, when VF BAR is bigger than 64MB. This design has a flaw in which one
> > error on a VF will interfere other VFs in the same group.
> >
> > This patch series change this design by using M64 BAR in Single PE mode to
> > cover only one VF BAR. By doing so, it gives absolute isolation between VFs.
> >
> > Wei Yang (6):
> >    powerpc/powernv: don't enable SRIOV when VF BAR has non
> >      64bit-prefetchable BAR
> >    powerpc/powernv: simplify the calculation of iov resource alignment
> >    powerpc/powernv: use one M64 BAR in Single PE mode for one VF BAR
> >    powerpc/powernv: replace the hard coded boundary with gate
> >    powerpc/powernv: boundary the total VF BAR size instead of the
> >      individual one
> >    powerpc/powernv: allocate sparse PE# when using M64 BAR in Single PE
> >      mode
> >
> >   arch/powerpc/include/asm/pci-bridge.h     |    7 +-
> >   arch/powerpc/platforms/powernv/pci-ioda.c |  328 +++++++++++++++--------------
> >   2 files changed, 175 insertions(+), 160 deletions(-)
> 
> I have posted few comments but in general the patchset makes things simpler 
> by removing a compound PE and does not seem to make things worse so:
> 
> Acked-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Thanks for reviewing it.

I'll wait for a v5 that incorporates your comments.

cheers
