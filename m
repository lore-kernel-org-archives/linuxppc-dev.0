Date: Tue, 8 Aug 2000 19:55:09 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: rtc again...
In-Reply-To: <20000808174157.21374@mailhost.mipsys.com>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000808194747.24030A-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 8 Aug 2000, Benjamin Herrenschmidt wrote:

>  - The second one is that ppc_md.get/set_rtc_time are passed (or return)
> a time value independently of the timezone. That mean that they either do
> no conversion and so it's the responsibility of the caller to "know" if
> the RTC is in local time or UTC, or they do the conversion and so return
> (and get passed) an UTC time. That's what I decided to do, so on
> PowerMac, they do the adjustement from UTC to localtime and the opposite
> inside those functions. Paul recently added code to also save the
> timezone to the xpram. There's a small semantic problem with this code,
> since it takes the time to set to the RTC as a parameter but uses the
> global sys_tz. It should either use no parameter (and use only xtime/
> sys_tz), or be passed both parameters. In this case, we can probably move
> the init code that reads the initial time zone to the pmac_get_rtc_time() too.

Personally, I think UTC <-> local time conversion should be handled in
userland.  Both hwclock and clock can handle both local time and UTC just
fine.

Does Mac OS handle different timezone information in xpram well?  Timezone
information is saved in xpram but it's also saved in some of config files.
So, it appears to me that Mac OS will get confused or ignore or delete the
timezone setting in xpram if it doesn't agree with the config file.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
