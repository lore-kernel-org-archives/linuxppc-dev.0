Return-Path: <robert.king@sevis.com>
Received: from mailhost.dallashelpdesk.com (mailhost.dallashelpdesk.com
	[65.99.204.132]) by ozlabs.org (Postfix) with ESMTP id 23FFEDEBAB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Apr 2008 03:44:56 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RTC no longer being updated in 2.6.16...
Date: Tue, 15 Apr 2008 12:29:51 -0500
Message-ID: <9CD384C658DFA3499F06F2D2064FB96843B463@dcsevis03.sevis.com>
From: "Robert King" <robert.king@sevis.com>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Disclaimer: I'm working on a new project here, so I'm not 100% up-to-date=
=20on the system as a whole.

I've been tasked to find out why our RTC clock is not being updated after=
=20suynching with a NTP timesource.  In our previous release, the RTC see=
med to be updated every 11 minutes via the timer_interrupt() ISR.  This n=
o longer seems to be happening.  I have determined that timer_isr() is ru=
nning, but ppc_md.set_rtc_time(xtime.tv_sec+1 + timezone_offset) doesn't =
appear to ever get called.  There are five conditions that must be true f=
or this to be called:

=20  1 - ppc_md.set_rtc_time

this is true.

=20  2 - ntp_synced()

this seems to become true as soon as I sync with my NTP timesource.

=20  3 - xtime.tv_sec - last_rtc_update >=3D 659

this seems to become true within a few secondws of syncing with my timeso=
urce

=20  4 - abs((xtime.tv_nsec / 1000) - (1000000-1000000/HZ)) < 500000/HZ

this seems to be true fairly often

=20  5 - jiffies - wall_jiffies =3D=3D 1

This seems to be true fairly often.

My checks for these conditions are pretty crude.  If one is true, I go in=
to an infinite loop, which eventually kicks off the watchdog timer and th=
e card reboots.  Quick & dirty.

#1 #2, and #3 seem pretty obvious.  #1 checks for the presence of a time =
sync function, #2 checks to see if we have synchronized with an NTP serve=
r, and #3 checks to see of that sync was at least 11 minutes ago.

#4 and #5 I don't understand so much.  I THINK #4 checks to see of we're =
close to a second or half-second boundry (I'm assuming this is becxause o=
f a hardware limitation on the RTC.)  #5 I have no clue about.  It seems =
that wall_jiffies and jiffies are always the same.

My goal is simply to sync the RTC with the system clock, either periodica=
lly or at system shutdown (which is preferred.)  however, I don't have an=
=20RTC driver.  Neither do I have hwclock on this system, so my first sho=
t was getting the 11-minute update working.  If this is the wrong way to =
go, I'm open to suggestions.

-- Robert King
=20  Sevis Systems, Inc.
#########################################################################=
############
This e-mail message has been scanned for Viruses and Content and cleared =

by MailMarshal
#########################################################################=
############
