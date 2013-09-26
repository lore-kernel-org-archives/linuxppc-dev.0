Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zoneX.GCU-Squad.org [194.213.125.0])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 805CB2C00C2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 20:10:16 +1000 (EST)
Date: Thu, 26 Sep 2013 11:39:36 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Christian Kujau <lists@nerdbynature.de>
Subject: Re: therm_adt746x: -3 invalid for parameter limit_adjust
Message-ID: <20130926113936.24c10b78@endymion.delvare>
In-Reply-To: <alpine.DEB.2.11.1309260202480.6519@trent.utfs.org>
References: <alpine.DEB.2.11.1309260202480.6519@trent.utfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Hi Christian,

On Thu, 26 Sep 2013 02:16:16 -0700 (PDT), Christian Kujau wrote:
> Hi,
> 
> after upgrading from 3.11 to 3.12-rc2, the therm_adt746x module could not 
> be loaded any more:
> 
>   therm_adt746x: `-2' invalid for parameter `limit_adjust'
> 
> I've alwasy passed "limit_adjust=-3" (negative 3) to the module via 
> modprobe.conf, to lower the max temperature. Up until 3.11, loading the 
> module would print:
> 
>   adt746x: Lowering max temperatures from 73, 80, 109 to 67, 47, 67
> 
> I can load the module without limit_adjust or with positive values, but 
> really wanted to lower the temperature, so that the fan would kick in 
> earlier. For reference, this is what happens in 3.12-rc2:
> 
>  v--- limit_adjust
>  |
>  0: adt746x: Lowering max temperatures from 73, 80, 109 to 70, 50, 70
>  1: adt746x: Lowering max temperatures from 73, 80, 109 to 71, 51, 71
>  2: adt746x: Lowering max temperatures from 73, 80, 109 to 72, 52, 72
>  3: adt746x: Lowering max temperatures from 73, 80, 109 to 73, 53, 73
>  4: adt746x: Lowering max temperatures from 73, 80, 109 to 74, 54, 74
> 10: adt746x: Lowering max temperatures from 73, 80, 109 to 80, 60, 80
> 
> Was passing negative values to therm_adt746x ever supported?

As far as I can see, yes.

> drivers/macintosh/therm_adt746x.c hasn't been touched in a while, this 
> means some other change did it.
> 
> Before I attempt a full git bisect, any hints what could have caused this?

I think it is a bug in:

commit 6072ddc8520b86adfac6939ca32fb6e6c4de017a
Author: Jingoo Han <jg1.han@samsung.com>
Date:   Thu Sep 12 15:14:07 2013 -0700

    kernel: replace strict_strto*() with kstrto*()

The change was a good idea but the code itself is not, it has kstrtoul
in many places where kstrtol should be used. Please try the following
patch, hopefully that should fix your problem:

From: Jean Delvare <khali@linux-fr.org>
Subject: kernel/params: Fix handling of signed integer types

Commit 6072ddc8520b86adfac6939ca32fb6e6c4de017a broke the handling
of signed integer types, fix it.

Reported-by: Christian Kujau <lists@nerdbynature.de>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jingoo Han <jg1.han@samsung.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 kernel/params.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-3.12-rc2.orig/kernel/params.c	2013-09-24 00:41:09.000000000 +0200
+++ linux-3.12-rc2/kernel/params.c	2013-09-26 11:32:43.434586197 +0200
@@ -254,11 +254,11 @@ int parse_args(const char *doing,
 
 
 STANDARD_PARAM_DEF(byte, unsigned char, "%hhu", unsigned long, kstrtoul);
-STANDARD_PARAM_DEF(short, short, "%hi", long, kstrtoul);
+STANDARD_PARAM_DEF(short, short, "%hi", long, kstrtol);
 STANDARD_PARAM_DEF(ushort, unsigned short, "%hu", unsigned long, kstrtoul);
-STANDARD_PARAM_DEF(int, int, "%i", long, kstrtoul);
+STANDARD_PARAM_DEF(int, int, "%i", long, kstrtol);
 STANDARD_PARAM_DEF(uint, unsigned int, "%u", unsigned long, kstrtoul);
-STANDARD_PARAM_DEF(long, long, "%li", long, kstrtoul);
+STANDARD_PARAM_DEF(long, long, "%li", long, kstrtol);
 STANDARD_PARAM_DEF(ulong, unsigned long, "%lu", unsigned long, kstrtoul);
 
 int param_set_charp(const char *val, const struct kernel_param *kp)


-- 
Jean Delvare
