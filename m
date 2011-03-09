Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DFD85B70F0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 11:31:42 +1100 (EST)
Date: Tue, 8 Mar 2011 16:31:05 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Priyanka Jain <Priyanka.Jain@freescale.com>
Subject: Re: [PATCH] RTC driver(Linux) for PT7C4338 chip.
Message-Id: <20110308163105.1a6cb533.akpm@linux-foundation.org>
In-Reply-To: <1299039150-21063-1-git-send-email-Priyanka.Jain@freescale.com>
References: <1299039150-21063-1-git-send-email-Priyanka.Jain@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: a.zummo@towertech.it, linuxppc-dev@lists.ozlabs.org,
	rtc-linux@googlegroups.com, p_gortmaker@yahoo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2 Mar 2011 09:42:30 +0530
Priyanka Jain <Priyanka.Jain@freescale.com> wrote:

> PT7C4338 chip is being manufactured by Pericom Technology Inc.
> It is a serial real-time clock which provides:
> 1)Low-power clock/calendar.
> 2)Programmable square-wave output.
> It has 56 bytes of nonvolatile RAM.
> 
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> ---
>  PT7C4338 RTC driver is verified on Freescale P1010RDB. 
>  Please pick this patch for 2.6.39
> 
>  drivers/rtc/Kconfig        |    9 ++
>  drivers/rtc/Makefile       |    1 +
>  drivers/rtc/rtc-pt7c4338.c |  215 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 225 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/rtc/rtc-pt7c4338.c
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 10ba12c..6ff0901 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -324,6 +324,15 @@ config RTC_DRV_RX8025
>  	  This driver can also be built as a module. If so, the module
>  	  will be called rtc-rx8025.
>  
> +config RTC_DRV_PT7C4338
> +	tristate "Pericom Technology Inc. PT7C4338 RTC"
> +	help
> +	  If you say yes here you get support for the Pericom Technology
> +	  Inc. PT7C4338 RTC chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called rtc-pt7c4338.
> +

This means that the driver is available on all architectures, not just
powerpc.

This is a good thing and a bad thing.  Bad because it makes non-ppc
people possibly build and install a driver which they will never use
(correct?).  And good because it means that more people do compilation
test coverage.

Speaking of which:


From: Andrew Morton <akpm@linux-foundation.org>

include slab.h, remove unused local

drivers/rtc/rtc-pt7c4338.c: In function 'pt7c4338_probe':
drivers/rtc/rtc-pt7c4338.c:159: error: implicit declaration of function 'kzalloc'
drivers/rtc/rtc-pt7c4338.c:159: warning: assignment makes pointer from integer without a cast
drivers/rtc/rtc-pt7c4338.c:176: error: implicit declaration of function 'kfree'
drivers/rtc/rtc-pt7c4338.c:156: warning: unused variable 'adapter'

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <galak@gate.crashing.org>
Cc: Priyanka Jain <Priyanka.Jain@freescale.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/rtc/rtc-pt7c4338.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/rtc/Kconfig~rtc-driver-for-pt7c4338-chip-fix drivers/rtc/Kconfig
diff -puN drivers/rtc/Makefile~rtc-driver-for-pt7c4338-chip-fix drivers/rtc/Makefile
diff -puN drivers/rtc/rtc-pt7c4338.c~rtc-driver-for-pt7c4338-chip-fix drivers/rtc/rtc-pt7c4338.c
--- a/drivers/rtc/rtc-pt7c4338.c~rtc-driver-for-pt7c4338-chip-fix
+++ a/drivers/rtc/rtc-pt7c4338.c
@@ -35,6 +35,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/rtc.h>
@@ -153,7 +154,6 @@ static int pt7c4338_probe(struct i2c_cli
 		const struct i2c_device_id *id)
 {
 	struct pt7c4338 *pt7c4338;
-	struct i2c_adapter *adapter = to_i2c_adapter(client->dev.parent);
 	int ret;
 
 	pt7c4338 = kzalloc(sizeof(struct pt7c4338), GFP_KERNEL);
_
