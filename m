Return-Path: <bhelgaas@google.com>
Received: from mail-oa0-f53.google.com (mail-oa0-f53.google.com
 [209.85.219.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4EEF72C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Apr 2013 02:38:54 +1000 (EST)
Received: by mail-oa0-f53.google.com with SMTP id m17so2719521oag.26
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 09:38:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1365685994-32603-3-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1365685994-32603-1-git-send-email-lucaskt@linux.vnet.ibm.com>
 <1365685994-32603-3-git-send-email-lucaskt@linux.vnet.ibm.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 12 Apr 2013 10:38:30 -0600
Message-ID: <CAErSpo7vxSJix83DQcsARPWYWbx8UGxQ9FN61OtEJrEv7GhK=g@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] radeon: use max_bus_speed to activate gen2 speeds
To: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Airlie <airlied@linux.ie>,
 DRI mailing list <dri-devel@lists.freedesktop.org>,
 Kleber Sacilotto de Souza <klebers@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jerome Glisse <jglisse@redhat.com>,
 Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 11, 2013 at 7:13 AM, Lucas Kannebley Tavares
<lucaskt@linux.vnet.ibm.com> wrote:
> radeon currently uses a drm function to get the speed capabilities for
> the bus. However, this is a non-standard method of performing this
> detection and this patch changes it to use the max_bus_speed attribute.
> ---
>  drivers/gpu/drm/radeon/evergreen.c |    9 ++-------
>  drivers/gpu/drm/radeon/r600.c      |    8 +-------
>  drivers/gpu/drm/radeon/rv770.c     |    8 +-------
>  3 files changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
> index 305a657..3291f62 100644
> --- a/drivers/gpu/drm/radeon/evergreen.c
> +++ b/drivers/gpu/drm/radeon/evergreen.c
> @@ -3855,8 +3855,7 @@ void evergreen_fini(struct radeon_device *rdev)
>
>  void evergreen_pcie_gen2_enable(struct radeon_device *rdev)
>  {
> -       u32 link_width_cntl, speed_cntl, mask;
> -       int ret;
> +       u32 link_width_cntl, speed_cntl;
>
>         if (radeon_pcie_gen2 == 0)
>                 return;
> @@ -3871,11 +3870,7 @@ void evergreen_pcie_gen2_enable(struct radeon_device *rdev)
>         if (ASIC_IS_X2(rdev))
>                 return;
>
> -       ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
> -       if (ret != 0)
> -               return;
> -
> -       if (!(mask & DRM_PCIE_SPEED_50))
> +       if (rdev->pdev->bus->max_bus_speed < PCIE_SPEED_5_0GT)

For devices on a root bus, we previously dereferenced a NULL pointer
in drm_pcie_get_speed_cap_mask() because pdev->bus->self is NULL on a
root bus.  (I think this is the original problem you tripped over,
Lucas.)

These patches fix that problem.  On pseries, where the device *is* on
a root bus, your patches set max_bus_speed so this will work as
expected.  On most other systems, max_bus_speed for root buses will be
PCI_SPEED_UNKNOWN (set in pci_alloc_bus() and never updated because
most arches don't have code like the pseries code you're adding).

PCI_SPEED_UNKNOWN = 0xff, so if we see another machine with a GPU on
the root bus, we'll attempt to enable Gen2 on the device even though
we have no idea what the bus will support.

That's why I originally suggested skipping the Gen2 stuff if
"max_bus_speed == PCI_SPEED_UNKNOWN".  I was just being conservative,
thinking that it's better to have a functional but slow GPU rather
than the unknown (to me) effects of enabling Gen2 on a link that might
not support it.  But I'm fine with this being either way.

It would be nice if we could get rid of drm_pcie_get_speed_cap_mask()
altogether.  It is exported, but I have no idea of anybody else uses
it.  Maybe it could at least be marked __deprecated now?

I don't know who should take these patches.  They don't touch
drivers/pci, but I'd be happy to push them, given the appropriate ACKs
from DRM and powerpc folks.

Bjorn

>                 return;
>
>         speed_cntl = RREG32_PCIE_P(PCIE_LC_SPEED_CNTL);
> diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
> index 0740db3..64b90c0 100644
> --- a/drivers/gpu/drm/radeon/r600.c
> +++ b/drivers/gpu/drm/radeon/r600.c
> @@ -4351,8 +4351,6 @@ static void r600_pcie_gen2_enable(struct radeon_device *rdev)
>  {
>         u32 link_width_cntl, lanes, speed_cntl, training_cntl, tmp;
>         u16 link_cntl2;
> -       u32 mask;
> -       int ret;
>
>         if (radeon_pcie_gen2 == 0)
>                 return;
> @@ -4371,11 +4369,7 @@ static void r600_pcie_gen2_enable(struct radeon_device *rdev)
>         if (rdev->family <= CHIP_R600)
>                 return;
>
> -       ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
> -       if (ret != 0)
> -               return;
> -
> -       if (!(mask & DRM_PCIE_SPEED_50))
> +       if (rdev->pdev->bus->max_bus_speed < PCIE_SPEED_5_0GT)
>                 return;
>
>         speed_cntl = RREG32_PCIE_P(PCIE_LC_SPEED_CNTL);
> diff --git a/drivers/gpu/drm/radeon/rv770.c b/drivers/gpu/drm/radeon/rv770.c
> index d63fe1d..c683c36 100644
> --- a/drivers/gpu/drm/radeon/rv770.c
> +++ b/drivers/gpu/drm/radeon/rv770.c
> @@ -1238,8 +1238,6 @@ static void rv770_pcie_gen2_enable(struct radeon_device *rdev)
>  {
>         u32 link_width_cntl, lanes, speed_cntl, tmp;
>         u16 link_cntl2;
> -       u32 mask;
> -       int ret;
>
>         if (radeon_pcie_gen2 == 0)
>                 return;
> @@ -1254,11 +1252,7 @@ static void rv770_pcie_gen2_enable(struct radeon_device *rdev)
>         if (ASIC_IS_X2(rdev))
>                 return;
>
> -       ret = drm_pcie_get_speed_cap_mask(rdev->ddev, &mask);
> -       if (ret != 0)
> -               return;
> -
> -       if (!(mask & DRM_PCIE_SPEED_50))
> +       if (rdev->pdev->bus->max_bus_speed < PCIE_SPEED_5_0GT)
>                 return;
>
>         DRM_INFO("enabling PCIE gen 2 link speeds, disable with radeon.pcie_gen2=0\n");
> --
> 1.7.4.4
>
