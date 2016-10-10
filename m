Return-Path: <sudipm.mukherjee@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3st4VK35CyzDrbq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 02:56:08 +1100 (AEDT)
Received: by mail-pa0-x244.google.com with SMTP id rw4so2618494pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 08:56:08 -0700 (PDT)
Message-ID: <57FBBA0B.9070500@gmail.com>
Date: Mon, 10 Oct 2016 21:25:55 +0530
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kernel: irq: fix build failure
References: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1475775403-27207-1-git-send-email-sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 06 October 2016 11:06 PM, Sudip Mukherjee wrote:
> The allmodconfig build of powerpc is failing with the error:
> ERROR: ".irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
>
> export the symbol to fix the failure.

Hi Thomas,
powerpc and arm allmodconfig builds still fails with the same error.
Build logs of next-20161010 are at:
arm at https://travis-ci.org/sudipm-mukherjee/parport/jobs/166321467
powerpc at https://travis-ci.org/sudipm-mukherjee/parport/jobs/166321473

Regards
Sudip

>
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> ---
>
> build log is at:
> https://travis-ci.org/sudipm-mukherjee/parport/jobs/165418652
>
>   kernel/irq/manage.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 0c5f1a5..5072814 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -721,6 +721,7 @@ int irq_set_parent(int irq, int parent_irq)
>   	irq_put_desc_unlock(desc, flags);
>   	return 0;
>   }
> +EXPORT_SYMBOL(irq_set_parent);
>   #endif
>
>   /*
>
