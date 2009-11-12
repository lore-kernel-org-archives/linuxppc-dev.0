Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 84987B7BAD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 12 Nov 2009 23:10:40 +1100 (EST)
Date: Thu, 12 Nov 2009 12:10:34 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/6] ASoC/mpc5200: get rid of the appl_ptr
	tracking nonsense
Message-ID: <20091112121034.GA16661@rakim.wolfsonmicro.main>
References: <20091107083358.18908.10635.stgit@angua>
	<9e4733910911070451y28073dbeke6ced6246f5a5c24@mail.gmail.com>
	<fa686aa40911071051y3cf63e55ibe7fbc65c30bd15e@mail.gmail.com>
	<20091107201233.GC31789@sirena.org.uk>
	<9e4733910911110838w6010cf3atcfcd30c85f0764a1@mail.gmail.com>
	<20091111183753.GA31815@rakim.wolfsonmicro.main>
	<fa686aa40911111124i12b72196xdba7000b13b3bdc@mail.gmail.com>
	<9e4733910911111334o24f3114as6baaef82d7b17a05@mail.gmail.com>
	<fa686aa40911111357q22f57728va1b4bc8b5bc0425f@mail.gmail.com>
	<9e4733910911111513w5423333cp6cf08ceec9a94ac3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910911111513w5423333cp6cf08ceec9a94ac3@mail.gmail.com>
Cc: John Bonesio <bones@secretlab.ca>, alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 11, 2009 at 06:13:25PM -0500, Jon Smirl wrote:

> I don't think it is that much more work for ALSA to provide an
> accessible field indicating the end of valid data. It's already
> tracking appl_ptr. Appl_ptr just needs to be translated into a
> physical DMA buffer address and we've been making mistakes doing that
> translation.

I'm sure if you provide reasonable patches they'll get applied; it
doesn't seem likely that anyone else will work on this.

> On Wed, Nov 11, 2009 at 4:57 PM, Grant Likely <grant.likely@secretlab.ca> wrote

> > But it still wouldn't help a bit when the same latency occurs in the
> > middle of playback.

> The deterministic solution of tracking the end of valid data ensures
> that under run will be silent instead of playing invalid data.

In the middle of playback a sudden silence period is very noticable -
applications that expect data loss generally have some means to try to
cover it up since sudden silence is so noticable to the human ear.  Mid
playback there's a bit more chance that random data from earlier in the
playback will be acceptable, and if the application has actually updated
the data but not got round to telling the driver about that yet then
even better.

I think you're getting too focused on the fact that there is a race
condition here since the consequences of race conditions are usually so
severe.  There's always going to be some hardware for which there's a
degree of racyness (free running hardware has its own set of issues
here) so the system design takes this into account.
