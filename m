Message-ID: <3FCD52F4.8040009@jonmasters.org>
Date: Wed, 03 Dec 2003 03:05:24 +0000
From: Jon Masters <jonathan@jonmasters.org>
MIME-Version: 1.0
To: Peter Vandenabeele <peter.vandenabeele@mind.be>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: The wonders of 2.4.23 [WAS: Re: [Fwd: ppc4xx Ports]]
References: <3FB416F9.7080303@jonmasters.org> <20031114002023.GA9509@gate.ebshome.net> <3FB423AB.80805@jonmasters.org> <20031114004805.GA9585@gate.ebshome.net> <20031126165238.O7373@mind.be>
In-Reply-To: <20031126165238.O7373@mind.be>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Hi Peter,

I changed kernel versions on my in house working port to 2.4.23 having
spent too long doing:

	* Getting my head around the 405 TLB code in Linux[0].
	* Fixing lots of pointless bits in 2.4.21.

[ The kernel was upgraded to 2.4.21 at some point. ]

So having realised the pointlessness of fixing stuff which is now in
2.4.23 I switched over and magically things are improved[1]. This is
fantastic because I no longer need to fix up the system call handler to
save register number 7 or add in tlbia stuff or many other things.

This kernel also adds fixed TLB entries for serial uart and I finally
decided that a lot of old changes to head_4xx.S were now in the true
stock kernel so I could switch to those instead. I still need to do
kludging for the MSR (!ME here) and cacheing weirdness but hey.

I think we can soon start talking about the stuff we are doing and get
some basic support for 405D PVR, xintc and random other bits in the
stock kernel even if there is not full support for Virtex II Pro.
Finally we can probably do with adding the UTLB errata fixes.

Hopefully it will not be long before I am able to do a lot of this stuff
now that the system I am working on is approaching stability with only
busybox init troubles and a custom distribution I am working on left
prior to the holidays. Hmmm... it is 03:00 now so back to bed.

Anyway here is another happy 2.4.23 user.

Jon.

[0] My copy of UTLK and various other documentation is now completely
covered in pen marks, probably coffee stains etc.

[1] I did track down the problem I was having with floating point which
cunningly turned out not to be a problem with that but with the UTLB
faults following a SHARED page not actually being shared correctly,
generating a later instruction fault on the second access.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
