Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6YdD27lFzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 15:30:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bjorn Helgaas <bhelgaas@google.com>, Yongji Xie <elohimes@gmail.com>
Cc: zhong@linux.vnet.ibm.com, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-pci@vger.kernel.org, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v11 4/7] powerpc/powernv: Override
 pcibios_default_alignment() to force PCI devices to be page aligned
In-Reply-To: <20170417213653.21092.27784.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170417212705.21092.90222.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170417213653.21092.27784.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 18 Apr 2017 15:30:55 +1000
Message-ID: <87vaq2704w.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Bjorn Helgaas <bhelgaas@google.com> writes:

> From: Yongji Xie <elohimes@gmail.com>
>
> This overrides pcibios_default_alignment() to set default alignment
> to PAGE_SIZE for all PCI devices on PowerNV platform. Thus sub-page
> BARs would not share a page and could be mapped into guest when VFIO
> passthrough them.
>
> Signed-off-by: Yongji Xie <elohimes@gmail.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/powerpc/include/asm/machdep.h        |    2 ++
>  arch/powerpc/kernel/pci-common.c          |    8 ++++++++
>  arch/powerpc/platforms/powernv/pci-ioda.c |    7 +++++++

This looks fine to me, here's an ack, but don't feel you have to rebase
to add it:

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
