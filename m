Subject: Re: nearly-working support for cpufreq on 2004 iBook G4 with 7447A
	cpu
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: John Steele Scott <toojays@toojays.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	Christiaan Welvaart <cjw@daneel.dyndns.org>
In-Reply-To: <200406022039.07672.toojays@toojays.net>
References: <200405302331.35357.toojays@toojays.net>
	 <200405311807.59356.toojays@toojays.net> <1086047232.1930.74.camel@gaston>
	 <200406022039.07672.toojays@toojays.net>
Content-Type: text/plain
Message-Id: <1086301583.1838.39.camel@gaston>
Mime-Version: 1.0
Date: Fri, 04 Jun 2004 08:26:24 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2004-06-02 at 21:08, John Steele Scott wrote:

> I don't know much about manipulating the GPIO stuff, but I guess I will learn
> it sometime in the next few days and hopefully get to a fully working patch.

GPIO just means "general purpose IO", it's just IO bits hanging out of
the KeyLargo chipsets and connected to various things on the motherboard,
in that case, one is connected to the power supply controller to control
the power to the CPU.

Look at the cpufreq code for gpios_set_cpuspeed(), it's used on models
were both the clock frequency and the voltage are controller by GPIOs,
keep the voltage part. Remember to ramp up the voltage before setting
the frequency to high, and ramp it down after setting the frequency to
low.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
