To: John Francis <johnfrancsis@yahoo.com>
Cc: ppcboot-users@lists.sourceforge.net,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: How do I set system wide timezone? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 11 Nov 2001 12:18:22 PST."
             <20011111201822.85707.qmail@web20107.mail.yahoo.com>
Date: Sun, 11 Nov 2001 22:35:53 +0100
Message-Id: <20011111213558.E21A710DD9@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi John,

in message <20011111201822.85707.qmail@web20107.mail.yahoo.com> you wrote:
>
> I have RTC on my board and I am setting clock
> correctly using PPCBoot's date command. I can read it
> back when I am in PPCboot before booting 860's RTC is
> being set to value read from RTC.

I think you know, but just to be sure: PPCBoot does  not  know  about
timezones, so you must set the time in PPCBoot to UTC.

> Now when linux boots the time is way off, but if I
> explicitly set my TZ environment variable, to export
> TZ=PDT the time displayed by linux is also correct.
> But my daemons are still reporting UTC based time.
> Where do I configure the fact that time should be read
> with timzone of PDT ( Pacific Daylight savings). Is
> this something I can pass to the kernel at boot?

This depends on distribution and things like that.

> I tried editing my /etc/rc.sysinit and setting TZ

No. Make sure /etc/localtime is  correct,  and  make  sure  the  boot
scripts  know  that  the  RTC  stores the time in UTC - under RedHat,
check that /etc/sysconfig/clock has a correct entry for  "ZONE",  and
that there is a line "UTC=true".

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The software required `Windows 95 or better', so I installed Linux.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
