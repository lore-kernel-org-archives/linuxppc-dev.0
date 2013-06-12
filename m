Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0F8602C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 13:14:56 +1000 (EST)
Message-ID: <1371006871.8250.168.camel@pasglop>
Subject: Re: [PATCH 0/4 v3] KVM: PPC: IOMMU in-kernel handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 12 Jun 2013 13:14:31 +1000
In-Reply-To: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Alexander Graf <agraf@suse.de>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-05 at 16:11 +1000, Alexey Kardashevskiy wrote:
> Ben, ping! :)
> 
> This series has tiny fixes (capability and ioctl numbers,
> changed documentation, compile errors in some configuration).
> More details are in the commit messages.
> Rebased on v3.10-rc4.

Alex, I assume you'll merge that once I ack it ?

Cheers,
Ben.

> 
> Alexey Kardashevskiy (4):
>   KVM: PPC: Add support for multiple-TCE hcalls
>   powerpc: Prepare to support kernel handling of IOMMU map/unmap
>   KVM: PPC: Add support for IOMMU in-kernel handling
>   KVM: PPC: Add hugepage support for IOMMU in-kernel handling
> 
>  Documentation/virtual/kvm/api.txt        |   45 +++
>  arch/powerpc/include/asm/kvm_host.h      |    7 +
>  arch/powerpc/include/asm/kvm_ppc.h       |   40 ++-
>  arch/powerpc/include/asm/pgtable-ppc64.h |    4 +
>  arch/powerpc/include/uapi/asm/kvm.h      |    7 +
>  arch/powerpc/kvm/book3s_64_vio.c         |  398 ++++++++++++++++++++++++-
>  arch/powerpc/kvm/book3s_64_vio_hv.c      |  471 ++++++++++++++++++++++++++++--
>  arch/powerpc/kvm/book3s_hv.c             |   39 +++
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S  |    6 +
>  arch/powerpc/kvm/book3s_pr_papr.c        |   37 ++-
>  arch/powerpc/kvm/powerpc.c               |   15 +
>  arch/powerpc/mm/init_64.c                |   77 ++++-
>  include/uapi/linux/kvm.h                 |    3 +
>  13 files changed, 1121 insertions(+), 28 deletions(-)
> 
