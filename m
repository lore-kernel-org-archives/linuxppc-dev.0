Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id E3C6ADDE45
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 02:18:47 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 4/7] ps3: Storage Driver Probing
Date: Fri, 25 May 2007 18:18:03 +0200
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.474400000@sonycom.com>
In-Reply-To: <20070525083632.474400000@sonycom.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705251818.03964.arnd@arndb.de>
Cc: Geert.Uytterhoeven@sonycom.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 25 May 2007, Geert.Uytterhoeven@sonycom.com wrote:
> Add storage driver probing.
> New storage devices are detected and added by a kthread.

Hi Geert,

the driver looks pretty good, just a few details I noticed:

> +static u64 ps3stor_wait_for_completion(u64 devid, u64 tag,
> +				       unsigned int timeout)
> +{
> +	unsigned int retries = 0;
> +	u64 res = -1, status;
> +
> +	for (retries = 0; retries < timeout; retries++) {
> +		res = lv1_storage_check_async_status(NOTIFICATION_DEVID, tag,
> +						     &status);
> +		if (!res)
> +			break;
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(1);
> +	}

Any reason not to use msleep(1) instead of the schedule_timeout?

> +	switch (dev_type) {
> +	case PS3_DEV_TYPE_STOR_DISK:
> +		match_id = PS3_MATCH_ID_STOR_DISK;
> +		break;
> +
> +	case PS3_DEV_TYPE_STOR_ROM:
> +		match_id = PS3_MATCH_ID_STOR_ROM;
> +		break;
> +
> +	case PS3_DEV_TYPE_STOR_FLASH:
> +		match_id = PS3_MATCH_ID_STOR_FLASH;
> +		break;
> +
> +	default:
> +		return 0;
> +	}

Why do you have separate constants for PS3_DEV_TYPE_* and
PS3_MATCH_ID_*? If you don't do any conversion, this driver
will immediately work for additional types as well, if more
get added later.

> +
> +//		pr_debug("%s:%u: Checking for new storage devices...\n",
> +//			 __func__, __LINE__);

Should be removed, or not in comments, either way is fine, as pr_debug
normally does not get compiled in anyway.

> +
> +		msleep_interruptible(ms);
> +		if (ms < 60000)
> +			ms <<= 1;

Is this timeout only for the disk spinup, or also for detecting media
added at run time, like inserting a DVD? One minute timeout for
detecting a DVD would sound very long to me.

	Arnd <><
