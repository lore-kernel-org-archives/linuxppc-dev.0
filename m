Return-Path: <srs0=deuz=5e=gmail.com=npiggin@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcQ7Y4kzvzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 17:23:21 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wcQ7Y47kVz8t3p
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 17:23:21 +1000 (AEST)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wcQ7Y01Kfz9ryv
 for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2017 17:23:21 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id n23so15995289pfb.3
 for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2017 00:23:20 -0700 (PDT)
Date: Tue, 30 May 2017 17:22:42 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2] powerpc/64s: Add dt_cpu_ftrs boot time setup option
Message-ID: <20170530172242.251c9b9d@roar.ozlabs.ibm.com>
In-Reply-To: <1496125689-27900-1-git-send-email-mpe@ellerman.id.au>
References: <1496125689-27900-1-git-send-email-mpe@ellerman.id.au>
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

On Tue, 30 May 2017 16:28:09 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> From: Nicholas Piggin <npiggin@gmail.com>
> 
> Provide a dt_cpu_ftrs= cmdline option to disable the dt_cpu_ftrs CPU
> feature discovery, and fall back to the "cputable" based version.
> 
> Also allow control of advertising unknown features to userspace and
> with this parameter, and remove the clunky CONFIG option.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> [mpe: Add explicit early check of bootargs in dt_cpu_ftrs_init()]

Thanks for fixing that up. The patch is more yours than mine now :P

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -866,6 +866,16 @@
>  
>  	dscc4.setup=	[NET]
>  
> +	dt_cpu_ftrs=	[PPC]
> +			Format: {"off" | "known"}
> +			Control how the dt_cpu_ftrs device-tree binding is
> +			used for CPU feature discovery and setup (if it
> +			exists).
> +			off: Do not use it, fall back to legacy cpu table.
> +			known: Do not pass through unknown features to guests
> +			or userspace, only those that the kernel is not aware
> +			of.

Well that's not the right number of nots. Better make it:

+			known: Do not pass through unknown features to guests
+			or userspace, only those that the kernel is not not
+			aware of.
