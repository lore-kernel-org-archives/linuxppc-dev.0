Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EA4B82C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 18:03:04 +1000 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id r46830bl020349
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 May 2013 03:03:01 -0500
Message-ID: <1367827379.15842.26.camel@pasglop>
Subject: Re: [PATCH 8/8] powerpc/topology: Fix spurr attribute permission
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 06 May 2013 18:02:59 +1000
In-Reply-To: <1367823055.15842.23.camel@pasglop>
References: <1367823055.15842.23.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-05-06 at 16:50 +1000, Benjamin Herrenschmidt wrote:
> We are registering the attribute with permission 0600 but it
> doesn't have a store callback, which causes WARN_ON's during
> boot. Fix the permission.

Ignore the 8/8 in the subject, that's just me not cleaning
things up properly :-)

Cheers,
Ben.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/sysfs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
> index 3ce1f86..e68a845 100644
> --- a/arch/powerpc/kernel/sysfs.c
> +++ b/arch/powerpc/kernel/sysfs.c
> @@ -180,7 +180,7 @@ SYSFS_PMCSETUP(dscr, SPRN_DSCR);
>  SYSFS_PMCSETUP(pir, SPRN_PIR);
>  
>  static DEVICE_ATTR(mmcra, 0600, show_mmcra, store_mmcra);
> -static DEVICE_ATTR(spurr, 0600, show_spurr, NULL);
> +static DEVICE_ATTR(spurr, 0400, show_spurr, NULL);
>  static DEVICE_ATTR(dscr, 0600, show_dscr, store_dscr);
>  static DEVICE_ATTR(purr, 0600, show_purr, store_purr);
>  static DEVICE_ATTR(pir, 0400, show_pir, NULL);
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
