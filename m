Return-Path: <alessandro.zummo@towertech.it>
Received: from mx0.towertech.it (mx0.towertech.it [213.215.222.73])
	by ozlabs.org (Postfix) with SMTP id 0E1E1DDDEE
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 05:12:10 +1100 (EST)
Date: Tue, 11 Nov 2008 19:11:55 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: rtc-linux@googlegroups.com
Subject: Re: [rtc-linux] Re: [RFC PATCH] rtc: add rtc_systohc for ntp use
Message-ID: <20081111191155.2dca397a@i1501.lan.towertech.it>
In-Reply-To: <1226412639.4367.256.camel@macbook.infradead.org>
References: <20081110154026.21405.47457.stgit@i1501.lan.towertech.it>
	<1226412639.4367.256.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: David Brownell <david-b@pacbell.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Paul Mundt <lethal@linux-sh.org>, dwmw2@infradead.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 11 Nov 2008 14:10:39 +0000
David Woodhouse <dwmw2@infradead.org> wrote:

> You might do better to open the device once and keep it open, rather
> than taking the mutex and opening it again _during_ each call? You're
> going to be perturbing the timing by doing that.

 If you keep it open no other in-kernel user would be able to
 use it.

> I believe you were also concerned that some device wouldn't want the
> behaviour given by the existing sync_cmos_clock() function and workqueue
> stuff in kernel/ntp.c, where we update the clock precisely half-way
> through the second?
> 
> We should probably rip that code out of ntp.c (or just disable it ifdef
> CONFIG_RTC_CLASS), and provide our own version of notify_cmos_timer().
> 
> The workqueue stuff to trigger at half-past the second could be kept as
> a library function which most RTC devices would use, but they'd have the
> option to use their own instead.

 I'll give it a look.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
