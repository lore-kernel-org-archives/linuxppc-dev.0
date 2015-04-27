Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28FCC1A0D07
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 18:17:51 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A836514007D
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:17:50 +1000 (AEST)
Date: Mon, 27 Apr 2015 10:17:32 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/4] pci: program correct bridge limit registers
 during probe
Message-ID: <20150427101732.652e36e5@thh440s>
In-Reply-To: <1430121753-24818-2-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1430121753-24818-2-git-send-email-nikunj@linux.vnet.ibm.com>
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

On Mon, 27 Apr 2015 13:32:30 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> According to the pci-to-pci bridge specification, memory/io limit
> should be the last address of the window, while currently its set to
> last + 1. It broke when the memory range was increased and hit 32-bit
> limit. The last address in the window is 0xFFFF.FFFF and max-mmio is
> 0x1.0000.0000, because of the bug 0x0000 got programmed in the memory
> limit register. All the mmio reads across the pci-to-pci bridge
> started failing during probe.
> 
> All pci-bridge-set-[mmio,mem,io]-base sufferred from similar problem.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  slof/fs/pci-scan.fs | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/slof/fs/pci-scan.fs b/slof/fs/pci-scan.fs
> index 15d0c8e..b8b9fe6 100644
> --- a/slof/fs/pci-scan.fs
> +++ b/slof/fs/pci-scan.fs
> @@ -87,7 +87,7 @@ here 100 allot CONSTANT pci-device-vec
>          pci-next-mmio @ 100000 #aligned         \ read the current Value and align to 1MB boundary
>          dup 100000 + pci-next-mmio !            \ and write back with 1MB for bridge
>          10 rshift                               \ mmio-base reg is only the upper 16 bits
> -        pci-max-mmio @ FFFF0000 and or          \ and Insert mmio Limit (set it to max)
> +        pci-max-mmio @ 1- FFFF0000 and or       \ and Insert mmio Limit (set it to max)
>          swap 20 + rtas-config-l!                \ and write it into the bridge
>  ;
>  
> @@ -116,7 +116,7 @@ here 100 allot CONSTANT pci-device-vec
>                  2 pick 2C + rtas-config-l!      \ | and set the Limit
>          THEN                                    \ FI
>          10 rshift                               \ keep upper 16 bits
> -        pci-max-mem @ FFFF0000 and or           \ and Insert mmem Limit (set it to max)
> +        pci-max-mem @ 1- FFFF0000 and or        \ and Insert mmem Limit (set it to max)
>          swap 24 + rtas-config-l!                \ and write it into the bridge
>  ;
>  
> @@ -150,7 +150,7 @@ here 100 allot CONSTANT pci-device-vec
>                  swap 30 + rtas-config-l!        \ | and write it into the Base-Upper16-bits
>          THEN                                    \ FI
>          8 rshift 000000FF and                   \ keep upper 8 bits
> -        pci-max-io @ 0000FF00 and or            \ insert upper 8 bits of Max-Limit
> +        pci-max-io @ 1- 0000FF00 and or         \ insert upper 8 bits of Max-Limit
>          over rtas-config-l@ FFFF0000 and        \ fetch original Value
>          or swap 1C + rtas-config-l!             \ and write it into the bridge
>  ;

Reviewed-by: Thomas Huth <thuth@redhat.com>
