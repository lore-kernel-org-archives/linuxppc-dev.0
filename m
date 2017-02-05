Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGmqZ0pRvzDqBV
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Feb 2017 10:23:06 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vGmqY4GYrz9ryr
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2017 10:23:05 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v15NIiC0120257
 for <linuxppc-dev@ozlabs.org>; Sun, 5 Feb 2017 18:23:03 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28d8qrj7uy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Sun, 05 Feb 2017 18:23:03 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@au1.ibm.com>;
 Mon, 6 Feb 2017 09:23:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 643AA2CE8046
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Feb 2017 10:22:58 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v15NMoPN34734270
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Feb 2017 10:22:58 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v15NMQZd020295
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Feb 2017 10:22:26 +1100
Subject: Re: Timekeeping oddities on MacMini G4s
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Fred Wright <fw@fwright.net>, linuxppc-dev@ozlabs.org, devel@ntpsec.org
Date: Mon, 06 Feb 2017 10:22:01 +1100
In-Reply-To: <Pine.LNX.4.58L1X.1702041524560.6886@bolt.sonic.net>
References: <20170201075630.3E8FB406061@ip-64-139-1-69.sjc.megapath.net>
 <Pine.LNX.4.58L1X.1702041524560.6886@bolt.sonic.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1486336921.4850.74.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-02-04 at 16:19 -0800, Fred Wright wrote:
> On Tue, 31 Jan 2017, Hal Murray wrote:
> 
> > > benh@kernel.crashing.org said:
> > > Right, we just use the value provided by Open Firmware. Any chance you can
> 
> That seems inconsistent with the following comment in
> arch/powerpc/kernel/time.c:
> 
>  * TODO (not necessarily in this file):
>  * - improve precision and reproducibility of timebase frequency
>  * measurement at boot time.

That comment is probably ancient ;-) Different platforms use different
methods of calculating or obtaining the TB freq within arch/powerpc.

The most common however for anything recent is to just pick the value
from the device-tree. However, I noticed that MacOS X does "calibrate"
it using the timers provided by the KeyLargo chip.

> Unless it's an outdated comment that nobody bothered to remove.
> 
> > > From the value in the properties you showed me (and the ones I have in some
> > > DT snapshots) it looks like the value isn't fixed but somewhat calibrated by
> > > Open Firmware during boot.
> 
> Or by the OS, if the comment is to be believed.  It would be interesting
> to check OF values guaranteed to come directly from OF.

We don't change the DT values. Looking at some old dumps of Apple OF implementation
I have lying around it appears that the timebase either come from some specific
configuration area of the flash or some very early boot asm calibration.

> Runtime calibration often has issues of its own.  For example, on x86, the
> kernel likes to calibrate the TSC against the RTC at boot time.  But if an
> SMI intervenes during the calibration loop (which is not prevented by
> disabling interrupts), it throws the calibration so badly out of whack
> that the system can't keep time properly until it's rebooted.  At Google,
> we had to disable ECC-related SMIs on at least one server model for that
> reason.

Right. We don't have SMIs on Power and we can probably make sure we disable
(or catch & retry) things like Machine Checks. So we can make it slightly
more accurate.

> When you think about it, the manufacturer knows perfectly well the
> nominal frequency of the crystal being stuffed, and is also programming
> onboard nonvolatile memory (typically EEPROM) with various parameters, so
> directly reporting the nominal frequency should be much more reliable than
> trying to measure it in a short test at boot time.  And detecting that
> it's reported incorrectly should be the job of a diagnostic, not an OS.

Right. On recent POWER servers it's architected. The core always sees 512Mhz,
though I don't know how precise that is (see below).

> One would, of course, like to base timekeeping on the *actual* frequency
> rather than the nominal frequency, but measuring that accurately enough to
> be useful takes longer than one would like to spend in early startup,
> especially if the only accurate time source is Internet-based NTP.  The
> RTC is *not* good enough for this purpose, since *its* crystal has its own
> errors.
> 
> > I rebooted several times.  It always got the exact same clock speed numbers.
> 
> Most likely not runtime calibration, then.

Yup

> > I don't know anything about the insides of the PowerPC chip.  Can you confirm
> > that the kernel time keeping works off an always ticking register similar to
> > the Intel TSC and uses the timebase-frequency as the scale factor?
> 
> That's certainly the way it's normally done on PowerPC, and a cursory
> examination of the sources looks consistent with that.  The PowerPC
> timebase is a 64-bit free-running counter.  Unlike the TSC, it's not
> per-core.

