Date: Thu, 3 Aug 2000 18:33:18 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Gabriel Paubert <paubert@iram.es>
cc: Benjamin Herrenschmidt <bh40@calva.net>,
        Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org,
        Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: rtc again...
In-Reply-To: <Pine.HPX.4.10.10008031133480.9070-100000@gra-ux1.iram.es>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000803182949.650C-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Gabriel Paubert wrote:

> ===== arch/ppc/kernel/pmac_time.c 1.2 vs 1.5 =====
> --- 1.2/arch/ppc/kernel/pmac_time.c	Mon Jun 19 19:59:36 2000
> +++ 1.5/arch/ppc/kernel/pmac_time.c	Mon Jul 31 11:28:27 2000
[...]
>  int pmac_set_rtc_time(unsigned long nowtime)
>  {
> -	return 0;
> +#ifdef CONFIG_ADB
> +	struct adb_request req;
> +#endif
> +	nowtime += RTC_OFFSET - sys_tz.tz_minuteswest * 60;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This needs to be changed to

+	nowtime += RTC_OFFSET - sys_tz.tz_minuteswest * 60 + (sys_tz.tz_dsttime? 3600: 0);


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
