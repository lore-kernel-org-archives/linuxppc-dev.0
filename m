Mime-Version: 1.0
Message-Id: <p04330101b6314aae3036@[192.168.0.1]>
In-Reply-To: <19340929061924.29978@192.168.1.10>
References: <p04330100b629527c3036@[192.168.0.1]>
 <19340929061924.29978@192.168.1.10>
Date: Fri, 10 Nov 2000 01:58:18 -0500
To: Benjamin Herrenschmidt <bh40@calva.net>, <linuxppc-dev@lists.linuxppc.org>
From: Stefan Jeglinski <jeglin@4pi.com>
Subject: Re: whacked out 2.2.18pre17? [partly solved]
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The problems were:

1: BootX no-video checkbox was being overridden, with twin turbo
video acceleration always turned on, regardless of checkbox setting.

2. 2.2.18pre17-18 never finished booting. Rsyncing each night led to
a different boot failure.


I now know how to work around #1. I have 2 video cards installed, a
Twin Turbo and a Matrox Mystique. It turns out that the kernel must
have support for -both- cards compiled in. If both are, then the
BootX no-video switch is -obeyed-. What I had done though was to stop
compiling in the matrox card, because it is never discovered during
boot, as measured by dmesg. Somewhere along the way, I forgot that I
quit compiling it in <oops>.

I don't know -why- this is true. But I'm pretty sure it didn't used
to be the case that I -had- to compile both drivers in.

As far as #2 goes, a rebuild of 2.2.18pre18 each night still fails on
boot, in a variety of ways previously noted:

	a) freeze at "booting..."
	b) can't find MAC address for MACE device -> kernel panic
	c) "machine check in kernel mode" -> "unknown values in srr1" ->
		kernel panic

a and c are now most prevalent. Haven't seen the MACE error for a few days.


Stefan Jeglinski

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