Actually it is, see below :-)

>   On the plus side, that means that the values are guaranteed not
> to be core-specific.  On the minus side, it means that its count rate is
> lower, and it's sufficiently "distant" that accessing it is somewhat more
> expensive.

Right so there are various configuration options and ways to feed the timebase
to PowerPC chips depending on the generation and manufacturer. On the old
32-bit chips, typically it was either a divisor of the bus frequency or
externally clocked. Apple typically used the latter.

However there was always an architectural requirement that it was perfectly
synchronized between cores.

On IBM POWER chips since P6 at least, there's a unit in the chip called the
ChipTOD that provides a reference clock to all the cores at a 16th of the
timebase frequency iirc.

There's a special protocol to slave the TODs of secondary chips to the primary
along with an automatic fallback to a backup network in case of failure.

The cores feed the top bits of the TB from that. The bottom bits are locally
generated by each core in such a way that guarantees that the TB can never
be observed going backward.

> The PowerPC architecture permits the timebase frequency to be variable,
> but I'm not aware of any implementations that take advantage of that.

I think it's pretty much accepted that this would be a very bad idea
and no implementation did it.

>   The
> Motorola 32-bit implementations in general run it on the "bus clock",
> which is independent of processor-clock multipliers, and is also common
> across processor chips in systems with more than one.

There's also a TBEN external pin iirc which can be used to feed it.

>   The IBM 970 (G5)
> runs it on the "mesh clock".  That can change frequencies, but by factors
> of two which are accounted for in the way that the timebase counts, making
> it effectively constant rate.
>
> > If so, I should be able to "fix" it from Open Firmware.  I tried that but
> > things got worse.  I could easily have fatfingered something but more likely
> > my reasoning for computing the right value was buggy.  I guess I'll try again.
> 
> You are aware, aren't you, that frequency errors reported by NTPd have the
> wrong sign?  I.e., a negative value in the driftfile means that the
> frequency of your local clock oscillator is too high.  I imagine it's too
> late to fix that now, by decades.
> 
> > I see that powerpc/kernel/time.c reads both timebase-frequency and
> > clock-frequency, but doesn't seem to use clock-frequency.  Was that just a
> > handy place to read it that got called before anybody else needed it?
> 
> Perhaps there's some way that it's reported to humans.

Yup, it's the default for /proc/cpuinfo in absence of a dedicated cpufreq driver
for the platform.

> On Tue, 31 Jan 2017, Hal Murray wrote:
> > > benh@kernel.crashing.org said:
> > > Ok, I do have one though somewhere with OS X on it. If you give me
> > > instructions on how to test (I know near to nothing about ntpsec), I should
> > > be able to compile and run it.
> >
> > I'm assuming you are already running the normal ntpd from ntp classic, or
> > Apple's version of it.
> 
> Or perhaps the one from MacPorts, which is close to the ntp.org version.
> 
> > ntpq -c "rv 0 frequency" <host-name, defaults to localhost>
> > will get you the fudge-factor that ntpd passes to the kernel to get
> > the clock ticking accurately.  Units are parts-per-million.
> 
> And three decimal places is at least two too few if you're using a
> rubidium-based frequency reference. :-)
> 
> > The problem that started this is that it's off by more than 500 ppm.  If all
> > the arithmetic and documentation is correct, it should be the crystal error.
> > A few or few 10s of ppm is reasonable at normal temperature.  Over 50 is a
> > bit strange, but anything under 100 is within normal.  Over 100 is getting
> > suspicious but could easily be due to some round off someplace.
> 
> Generally, yes.  Tolerances on run-of-the-mill crystals are usually 100ppm
> or better, with 50 being quite common.  I imagine that the 500ppm limit is
> intended as a fairly loose sanity check, on the theory that if it's that
> far off, it's unclear whether it's due to frequency confusion or general
> brokenness.
> 
> > If you want to try ntpsec...
> >
> > > git clone git@gitlab.com:NTPsec/ntpsec.git xxx
> > cd xxx
> > ./waf configure build check
> >
> > I think it builds cleanly on OS-X, but I can't verify that.
> 
> Only on the very latest version (10.12 "Sierra").  Otherwise, the build
> fails because the clock_gettime/clock_settime fallback code is broken in
> multiple ways.  Since the last PPC-compatible OSX was 10.5, this would be
> a no go by seven major versions.
> 
> Fred Wright
