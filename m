Date: Tue, 13 May 2003 14:03:51 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Wolfgang Denk <wd@denx.de>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: set_rtc_time() cleanup / normalization
Message-ID: <20030513120351.GB3868@linux-m68k.org>
References: <20030512211733.B489EC6092@atlas.denx.de> <Pine.GSO.4.21.0305130951230.20323-100000@vervain.sonytel.be> <20030513081817.A25655@mrt-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20030513081817.A25655@mrt-lx1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > On m68k, we removed that part because it confused NTP. Richard Zidlicky can
> > probably tell more about that.

more specific, syncinc systime with NTP could confuse hwclock,
see eg the thread following

http://marc.theaimsgroup.com/?l=linux-kernel&m=100448857801670&w=2

Although workarounds are possible, there are some more reasons
to dislike the hwclk update code in arch/*kernel/time.c:

- RTC should be accessed by proper rtc device driver only
- magic updates may confuse hwclock, adjtimex and other programs,
  some programs need to use workarounds to avoid triggering it.
- everything it does can be done much better by userspace
  accessing /dev/rtc
- implements policy and thus doesn´t belong into kernel
- getting rid of it saves a few clock cycles on every timer
  interrupt
- nobody can positively expect it to work, iirc many HW
  variants were never supported -> nothing can break if
  it is killed


Richard

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
