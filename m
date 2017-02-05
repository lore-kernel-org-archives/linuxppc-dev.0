Return-Path: <hmurray@megapathdsl.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGGPq5xGzzDqC2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Feb 2017 14:32:31 +1100 (AEDT)
Received: from ip-64-139-1-69.sjc.megapath.net
 (ip-64-139-1-69.sjc.megapath.net [64.139.1.69])
 by ozlabs.org (Postfix) with ESMTP id 3vGGPq1HjJz9s70
 for <linuxppc-dev@ozlabs.org>; Sun,  5 Feb 2017 14:32:28 +1100 (AEDT)
To: Fred Wright <fw@fwright.net>
cc: linuxppc-dev@ozlabs.org, devel@ntpsec.org,
	hmurray@megapathdsl.net
From: Hal Murray <hmurray@megapathdsl.net>
Subject: Re: Timekeeping oddities on MacMini G4s
In-Reply-To: Message from Fred Wright <fw@fwright.net> of "Sat,
 04 Feb 2017 16:19:00 PST."
 <Pine.LNX.4.58L1X.1702041524560.6886@bolt.sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 04 Feb 2017 19:32:24 -0800
Message-Id: <20170205033224.F0773406061@ip-64-139-1-69.sjc.megapath.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks.

fw@fwright.net said:
> That seems inconsistent with the following comment in arch/powerpc/kernel/
> time.c:

>  * TODO (not necessarily in this file):
>  * - improve precision and reproducibility of timebase frequency
>  * measurement at boot time. 

I didn't see any calibration code, but I could easily have missed it.  I'd 
expect it to print the result, and I haven't found that either.

> Or by the OS, if the comment is to be believed.  It would be interesting to
> check OF values guaranteed to come directly from OF. 

>> I rebooted several times.  It always got the exact same clock speed numbers.
> Most likely not runtime calibration, then.

I've checked the OF numbers quite a few times before boot.  They are also available after boot as /proc/device-tree/cpus/PowerPC,G4@0/
Unless I patch something, they have always been the same value.

----------

More data...

I have 3 Mac minis.  They came from eBay.  (Without trying, I ended up with 3 different CPU speeds: 1.25, 1.42, and 1.5.)

I think the system bus runs at 166 MHz and the time keeping register runs at 1/4 of that.
That would be 41.5.

I have a hack that reads that register and prints out the time and register value every minute.  I'm assuming that ntpd is running and stepping the clock to keep time close-enough.  If I average over a long enough time, I should be able to compute the actual frequency of that register.

I did that.  I got 41.501276.  I told Open Firmware to use that number.  Happyness.  I haven't gone back to verify that 41.5 without the low digits works correctly and get the actual drift.

On the second system, I just started with 41.5.  More happyness.  That was FreeBSD.

It didn't work on the 3rd system.  (I think that's the same one the caused the troubles reported on the first message in this thread.)  With a bit of trial and error, 41.6215 is within 5 ppm.  But my program that measures the frequency prints out 41.501338  That's averaged over 20 hours.  The last few digits wobble around.

I have no idea how 41.625 turns into 41.5  Does anybody else?
Is there anything I should look for and/or any experiments I should run to collect more data?

I think I'll go back and repeat things with more careful notes.

-----------

I think the 1.416 is correct.  (rather than 1.42)

1.25 is 7.5 * 166.666
1.416 is 8.5 * 166.666
1.5 is 9 * 166.666

-------

There is a potential problem in this area.  166.666 is really 6 nanoseconds.  But you order crystals by frequency rather than cycle time.  So the crystal is probably 166 or 166.6 depending on how many digits the order form had.  Maybe 167 or 166.7 if somebody rounded up.  But maybe they wouldn't round up because that might push something over a timing spec.  Mumble.  If it were easier to take apart, I'd look inside to see if I could find the crystal and see what was printed on it.

0.666 out of 166 is 4000 ppm.  That's the right ballpark but I don't see anything that matches close enough to explain any of my observations.  166.6 is 400 ppm which ntpd should be able to handle.

Does anybody know the actual frequency of the crystal on a Mac mini?  (It could easily be some sub-multiple.)

166 / 4 is 41.5 which matches what I measured.
166.6 / 4 is 41.65  That's 2800 ppm from 41.5, but only 720 ppm from 41.62

There is also the possibility of one of the EMI clock spreading chips.  I think I saw one data sheet that said 1/2% and 30 KHz.  (I think the PCI specs were updated to allow that.  The parameters are important if you are using a PLL chip to make a zero-delay clock buffer.)  I haven't seen any numbers that would support that.

--------

Shortly after I started working at Xerox way back in 1976, Ed Taft put out a new version of the operating system for the Alto.  It tweaked the magic timekeeping constant.  The Alto was designed to run at 170 ns.  The crystal was 5.88 MHz.  The original software had derived the constant from 170 ns which is 5.882352 rather than 5.88.  If I did the math right, that's 400 ppm or 30 seconds per day.  That's not enough to notice if you only watch for a few minutes but easy to catch if you watch for several hours.


-- 
These are my opinions.  I hate spam.
