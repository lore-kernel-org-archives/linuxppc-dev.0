Message-Id: <v04003a09b7a5d84702e9@[24.70.162.12]>
In-Reply-To: <Pine.LNX.4.05.10108192242020.19135-100000@callisto.of.borg>
References: <v04003a08b7a5cb79017f@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 19 Aug 2001 16:23:45 -0500
To: Geert Uytterhoeven <geert@linux-m68k.org>
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: About TAU (and ICTC)
Cc: "Timothy A. Seufert" <tas@mindspring.com>, mlan@cpu.lu,
	hozer@drgw.net, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 3:43 PM -0500 8/19/2001, Geert Uytterhoeven wrote:
>On Sun, 19 Aug 2001, Tony Mantler wrote:
>> Hmm, I wonder how much thermal-resistive factors would affect this. Y'know,
>> generally when a circuit is warmer, it's resistance increases, and
>> subsequently it gets warmer, etc, so depending on how the curves weigh out
>> (if at all), there might be some hidden power savings in doing calculations
>> cooler and longer rather than warmer and shorter.
>
>Heat is proportional to power dissipation:
>
>    P = UI
>
>while
>
>    I = U/R
>
>So if R increases, I decreases. But then P decreases too and the IC gets
>cooler, hence less resistance. Hmm...

That works for a lightbulb, but remember that what we're really trying to
do inside an IC is to charge a capacitive circuit: the transistor gate.

So if we think of the transistor gate as just a capacitor for a moment,
ignoring the source and drain, we'll need to dump in a certain amount of
energy before it goes from an effective-conductive state to an
effective-nonconductive state (ramping through a psuedo-resistive state
between the two). More input resistance means that the circuit stays in the
psuedo-resistive state longer, meanwhile sending the balance of the energy
out as heat through the input resistance.

Effectively what that translates into is automatically draining more power
to switch the transistor. Of course, more power undeniably means more heat.

Remember that even for the simplest circuit, the voltage:resistance->heat
curve is definatley not linear. (often even having multiple steady states
per voltage:resistance)


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
