From: Benjamin Herrenschmidt <bh40@calva.net>
To: Gabriel Paubert <paubert@iram.es>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: rtc again...
Date: Wed, 9 Aug 2000 17:25:41 +0200
Message-Id: <20000809152541.9611@mailhost.mipsys.com>
In-Reply-To: <Pine.HPX.4.10.10008091436330.22126-100000@gra-ux1.iram.es>
References: <Pine.HPX.4.10.10008091436330.22126-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I agree on the point if setting the timezone at boot, that's basically the
>only thing I would consider permissible. For the rest the RTC is running
>as is, and /dev/rtc gives you direct acces to the HW: no cooked values,
>you always end up losing when playing such games.

Ok. Then for this to work, we need to slightly change the boot code not
to call simply ppc_md.get_rtc_time(), but to also adjust it on pmac using
the pram timezone. That means adding a new ppc_md.fixup_time() used only
at boot, or adding a "fixup" parameter to ppc_mc.get_rtc_time() set to 0
in normal cases and to 1 on first call during boot.

>I do see some: principle of least surprise for people porting applications
>between PC and Mac. Minimize #ifdef noise in their sources...

Well, it's nice to save back the timezone to the xpram (the code Paul
added). But it's probably not good to do so from ppc_md.set_rtc_time().
So that would yet another #if/_MACH_Pmac hack...

>During Linux boot: read the time and offset from xpram and set xtime
>accordingly (preventing further timewarps by using do_sys_settimofday),
>then clear the timezone info in the RAM, and rewrite the clock so that it
>runs in UTC.

Clear the tz info in nvram ? why ? That would probably harm MacOS... And
I don't like writing to nvram when it's not necessary (nvram is a flash
on some machines). I would rather let the RTC run in local time and pass
localtime to userland, letting the user set the userland tool correctly
and so behave like other archs with local time RTC. So to resume, what I
need to fix is:

 - change ppc_md.get/set_rtc_time() to set and return the raw time from
the RTC
 - at boot, apply only once the offset from nvram, initialize sys_tz and
call do_sys_settimeofday()
 - Figure out a way to write back the timezone to nvram (since I think
sys_tz is updated by userland tools via settimeofday, isn't it ?) when
changed.

>Yes, this is strange, but the original error lies with Apple storing the
>time as local time while keeping also the timezone. I can understand and
>even agree on keeping the timezone and the DST flag in RAM, but then why
>the heck do you want to store the RTC in local time ? It only makes thing
>more complex around DST changes or when changing timezones when you
>travel. I thought Macs were about simplicity...

Macs are about simplicity, MacOS internals are not ;)

>Who uses FAT anyway ? I'm going to patch my kernels to kill sys_tz, now
>that I've come to the conclusion that its mere existence is an
>aberration... With an UTC clock, it's the only sensible solution ;-). But
>I don't suggest that everybody should do the same...

Hum...


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
