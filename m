Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
 [212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id D58392C0081
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 23:17:44 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Chunhe Lan <b25806@freescale.com>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Mon, 24 Sep 2012 13:17:32 +0000
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com>
 <201209211233.54545.arnd@arndb.de> <50607A5A.3060103@freescale.com>
In-Reply-To: <50607A5A.3060103@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201209241317.32425.arnd@arndb.de>
Cc: kumar.gala@freescale.com, linux-mmc@vger.kernel.org, cjb@laptop.org,
 linuxppc-dev@lists.ozlabs.org, Chunhe Lan <Chunhe.Lan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 24 September 2012, Chunhe Lan wrote:
>     OK. As you have mentioned, it would been modified to such:
> 
> static inline void mmc_delay(unsigned int ms)
> {
>          if (ms < 1000 / HZ) {
>                  cond_resched();
>                  msleep(ms);
>          } else {
>                  msleep(ms);
>          }
> }

This version would be rather broken, because it compares times
in two different units (ms and jiffies), and because it
does a cond_resched() directly before an msleep: both of which
end up calling schedule() and being away for some time,
cond_resched() for an unknown time, and msleep for a minimum
time on top of that.

> OR such:
> 
> static inline void mmc_delay(unsigned int ms)
> {
>           msleep(ms);
> }

That would be my preferred choice, unless someone has specific issues with this.

> OR other code?

Well, in principle, you could implement something like

static inline void mmc_delay(unsigned int ms)
{
	ktime_t end = ktime_add_us(ktime_get(), ms * 1000);

	while (1) {
		s64 remaining;

		cond_resched();

		remaining = ktime_to_us(ktime_sub(end, ktime_get()));

		if (remaining < 0)
			break;

		udelay(min_t(u32, remaining, 100));
	}
}

	Arnd
