Return-Path: <lists@nerdbynature.de>
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
 by ozlabs.org (Postfix) with ESMTP id D868A2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 06:07:26 +1000 (EST)
Date: Thu, 26 Sep 2013 13:07:09 -0700 (PDT)
From: Christian Kujau <lists@nerdbynature.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: therm_adt746x: -3 invalid for parameter limit_adjust
In-Reply-To: <20130926113936.24c10b78@endymion.delvare>
Message-ID: <alpine.DEB.2.11.1309261304090.6519@trent.utfs.org>
References: <alpine.DEB.2.11.1309260202480.6519@trent.utfs.org>
 <20130926113936.24c10b78@endymion.delvare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: colin@colino.net, Andrew Morton <akpm@linux-foundation.org>,
 Jingoo Han <jg1.han@samsung.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 26 Sep 2013 at 11:39, Jean Delvare wrote:
> I think it is a bug in:
> 
> commit 6072ddc8520b86adfac6939ca32fb6e6c4de017a
> Author: Jingoo Han <jg1.han@samsung.com>
> Date:   Thu Sep 12 15:14:07 2013 -0700
> 
>     kernel: replace strict_strto*() with kstrto*()
> 
> The change was a good idea but the code itself is not, it has kstrtoul
> in many places where kstrtol should be used. Please try the following
> patch, hopefully that should fix your problem:
> 

Bingo, this did it! Applied to 3.12.0-rc2, the limit is now lowered again:

 $ modprobe therm_adt746x limit_adjust=-3
 $ dmesg
 [...]
 adt746x: Lowering max temperatures from 73, 80, 109 to 67, 47, 67

Thanks!

  Tested-by: Christian Kujau <lists@nerdbynature.de>

Christian.

> From: Jean Delvare <khali@linux-fr.org>
> Subject: kernel/params: Fix handling of signed integer types
> 
> Commit 6072ddc8520b86adfac6939ca32fb6e6c4de017a broke the handling
> of signed integer types, fix it.
> 
> Reported-by: Christian Kujau <lists@nerdbynature.de>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Jingoo Han <jg1.han@samsung.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  kernel/params.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> --- linux-3.12-rc2.orig/kernel/params.c	2013-09-24 00:41:09.000000000 +0200
> +++ linux-3.12-rc2/kernel/params.c	2013-09-26 11:32:43.434586197 +0200
> @@ -254,11 +254,11 @@ int parse_args(const char *doing,
>  
>  
>  STANDARD_PARAM_DEF(byte, unsigned char, "%hhu", unsigned long, kstrtoul);
> -STANDARD_PARAM_DEF(short, short, "%hi", long, kstrtoul);
> +STANDARD_PARAM_DEF(short, short, "%hi", long, kstrtol);
>  STANDARD_PARAM_DEF(ushort, unsigned short, "%hu", unsigned long, kstrtoul);
> -STANDARD_PARAM_DEF(int, int, "%i", long, kstrtoul);
> +STANDARD_PARAM_DEF(int, int, "%i", long, kstrtol);
>  STANDARD_PARAM_DEF(uint, unsigned int, "%u", unsigned long, kstrtoul);
> -STANDARD_PARAM_DEF(long, long, "%li", long, kstrtoul);
> +STANDARD_PARAM_DEF(long, long, "%li", long, kstrtol);
>  STANDARD_PARAM_DEF(ulong, unsigned long, "%lu", unsigned long, kstrtoul);
>  
>  int param_set_charp(const char *val, const struct kernel_param *kp)
> 
> 
> -- 
> Jean Delvare
> 

-- 
BOFH excuse #353:

Second-system effect.
