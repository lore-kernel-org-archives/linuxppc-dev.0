Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 59EC2DDEE6
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 05:48:41 +1000 (EST)
Date: Fri, 25 May 2007 21:48:39 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 4/7] ps3: Storage Driver Probing
In-Reply-To: <200705251818.03964.arnd@arndb.de>
Message-ID: <Pine.LNX.4.62.0705252143270.2657@pademelon.sonytel.be>
References: <20070525083607.784351000@sonycom.com>
	<20070525083632.474400000@sonycom.com>
	<200705251818.03964.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 25 May 2007, Arnd Bergmann wrote:
> On Friday 25 May 2007, Geert.Uytterhoeven@sonycom.com wrote:
> > +static u64 ps3stor_wait_for_completion(u64 devid, u64 tag,
> > +				       unsigned int timeout)
> > +{
> > +	unsigned int retries = 0;
> > +	u64 res = -1, status;
> > +
> > +	for (retries = 0; retries < timeout; retries++) {
> > +		res = lv1_storage_check_async_status(NOTIFICATION_DEVID, tag,
> > +						     &status);
> > +		if (!res)
> > +			break;
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		schedule_timeout(1);
> > +	}
> 
> Any reason not to use msleep(1) instead of the schedule_timeout?

Not really. I'll change it.

> > +	switch (dev_type) {
> > +	case PS3_DEV_TYPE_STOR_DISK:
> > +		match_id = PS3_MATCH_ID_STOR_DISK;
> > +		break;
> > +
> > +	case PS3_DEV_TYPE_STOR_ROM:
> > +		match_id = PS3_MATCH_ID_STOR_ROM;
> > +		break;
> > +
> > +	case PS3_DEV_TYPE_STOR_FLASH:
> > +		match_id = PS3_MATCH_ID_STOR_FLASH;
> > +		break;
> > +
> > +	default:
> > +		return 0;
> > +	}
> 
> Why do you have separate constants for PS3_DEV_TYPE_* and
> PS3_MATCH_ID_*? If you don't do any conversion, this driver
> will immediately work for additional types as well, if more
> get added later.

The PS3_DEV_TYPE_* IDs are imposed by the repository, as created by the
hypervisor.
The PS3_MATCH_ID_* IDs are created by us, for all PS3-specific devices.
As Geoff already pointed out, we may be able to use PS3_DEV_TYPE_* IDs for
everything, but unfortunately not all PS3-specific devices are present in the
repository.

> > +
> > +//		pr_debug("%s:%u: Checking for new storage devices...\n",
> > +//			 __func__, __LINE__);
> 
> Should be removed, or not in comments, either way is fine, as pr_debug
> normally does not get compiled in anyway.

Oops, forgot to uncomment it (it was a bit noisy while I lived with DEBUG
defined ;-)

> > +		msleep_interruptible(ms);
> > +		if (ms < 60000)
> > +			ms <<= 1;
> 
> Is this timeout only for the disk spinup, or also for detecting media
> added at run time, like inserting a DVD? One minute timeout for
> detecting a DVD would sound very long to me.

It's not for inserting DVDs, only for new devices showing up in the repository.
Apparently new devices may keep on showing up a while after boot up, but I
think this matters only for the kboot kernel, that's why I went with the
exponential back-off with upper limit.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
