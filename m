Subject: Re: nearly-working support for cpufreq on 2004 iBook G4 with 7447A
	cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>
In-Reply-To: <200405311807.59356.toojays@toojays.net>
References: <200405302331.35357.toojays@toojays.net>
	 <200405311003.21439.toojays@toojays.net> <1085975390.1930.31.camel@gaston>
	 <200405311807.59356.toojays@toojays.net>
Content-Type: text/plain
Message-Id: <1086047232.1930.74.camel@gaston>
Mime-Version: 1.0
Date: Tue, 01 Jun 2004 09:47:12 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Oh, and when switching to high speed, think about tweaking the
voltage too. I don't know if it's high or low when setting the
GPIO bit, you may want to check out OF code, it certainly have
methods for that. Or you can read the voltage value back from
the adt themometer chip I think, as it does voltage control.

(see cpu-vcore-select GPIO)

I suspect that the machine boots at low speed & low voltage. You
should either set it to high speed in pmac_feature (before bogomips
calculation) or assume it has booted low speed in your driver. You
need to ramp up voltage & wait before swiotching to high speed and
ramp down voltage after switching to low speed.

The delay is unknown, I suppose 100ms should be plenty enough though
(probably even too much).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
