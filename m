Return-Path: <j.glisse@gmail.com>
Received: from mail-qc0-x232.google.com (mail-qc0-x232.google.com
 [IPv6:2607:f8b0:400d:c01::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 839B72C00B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 02:34:59 +1100 (EST)
Received: by mail-qc0-f178.google.com with SMTP id d10so216570qca.23
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2013 08:34:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
References: <1363757079-23550-1-git-send-email-lucaskt@linux.vnet.ibm.com>
Date: Wed, 20 Mar 2013 11:34:54 -0400
Message-ID: <CAH3drwa-bM4pOzu7QPPAm7nNVNPNAKDUzjtLb5xr2kHQW=LAwQ@mail.gmail.com>
Subject: Re: [PATCHv2 0/3] PCI Speed Cap Fixes for ppc64
From: Jerome Glisse <j.glisse@gmail.com>
To: Lucas Kannebley Tavares <lucaskt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Thadeu Cascardo <cascardo@linux.vnet.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 20, 2013 at 1:24 AM, Lucas Kannebley Tavares
<lucaskt@linux.vnet.ibm.com> wrote:
> This patch series first implements a function called pcie_get_speed_cap_mask
> in the PCI subsystem based off from drm_pcie_get_speed_cap_mask in drm. Then
> it removes the latter and fixes all references to it. And ultimately, it
> implements an architecture-specific version of the same function for ppc64.
>
> The refactor is done because the function that was used by drm is more
> architecture goo than module-specific. Whilst the function also needed a
> platform-specific implementation to get PCIE Gen2 speeds on ppc64.

Looks good to me but we probably want some one from the pci side to take a look

Reviewed-by: Jerome Glisse <jglisse@redhat.com>

>
> Lucas Kannebley Tavares (3):
>   pci: added pcie_get_speed_cap_mask function
>   drm: removed drm_pcie_get_speed_cap_mask function
>   ppc64: implemented pcibios_get_speed_cap_mask
>
>  arch/powerpc/platforms/pseries/pci.c |   35 +++++++++++++++++++++++++++
>  drivers/gpu/drm/drm_pci.c            |   38 -----------------------------
>  drivers/gpu/drm/radeon/evergreen.c   |    5 ++-
>  drivers/gpu/drm/radeon/r600.c        |    5 ++-
>  drivers/gpu/drm/radeon/rv770.c       |    5 ++-
>  drivers/pci/pci.c                    |   44 ++++++++++++++++++++++++++++++++++
>  include/drm/drmP.h                   |    6 ----
>  include/linux/pci.h                  |    6 ++++
>  8 files changed, 94 insertions(+), 50 deletions(-)
>
> --
> 1.7.4.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
