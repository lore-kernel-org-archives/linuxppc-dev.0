Date: Sun, 19 Sep 1999 11:54:35 -0500
From: Shaw Terwilliger <sterwill@io.nu>
To: Joseph Garcia <jpgarcia@execpc.com>
Cc: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: patches: MacOS-like Wallstreet sound in/out controls
Message-ID: <19990919115435.A24214@io.nu>
References: <19990919105401.015601@smtp.calvacom.fr> <37E50C29.CA2CE536@execpc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37E50C29.CA2CE536@execpc.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joseph Garcia wrote:
> since we aren't psychics, the daemon should have a configuration and script
> place in /etc (/etc/pmu?).  the config would allow the user to control some
> standard responses on how it acts internally. (like volume control, switching,
> etc)  then the option to do additional things in scripts.  Given the potential
> flexibility people may want, does this mean C is too static, and thus perl or
> another more script-friendly language should be used?

ALSA takes a reasonable approach to this problem; there's a user-space
utility called alsactl that can read a simple configuration file and
apply those values to the hardware or read the settings from the hardware
and write them to a file.  Normally this program is used during startup
and shutdown, to keep mixer settings between them.  A daemon would be
more appropriate for sleep or other PMU events.

Also, does anyone have a solution to my Lombard audio problem?
After a snooze, it comes back up and my audio is gone.  The kernel
driver seems to be there (mixers remember all previous levels and
can set new ones), and user-space access to /dev/dsp and /dev/audio
works, but nothing comes out of the speakers.

-- 
Shaw Terwilliger (sterwill@io.nu)

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
