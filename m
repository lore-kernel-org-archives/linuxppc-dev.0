Date: Thu, 10 Aug 2000 00:13:16 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000809152541.9611@mailhost.mipsys.com>
Message-ID: <Pine.HPX.4.10.10008092142330.22126-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 9 Aug 2000, Benjamin Herrenschmidt wrote:

> >
> >I agree on the point if setting the timezone at boot, that's basically the
> >only thing I would consider permissible. For the rest the RTC is running
> >as is, and /dev/rtc gives you direct acces to the HW: no cooked values,
> >you always end up losing when playing such games.
>
> Ok. Then for this to work, we need to slightly change the boot code not
> to call simply ppc_md.get_rtc_time(), but to also adjust it on pmac using
> the pram timezone. That means adding a new ppc_md.fixup_time() used only
> at boot, or adding a "fixup" parameter to ppc_mc.get_rtc_time() set to 0
> in normal cases and to 1 on first call during boot.

I strongly suspect that we might want a single rtc access function in
ppc_md and add a first parameter telling what we want it to do, the second
being a pointer to a tv_sec, and perhaps more parameters.

I have problems for example with repeatability of boot-time timebase
frequency measurements (yes 2-3 ppm are extremely important for me)
which could be solved by yet another entry in ppc_md but I don't want it.
The solution would be to read the rtc and return the timebase value at the
time the second changes.

This ppc_md.rtc_access should provide the following functions or something
equivalent,

PPC_RTC_READ_TIME,
PPC_RTC_WRITE_TIME,
PPC_RTC_WRITE_MMSS (for NTP/adjtime adjustments),
PPC_RTC_CALIBRATE_TB (needed for some machines, measure as precisely as
possible the timebase difference between 2 second transitions, this means
on PreP for example setting the NVRAM pointer to the seconds byte and
repeatedly reading it instead of rereading the whole year to seconds every
time),

This last function could also be performed by returning the timebase in
the READ_TIME function as an extra parameter. The best solution is the one
which gives the minimal permanent kernel size, __init code size is
irrelevant.

> >I do see some: principle of least surprise for people porting applications
> >between PC and Mac. Minimize #ifdef noise in their sources...
>
> Well, it's nice to save back the timezone to the xpram (the code Paul
> added). But it's probably not good to do so from ppc_md.set_rtc_time().
> So that would yet another #if/_MACH_Pmac hack...

What use does it have if no daemon will change the timezone anyway ?

Your time offset will be updated on the fly (at least for newly
forked processes), but the kernel sys_tz won't. This might actually be
construed as a feature, imagine running make in a filesystem with local
time filestamps around a backward DST change...

AFAICT for example Win98 will change the RTC only on reboot when it
detects that the DST setting has changed since last reboot. And even that
does not work properly (that's what a colleague told me, so take it with a
grain of salt). This maybe because time warps would confuse running (M$ of
course) applications, and anyway you are not supposed to leave it running
overnight, it will anyway crash for you if you forget to shutdown ;-)

How does MacOS handle DST changes (on the fly or only at reboot) ?

> Clear the tz info in nvram ? why ? That would probably harm MacOS... And
> I don't like writing to nvram when it's not necessary (nvram is a flash
> on some machines). I would rather let the RTC run in local time and pass
> localtime to userland, letting the user set the userland tool correctly

You never (well hardldy ever) pass localtime to userland in Unix and
that's a big big big plus, each process/user can set TZ as it wishes. IOW
the value of sys_tz is at best a system wide default but is not imposed to
anybody. Here at the telescope on all Linux machines, /etc/localtime is
set as UTC, but then I set TZ=Europe/Madrid in my .profile to avoid too
much confusion with my PC which has localtime set to Europe/Madrid.  And
right now I am running a shell with TZ set to Pacific/Tahiti to believe
that I'm on holiday ;-)

> and so behave like other archs with local time RTC. So to resume, what I
> need to fix is:
>
>  - change ppc_md.get/set_rtc_time() to set and return the raw time from
> the RTC
>  - at boot, apply only once the offset from nvram, initialize sys_tz and
> call do_sys_settimeofday()
>  - Figure out a way to write back the timezone to nvram (since I think
> sys_tz is updated by userland tools via settimeofday, isn't it ?) when
> changed.

I'm not sure on this last point, the rest looks fine and correct.

> >Yes, this is strange, but the original error lies with Apple storing the
> >time as local time while keeping also the timezone. I can understand and
> >even agree on keeping the timezone and the DST flag in RAM, but then why
> >the heck do you want to store the RTC in local time ? It only makes thing
> >more complex around DST changes or when changing timezones when you
> >travel. I thought Macs were about simplicity...
>
> Macs are about simplicity, MacOS internals are not ;)

;-) I see...

> >Who uses FAT anyway ? I'm going to patch my kernels to kill sys_tz, now
> >that I've come to the conclusion that its mere existence is an
> >aberration... With an UTC clock, it's the only sensible solution ;-). But
> >I don't suggest that everybody should do the same...
>
> Hum...

Done and booted (although I will probably orphan the changeset).

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
