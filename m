Return-Path: <alex.williamson@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHlk65WQ0zDrCt
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 05:37:18 +1000 (AEST)
Date: Wed, 26 Jul 2017 13:37:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] include/linux/vfio.h: Guard powerpc-specific
 functions with CONFIG_VFIO_SPAPR_EEH
Message-ID: <20170726133715.7cb039cb@w520.home>
In-Reply-To: <20170718172220.9954-1-mopsfelder@gmail.com>
References: <20170718172220.9954-1-mopsfelder@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 18 Jul 2017 14:22:20 -0300
Murilo Opsfelder Araujo <mopsfelder@gmail.com> wrote:

> When CONFIG_EEH=y and CONFIG_VFIO_SPAPR_EEH=n, build fails with the
> following:
> 
>     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_release':
>     vfio_pci.c:(.text+0xa98): undefined reference to `.vfio_spapr_pci_eeh_release'
>     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_open':
>     vfio_pci.c:(.text+0x1420): undefined reference to `.vfio_spapr_pci_eeh_open'
> 
> In this case, vfio_pci.c should use the empty definitions of
> vfio_spapr_pci_eeh_open and vfio_spapr_pci_eeh_release functions.
> 
> This patch fixes it by guarding these function definitions with
> CONFIG_VFIO_SPAPR_EEH, the symbol that controls whether vfio_spapr_eeh.c is
> built, which is where the non-empty versions of these functions are. We need to
> make use of IS_ENABLED() macro because CONFIG_VFIO_SPAPR_EEH is a tristate
> option.
> 
> This issue was found during a randconfig build. Logs are here:
> 
>     http://kisskb.ellerman.id.au/kisskb/buildresult/12982362/
> 
> Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
> ---

Applied to my for-linus branch with David and Alexey's R-b for v4.13.
Thanks,

Alex

> 
> Changes from v1:
> - Rebased on top of next-20170718.
> 
>  include/linux/vfio.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 586809a..a47b985 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -152,7 +152,7 @@ extern int vfio_set_irqs_validate_and_prepare(struct vfio_irq_set *hdr,
>  					      size_t *data_size);
> 
>  struct pci_dev;
> -#ifdef CONFIG_EEH
> +#if IS_ENABLED(CONFIG_VFIO_SPAPR_EEH)
>  extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
>  extern void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
>  extern long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
> @@ -173,7 +173,7 @@ static inline long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
>  {
>  	return -ENOTTY;
>  }
> -#endif /* CONFIG_EEH */
> +#endif /* CONFIG_VFIO_SPAPR_EEH */
> 
>  /*
>   * IRQfd - generic
> --
> 2.9.4
