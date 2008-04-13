Return-Path: <jwboyer@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 9E2F0DE1E5
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Apr 2008 10:49:48 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so1092664pyg.27
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 17:49:46 -0700 (PDT)
Subject: Re: [PATCH 1/5] Boot code
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20080412140140.6c75cee5@lappy.seanm.ca>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080412140140.6c75cee5@lappy.seanm.ca>
Content-Type: text/plain
Date: Sat, 12 Apr 2008 19:49:43 -0500
Message-Id: <1208047783.5869.35.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-04-12 at 14:01 -0400, Sean MacLennan wrote:
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>
> 

This patch is word wrapped.


> diff --git a/arch/powerpc/boot/cuboot-warp.c
> b/arch/powerpc/boot/cuboot-warp.c index eb108a8..43d7ad9 100644
> --- a/arch/powerpc/boot/cuboot-warp.c
> +++ b/arch/powerpc/boot/cuboot-warp.c
> @@ -10,6 +10,7 @@
>  #include "ops.h"
>  #include "4xx.h"
>  #include "cuboot.h"
> +#include "stdio.h"
>  
>  #define TARGET_4xx
>  #define TARGET_44x
> @@ -17,14 +18,54 @@
>  
>  static bd_t bd;
>  
> -static void warp_fixups(void)
> +static void warp_fixup_one_nor(u32 from, u32 to)
>  {
> -	unsigned long sysclk = 66000000;
> +	void *devp;
> +	char name[40];
> +	u32 v[2];
> +
> +	sprintf(name, "/plb/opb/ebc/nor_flash@0,0/partition@%x", from);

Unless I can't count (which could very well be the case), you have a
buffer overflow here.  The fixed string is 37 characters, and the values
you are passing in for "from" will extend the string past the 40 bytes
you have allocated for "name".

josh
