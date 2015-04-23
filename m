Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9871C1A0C3D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 23:43:32 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1935914012F
 for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2015 23:43:31 +1000 (AEST)
Date: Thu, 23 Apr 2015 15:43:14 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] pci-phb: check for the 32-bit overflow
Message-ID: <20150423154314.595b8439@thh440s>
In-Reply-To: <1429700240-32373-1-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1429700240-32373-1-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: aik@ozlabs.ru, linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Wed, 22 Apr 2015 16:27:19 +0530
schrieb Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>:

> With the addition of 64-bit BARS and increase in the mmio address
> space, the code was hitting this limit. The memory of pci devices
> across the bridges were not accessible due to which the drivers
> failed.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  board-qemu/slof/pci-phb.fs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/board-qemu/slof/pci-phb.fs b/board-qemu/slof/pci-phb.fs
> index 529772f..e307d95 100644
> --- a/board-qemu/slof/pci-phb.fs
> +++ b/board-qemu/slof/pci-phb.fs
> @@ -258,7 +258,8 @@ setup-puid
>              decode-64 2 / dup >r                \ Decode and calc size/2
>              pci-next-mem @ + dup pci-max-mem !  \ and calc max mem address

Could pci-max-mem overflow, too?

>              dup pci-next-mmio !                 \ which is the same as MMIO base
> -            r> + pci-max-mmio !                 \ calc max MMIO address
> +            r> + FFFFFFFF min pci-max-mmio !    \ calc max MMIO address and
> +                                                \ check the 32-bit boundary

 Thomas
