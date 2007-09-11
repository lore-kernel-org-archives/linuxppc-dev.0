Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 26190DDECB
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 00:34:03 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <20070911081746.GF9814@bakeyournoodle.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4d781cd1a4751e20098cae29aa4d2b60@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC/PATCH] Implement {read,update}_persistent_clock. v2
Date: Tue, 11 Sep 2007 09:34:13 -0500
To: Tony Breeds <tony@bakeyournoodle.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue Sep 11 18:17:46 EST 2007, Tony Breeds wrote:
> +unsigned long read_persistent_clock(void)
>  {
>         struct rtc_time tm;
> +       static int first = 1;
> +
> +       if (first) {
> +               first = 0;
> +               if (ppc_md.time_init)
> +                       timezone_offset = ppc_md.time_init();
> +       }
>
> -       if (ppc_md.get_boot_time)
> -               return ppc_md.get_boot_time();
> +       /* get_boot_time() isn't guaranteed to be safe to call late */
> +       /* FIXME: is the a better check available here? */
> +       if (system_state != SYSTEM_RUNNING && ppc_md.get_boot_time)
> +               return ppc_md.get_boot_time() -timezone_offset;
>         if (!ppc_md.get_rtc_time)
>                 return 0;
>         ppc_md.get_rtc_time(&tm);
>

Previously we called ppc_md.get_boot_time at most once.  How about 
moving the check for it into the if (first) block?

Have you tested with a platform that doesn't implement get_rtc_time?

milton
