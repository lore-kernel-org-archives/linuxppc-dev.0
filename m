Return-Path: <bhelgaas@google.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6172F1A002C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Sep 2014 07:25:39 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id eu11so23103816pac.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Sep 2014 14:25:36 -0700 (PDT)
Date: Fri, 5 Sep 2014 15:25:28 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alexander Gordeev <agordeev@redhat.com>
Subject: Re: [PATCH 0/2] PCI/MSI: Remove arch_msi_check_device()
Message-ID: <20140905212528.GG8080@google.com>
References: <cover.1405160163.git.agordeev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1405160163.git.agordeev@redhat.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 12, 2014 at 01:21:06PM +0200, Alexander Gordeev wrote:
> Hello,
> 
> This is a cleanup effort to get rid of useless arch_msi_check_device().
> I am not sure what were the reasons for its existence in the first place,
> but at the moment it appears totally unnecessary.
> 
> Thanks!
> 
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-pci@vger.kernel.org
> 
> Alexander Gordeev (2):
>   PCI/MSI/PPC: Remove arch_msi_check_device()
>   PCI/MSI: Remove arch_msi_check_device()

I applied these (with Michael's ack on the first, and v2 of the second) to
pci/msi for v3.18, thanks!
> 
>  arch/powerpc/include/asm/machdep.h     |    2 -
>  arch/powerpc/kernel/msi.c              |   12 +-------
>  arch/powerpc/platforms/cell/axon_msi.c |    9 ------
>  arch/powerpc/platforms/powernv/pci.c   |   19 +++---------
>  arch/powerpc/platforms/pseries/msi.c   |   42
>  ++++++++++----------------- arch/powerpc/sysdev/fsl_msi.c          |
>  12 ++------ arch/powerpc/sysdev/mpic_pasemi_msi.c  |   11 +------
>  arch/powerpc/sysdev/mpic_u3msi.c       |   28 +++++++-----------
>  arch/powerpc/sysdev/ppc4xx_hsta_msi.c  |   18 ++++--------
>  arch/powerpc/sysdev/ppc4xx_msi.c       |   19 ++++--------
>  drivers/pci/msi.c                      |   49
>  ++++++++----------------------- include/linux/msi.h                    |
>  3 -- 12 files changed, 63 insertions(+), 161 deletions(-)
> 
> -- 1.7.7.6
> 
> -- To unsubscribe from this list: send the line "unsubscribe linux-pci"
> in the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html
