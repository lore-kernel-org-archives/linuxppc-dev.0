Message-ID: <3C2366B0.70508@cray.com>
Date: Fri, 21 Dec 2001 10:43:28 -0600
From: David Updegraff <dave@cray.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: time patch.
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Greetings.

If Could someone with write acces to the tree could patch
	arch/ppc/kernel/time.c
so that for cases where we have no RTC?  On our non-nvram,
non-RTC board, running NTP falls into this [un-suprising] kernel panic.

I would be eternally in your debt.

--------
	if (ppc_md.set_rtc_time(xtime.tv_sec+1 + time_offset) == 0)
					last_rtc_update = xtime.tv_sec+1;
				else
					/* Try again one minute later */
					last_rtc_update += 60;
---------
Idunno, either ifdef it with CONFIG_PPC_RTC or just plop a
	if (ppc_md.set_rtc_time)
ontop of it..

--
Dave Updegraff / dave@cray.com / 218-525-1154


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
