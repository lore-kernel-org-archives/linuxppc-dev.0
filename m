From: John Steele Scott <toojays@toojays.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: nearly-working support for cpufreq on 2004 iBook G4 with 7447A cpu
Date: Wed, 2 Jun 2004 20:38:49 +0930
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>
References: <200405302331.35357.toojays@toojays.net> <200405311807.59356.toojays@toojays.net> <1086047232.1930.74.camel@gaston>
In-Reply-To: <1086047232.1930.74.camel@gaston>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200406022039.07672.toojays@toojays.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Tue, 1 Jun 2004 09:17 am, Benjamin Herrenschmidt wrote:
> I suspect that the machine boots at low speed & low voltage. You
> should either set it to high speed in pmac_feature (before bogomips
> calculation) or assume it has booted low speed in your driver. You
> need to ramp up voltage & wait before swiotching to high speed and
> ramp down voltage after switching to low speed.

Okay, I think I've made some progress on this. In the openfirmware device for
the PowerPC,G4 chip, there are methods called set-dfs-low and set-dfs-high.
The first one sets the DFS bit and the seconds one clears it, so the low and
high are referring to low and high CPU speed.

It looks like both methods have a simple check of the PVR, then the main code
for set-dfs-low looks like:
hid1@ 1 1f 9 - lshift or hid1! 1 ms 4 1 gpio

for set-dfs-high it looks like:
5 1 gpio! 1 ms hid1@ 1 1f 9 - lshift andc hid1!

(note that I could have mistaken the numeral '1' for the letter 'l')

So if stop at open firmware, execute set-dfs-high and then boot with a stock
2.6.6 kernel, my cpuinfo now shows a bogomips of 1060.86, and the system
seems to be stable.

I don't know much about manipulating the GPIO stuff, but I guess I will learn
it sometime in the next few days and hopefully get to a fully working patch.

cheers,

John

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
