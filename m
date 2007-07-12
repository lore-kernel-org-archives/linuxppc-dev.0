Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3DAA1DDE22
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 06:03:59 +1000 (EST)
Message-ID: <46968960.6090402@genesi-usa.com>
Date: Thu, 12 Jul 2007 21:04:48 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
References: <46951C1A.4080001@genesi-usa.com> <8302.1184178785@neuling.org>
	<46955674.9090304@genesi-usa.com> <29941.1184255383@neuling.org>
In-Reply-To: <29941.1184255383@neuling.org>
Content-Type: text/plain; charset=UTF-8
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
>> Okay.
>>
>> What I didn't want to do is spend a day sifting some other development
>> tree picking out what I think might be possibly sort of the right patches
>> for it.
>>
>> I'd get it wrong because having not worked on it, I don't know what I am
>> even looking for.
>>
>> And I don't want to run -rt or wireless-dev for the benefit of a single
>> feature. What I am after is something like Ingo Molnar throws out..
>> single patches done the old way, not git trees. It's so much easier to
>> handle and integrate for example into a Gentoo ebuild or to make a
>> tarball of accumulated patches from a certain release kernel.
> 
> I'm sooo with ya.  I like my patches alphabetised, but no one ever does
> it for me.

Well my only requirement is numbering them so they patch in order; there
are some cute little requirements on that, but I'd rather patch the bare
minimum and bring in as few quirks and new features than just grab an
entire -rt tree with what amounts to 60 or 70 individual patches and
start renumbering them.

We already have some ~20 for Efika support on top of 2.6.22 including
minor bugfixes and stuff, and the Gentoo genpatches stuff. I really want
to get a good start on CFS, hrtimers, dynticks and so on though and see
if we can push it to users and get out some decent testing and bug
reports. I think it will help everyone if it is not just a feature which
hits mainline after 6 months through supposed maturity (when a lack of
bug reports may well also be down to lack of interest).

I think the Efika as a low-power and fairly average performance board,
would benefit (and does benefit!) from features like dynticks, 5200B
has a bunch of hrtimers, SLUB gave me some insane speed improvement
exactly as the best benchmarks predicted (also got the same under VMware
on my x86 laptop, never going back to SLAB now!). The more processor
time we can eke out, and the less unecessary work the processor does
on housekeeping, the better the board will run for users. Everyone wins :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
