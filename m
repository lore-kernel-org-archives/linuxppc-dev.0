Return-Path: <fujita.tomonori@lab.ntt.co.jp>
Received: from tama500.ecl.ntt.co.jp (tama500.ecl.ntt.co.jp [129.60.39.148])
	by ozlabs.org (Postfix) with ESMTP id 1E891DDDEE
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 12:41:22 +1000 (EST)
To: geoffrey.levand@am.sony.com
Subject: Re: [patch 2/5] PS3: Add time include to lpm
From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <4818F1C5.2010800@am.sony.com>
References: <20080430215644.655638516@am.sony.com>
	<4818F1C5.2010800@am.sony.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <20080501113343K.fujita.tomonori@lab.ntt.co.jp>
Date: Thu, 01 May 2008 11:33:43 +0900
Cc: fujita.tomonori@lab.ntt.co.jp, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 30 Apr 2008 15:25:09 -0700
Geoff Levand <geoffrey.levand@am.sony.com> wrote:

> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> 
> Add an include <asm/time.h> statement for get_tb().
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> ---
> drivers/ps3/ps3-lpm.c:192: error: implicit declaration of function 'get_tb'
> 
> I could not recreate this error.  asm/time.h seems to be included
> from linux/module.h:
> 
> In file included from include2/asm/cputime.h:27,

Seems that if VIRT_CPU_ACCOUNTING is disabled, asm/time.h is not
included here.


>                  from /home/geoff/projects/cell/linux-2.6/include/linux/sched.h:67,
>                  from include2/asm/elf.h:6,
>                  from /home/geoff/projects/cell/linux-2.6/include/linux/elf.h:8,
>                  from /home/geoff/projects/cell/linux-2.6/include/linux/module.h:15,
>                  from /home/geoff/projects/cell/linux-2.6/drivers/ps3/ps3-lpm.c:24:
> include2/asm/time.h:134
> 
>  drivers/ps3/ps3-lpm.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/drivers/ps3/ps3-lpm.c
> +++ b/drivers/ps3/ps3-lpm.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/uaccess.h>
> +#include <asm/time.h>
>  #include <asm/ps3.h>
>  #include <asm/lv1call.h>
>  #include <asm/cell-pmu.h>
> 
> -- 
> 
> 
> 
