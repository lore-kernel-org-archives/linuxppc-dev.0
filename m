Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbYvf0pxTzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 20:09:01 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: David Laight <David.Laight@aculab.com>,
 "'Shreyas B. Prabhu'" <shreyas@linux.vnet.ibm.com>,
 "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
 "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
 "anton@samba.org" <anton@samba.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] cpuidle: Fix last_residency division
Date: Fri, 24 Jun 2016 12:11:02 +0200
Message-ID: <14940457.SEYBmqcunj@wuerfel>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D5F4E3E66@AcuExch.aculab.com>
References: <1466756638-2362-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D5F4E3E66@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday, June 24, 2016 9:00:48 AM CEST David Laight wrote:
> The intent of the >> 10 was probably to avoid an expensive 64bit divide.
> So maybe something like:
>         diff = time_end - time_start;
>         if (diff >= INT_MAX/2)
>                 diff_32 = INT_MAX/2/1000;
>         else
>                 diff_32 = diff;
>                 diff_32 += diff_32 >> 6;
>                 diff_32 >>= 10;
>         }
> 
> Adding an extra 1/32 makes the division by be something slightly below 1000.

Why not change the definition of the time to nanoseconds and update
the users accordingly?

I see that cpuidle_enter_state() writes to the last_residency value,
and it is read in three places: ladder_select_state(), menu_update()
and show_state_time() (for sysfs).

If those functions are called less often than cpuidle_enter_state(),
we could just move the division there. Since the divisor is constant,
do_div() can convert it into a multiply and shift, or we could use
your the code you suggest above, or use a 32-bit division most of
the time:

	if (diff <= UINT_MAX)
		diff_32 = (u32)diff / NSECS_PER_USEC;
	else
		diff_32 = div_u64(diff, NSECS_PER_USEC;

which gcc itself will turn into a multiplication or series of
shifts on CPUs on which that is faster.

	Arnd
