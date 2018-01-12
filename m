Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zHzC25KnrzF0Vs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 21:15:10 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0CADqaF031117
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 05:15:08 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ferqndw92-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jan 2018 05:15:07 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Fri, 12 Jan 2018 10:15:05 -0000
Subject: Re: [PATCH v6 1/2] powerpc/powernv: Enable tunneled operations
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.vnet.ibm.com
References: <20180111150103.3137-1-felix@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Fri, 12 Jan 2018 11:15:02 +0100
MIME-Version: 1.0
In-Reply-To: <20180111150103.3137-1-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1b4b129c-5b9e-a423-90a8-fd345e9d89f0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 11/01/2018 à 16:01, Philippe Bergheaud a écrit :
> P9 supports PCI tunneled operations (atomics and as_notify). This
> patch adds support for tunneled operations on powernv, with a new
> API, to be called by device drivers:
> 
> pnv_pci_get_tunnel_ind()
>     Tell driver the 16-bit ASN indication used by kernel.
> 
> pnv_pci_set_tunnel_bar()
>     Tell kernel the Tunnel BAR Response address used by driver.
>     This function uses two new OPAL calls, as the PBCQ Tunnel BAR
>     register is configured by skiboot.
> 
> pnv_pci_get_as_notify_info()
>     Return the ASN info of the thread to be woken up.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> ---
> Changelog:
> 
> v2: Do not set the ASN indication. Get it from the device tree.
> 
> v3: Make pnv_pci_get_phb_node() available when compiling without cxl.
> 
> v4: Add pnv_pci_get_as_notify_info().
>      Rebase opal call numbers on skiboot 5.9.6.
> 
> v5: pnv_pci_get_tunnel_ind():
>        - fix node reference count
>      pnv_pci_get_as_notify_info():
>        - fail if task == NULL
>        - read pid from mm->context.id
>        - explain that thread.tidr require CONFIG_PPC64
> 
> v6: pnv_pci_get_tunnel_ind():
>        - check if radix is enabled, or else return an error
>       pnv_pci_get_as_notify_info():
>        - remove a capi-specific comment, irrelevant for pci
> 
> This patch depends on the following skiboot patches:
>    https://patchwork.ozlabs.org/patch/858324/
>    https://patchwork.ozlabs.org/patch/858325/
> ---
>   arch/powerpc/include/asm/opal-api.h            |   4 +-
>   arch/powerpc/include/asm/opal.h                |   2 +
>   arch/powerpc/include/asm/pnv-pci.h             |   5 ++
>   arch/powerpc/platforms/powernv/opal-wrappers.S |   2 +
>   arch/powerpc/platforms/powernv/pci-cxl.c       |   8 --
>   arch/powerpc/platforms/powernv/pci.c           | 106 +++++++++++++++++++++++++
>   6 files changed, 118 insertions(+), 9 deletions(-)
> 

Acked-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
