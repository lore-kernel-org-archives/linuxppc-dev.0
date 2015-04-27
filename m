Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEA011A1152
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2015 18:26:49 +1000 (AEST)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5E94A140082
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2015 18:26:49 +1000 (AEST)
Date: Mon, 27 Apr 2015 10:26:27 +0200
From: Thomas Huth <thuth@redhat.com>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 3/4] usb: support 64-bit pci bars
Message-ID: <20150427102627.490d8826@thh440s>
In-Reply-To: <1430121753-24818-4-git-send-email-nikunj@linux.vnet.ibm.com>
References: <1430121753-24818-1-git-send-email-nikunj@linux.vnet.ibm.com>
 <1430121753-24818-4-git-send-email-nikunj@linux.vnet.ibm.com>
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

On Mon, 27 Apr 2015 13:32:32 +0530
Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:

> With the addition of 64-bit bar ranges (commit: 9fbfed08 - pci: use
> 64bit bar ranges), the usb-setup-hcidev needs to handle 64-bit
> addresses.
> 
> For example, QEMU provided NEC USB XHCI device requests 64-bit memory
> address. Added code to check the memory type before address
> translation.
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  slof/fs/devices/pci-class_0c.fs | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/slof/fs/devices/pci-class_0c.fs b/slof/fs/devices/pci-class_0c.fs
> index 9c47325..39453fb 100644
> --- a/slof/fs/devices/pci-class_0c.fs
> +++ b/slof/fs/devices/pci-class_0c.fs
> @@ -25,8 +25,14 @@ CONSTANT /hci-dev
>  
>  : usb-setup-hcidev ( num hci-dev -- )
>      >r
> -    10 config-l@ translate-my-address
> -    3 not AND
> +    10 config-l@ F AND case
> +	0 OF 10 config-l@ translate-my-address ENDOF       \ 32-bit memory space
> +	4 OF                                               \ 64-bit memory space
> +	    14 config-l@ 20 lshift                         \ Read two bars
> +	    10 config-l@ OR translate-my-address
> +	ENDOF
> +    ENDCASE
> +    F not AND
>      ( io-base ) r@ hcd>base !
>      08 config-l@ 8 rshift  0000000F0 AND 4 rshift
>      ( usb-type ) r@ hcd>type !

Looks good to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>
