Date: Mon, 7 Aug 2000 13:51:32 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David Edelsohn <dje@watson.ibm.com>
cc: Takashi Oe <toe@unlserve.unl.edu>, Benjamin Herrenschmidt <bh40@calva.net>,
        Martin Costabel <costabel@wanadoo.fr>, linuxppc-dev@lists.linuxppc.org,
        Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: rtc again... 
In-Reply-To: <200008041525.LAA30014@mal-ach.watson.ibm.com>
Message-ID: <Pine.HPX.4.10.10008071127140.9070-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Aug 2000, David Edelsohn wrote:

> 	On RS/6000 CHRP (RS/6000 Platform Architecture), RTAS provides
> freeze-time-base and thaw-time-base calls which signal all of the
> processors inan SMP complex to stop and start the TB.  I do not know of
> any functionality within the PowerPC architecture which would allow
> processors to coordinate their TBs without some external intervention.
>
> 	Normally AIX boot freezes the TB, zeroes the TB on each processor,
> and then starts the timebase synchronized.  Because the functionality is
> part of RTAS, this can be done at any time.  I do not know what PreP SMP
> systems do and I know that Apple discourages use of RTAS because it is not
> intended to work.

Thanks for the info. AFAIK most (all?) PPC processors have a TBEN pin to
enable the timebase (whether it affects the decrementer or not is
irrelevant). On some chipsets (Motorola Falcon or Hawk at least) a few
bits in a system control register are designated to control these pins
with one bit per processor (although I fail to see why you would want to
enable or disable the timebases individually).

Hard reset also clears the timebase on all the processors I know, so the
time bases should be synchronized unless the firmware plays with them
(assuming the HRESET pins are wired together).

However, all I needed to know is whether the firmware will start the
machine with the timebases synchronized or not. As long as they are, the
patch I suggested should work and give consistent, microsecond resolution
gettimeofday on SMP. Actually only the low 32 bits of the timebase are
used in the current code (even on 64 bit processors BTW) but I'd expect
all 64 bits to be in sync anyway.

The only problem is to know what happens on SMP when a processor enters a
deep low power mode which stops the timebase. Synchronizing again the
timebase is not easy, probably system dependant and I don't have any
system to test it. For now I'll treat it as a `don't do it, then' since
ultimate power saving measures are not necessary in existing SMP systems.

Can anybody with a Macintosh SMP G4 confirm that the time bases are
synchronized at boot ?

	Gabriel
	(still waiting for test results on the patch, including 601 machines).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
