Return-Path: <mls.JOFT@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 2A205DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  5 Aug 2007 18:00:18 +1000 (EST)
Subject: Re: ML403 / ALSA driver for AC97 Controller
From: Joachim =?ISO-8859-1?Q?F=F6rster?= <mls.JOFT@gmx.de>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40707211317q47b12a38jbe05e4d2c89767f4@mail.gmail.com>
References: <1185047879.15040.34.camel@localhost>
	<fa686aa40707211317q47b12a38jbe05e4d2c89767f4@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 05 Aug 2007 10:00:13 +0200
Message-Id: <1186300813.5534.33.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant,

On Sat, 2007-07-21 at 14:17 -0600, Grant Likely wrote:
> A few initial comments:
> 1. You should post this code as a patch against the kernel tree.
> Links to tarballs are not the best way to get code reviewed.  Post
> your patches to both the ALSA and linuxppc-dev mailing lists.
> 2. (get this out of the way quickly) Coding standard doesn't match the
> kernel (indent w/ tabs, keep lines < 80 chars, etc).  You should run
> your code through 'scripts/Lindent' in the kernel tree.  That will
> sort out many of the whitespace issues.
> 3. In the same vein, c++ style comments need to be scrubbed.
> 4. Do not directly include xparameters.h in your driver.  The driver
> should get it's data from the platform bus registration (of the
> of_device registration when we move to arch/powerpc).
> 5. struct 'platform_device devices[]' needs to be moved to
> arch/ppc/sysdev/virtex_devices.c

About a week ago I finished work on the last four issues and in last
days I created several patches against different kernel trees. ATM I
have three patches, against:

tag v2.6.22 (Linus)
branch master (Linus)
branch virtex-dev (your v2.6.22 based branch)

I had to make different patches, because one version didn't apply
cleanly to the other branches, due to differences in a Kconfig file e.g.
and above all in the virtex_devices.c file.

Now, my question is: Which one should I post to the mailing list? (after
testing these patches - I haven't got a chance yet to test them on real
hardware - compilation is ok).

One more thing: I made two parts, one patch adds the driver and the
other one makes the registration with the platform bus. Is this ok? (I
saw this scheme in your virtex-dev branch.)

> 6. Have you looked into the new ALSA infrastructure which separates
> Codecs from controllers (in sound/soc)?  It might be a good idea to go
> that route for this driver.

Meanwhile, I had a _very_ short look into ASoC ... and I don't really
know ... My driver already uses the AC97 Layer of ALSA, so in some way
the codec is already separated from the controller. Xilinx' AC97
Controller Reference does have some very bad impact on the codec which
forced me to implement codec register shadowing ... hmmmm, I have to
look at it (ASoC) again - as soon as there is more (free)time ...

 Joachim
