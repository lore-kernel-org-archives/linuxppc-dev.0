Return-Path: <fw@fwright.net>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vGBM42F4NzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Feb 2017 11:29:52 +1100 (AEDT)
Received: from c.mail.sonic.net (c.mail.sonic.net [64.142.111.80])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vGBM35qGGz9ryQ
 for <linuxppc-dev@ozlabs.org>; Sun,  5 Feb 2017 11:29:51 +1100 (AEDT)
Date: Sat, 4 Feb 2017 16:19:00 -0800 (PST)
From: Fred Wright <fw@fwright.net>
To: linuxppc-dev@ozlabs.org, devel@ntpsec.org
Subject: Re: Timekeeping oddities on MacMini G4s
In-Reply-To: <20170201075630.3E8FB406061@ip-64-139-1-69.sjc.megapath.net>
Message-ID: <Pine.LNX.4.58L1X.1702041524560.6886@bolt.sonic.net>
References: <20170201075630.3E8FB406061@ip-64-139-1-69.sjc.megapath.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Tue, 31 Jan 2017, Hal Murray wrote:

> benh@kernel.crashing.org said:
> > Right, we just use the value provided by Open Firmware. Any chance you can

That seems inconsistent with the following comment in
arch/powerpc/kernel/time.c:

 * TODO (not necessarily in this file):
 * - improve precision and reproducibility of timebase frequency
 * measurement at boot time.

Unless it's an outdated comment that nobody bothered to remove.

> > From the value in the properties you showed me (and the ones I have in some
> > DT snapshots) it looks like the value isn't fixed but somewhat calibrated by
> > Open Firmware during boot.

Or by the OS, if the comment is to be believed.  It would be interesting
to check OF values guaranteed to come directly from OF.

Runtime calibration often has issues of its own.  For example, on x86, the
kernel likes to calibrate the TSC against the RTC at boot time.  But if an
SMI intervenes during the calibration loop (which is not prevented by
disabling interrupts), it throws the calibration so badly out of whack
that the system can't keep time properly until it's rebooted.  At Google,
we had to disable ECC-related SMIs on at least one server model for that
reason.

When you think about it, the manufacturer knows perfectly well the
nominal frequency of the crystal being stuffed, and is also programming
onboard nonvolatile memory (typically EEPROM) with various parameters, so
directly reporting the nominal frequency should be much more reliable than
trying to measure it in a short test at boot time.  And detecting that
it's reported incorrectly should be the job of a diagnostic, not an OS.

One would, of course, like to base timekeeping on the *actual* frequency
rather than the nominal frequency, but measuring that accurately enough to
be useful takes longer than one would like to spend in early startup,
especially if the only accurate time source is Internet-based NTP.  The
RTC is *not* good enough for this purpose, since *its* crystal has its own
errors.

> I rebooted several times.  It always got the exact same clock speed numbers.

Most likely not runtime calibration, then.

> I don't know anything about the insides of the PowerPC chip.  Can you confirm
> that the kernel time keeping works off an always ticking register similar to
> the Intel TSC and uses the timebase-frequency as the scale factor?

That's certainly the way it's normally done on PowerPC, and a cursory
examination of the sources looks consistent with that.  The PowerPC
timebase is a 64-bit free-running counter.  Unlike the TSC, it's not
per-core.  On the plus side, that means that the values are guaranteed not
to be core-specific.  On the minus side, it means that its count rate is
lower, and it's sufficiently "distant" that accessing it is somewhat more
expensive.

The PowerPC architecture permits the timebase frequency to be variable,
but I'm not aware of any implementations that take advantage of that.  The
Motorola 32-bit implementations in general run it on the "bus clock",
which is independent of processor-clock multipliers, and is also common
across processor chips in systems with more than one.  The IBM 970 (G5)
runs it on the "mesh clock".  That can change frequencies, but by factors
of two which are accounted for in the way that the timebase counts, making
it effectively constant rate.

> If so, I should be able to "fix" it from Open Firmware.  I tried that but
> things got worse.  I could easily have fatfingered something but more likely
> my reasoning for computing the right value was buggy.  I guess I'll try again.

You are aware, aren't you, that frequency errors reported by NTPd have the
wrong sign?  I.e., a negative value in the driftfile means that the
frequency of your local clock oscillator is too high.  I imagine it's too
late to fix that now, by decades.

> I see that powerpc/kernel/time.c reads both timebase-frequency and
> clock-frequency, but doesn't seem to use clock-frequency.  Was that just a
> handy place to read it that got called before anybody else needed it?

Perhaps there's some way that it's reported to humans.

On Tue, 31 Jan 2017, Hal Murray wrote:
> benh@kernel.crashing.org said:
> > Ok, I do have one though somewhere with OS X on it. If you give me
> > instructions on how to test (I know near to nothing about ntpsec), I should
> > be able to compile and run it.
>
> I'm assuming you are already running the normal ntpd from ntp classic, or
> Apple's version of it.

Or perhaps the one from MacPorts, which is close to the ntp.org version.

> ntpq -c "rv 0 frequency" <host-name, defaults to localhost>
> will get you the fudge-factor that ntpd passes to the kernel to get
> the clock ticking accurately.  Units are parts-per-million.

And three decimal places is at least two too few if you're using a
rubidium-based frequency reference. :-)

> The problem that started this is that it's off by more than 500 ppm.  If all
> the arithmetic and documentation is correct, it should be the crystal error.
> A few or few 10s of ppm is reasonable at normal temperature.  Over 50 is a
> bit strange, but anything under 100 is within normal.  Over 100 is getting
> suspicious but could easily be due to some round off someplace.

Generally, yes.  Tolerances on run-of-the-mill crystals are usually 100ppm
or better, with 50 being quite common.  I imagine that the 500ppm limit is
intended as a fairly loose sanity check, on the theory that if it's that
far off, it's unclear whether it's due to frequency confusion or general
brokenness.

> If you want to try ntpsec...
>
> git clone git@gitlab.com:NTPsec/ntpsec.git xxx
> cd xxx
> ./waf configure build check
>
> I think it builds cleanly on OS-X, but I can't verify that.

Only on the very latest version (10.12 "Sierra").  Otherwise, the build
fails because the clock_gettime/clock_settime fallback code is broken in
multiple ways.  Since the last PPC-compatible OSX was 10.5, this would be
a no go by seven major versions.

Fred Wright
