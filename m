Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f196.google.com (mail-yw0-f196.google.com
	[209.85.211.196]) by ozlabs.org (Postfix) with ESMTP id 28749B7D27
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 13:44:17 +1000 (EST)
Received: by ywh34 with SMTP id 34so7898651ywh.17
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 20:44:16 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <1272501411.24542.125.camel@pasglop>
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop> <1272355624.3204.52.camel@odin>
	<g2mfa686aa41004271324g8ff0d67fi3df4336cb25e9acc@mail.gmail.com>
	<20100427222913.GE15083@opensource.wolfsonmicro.com>
	<1272427811.24542.59.camel@pasglop>
	<20100428120719.GE31400@opensource.wolfsonmicro.com>
	<1272501411.24542.125.camel@pasglop>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 28 Apr 2010 21:43:55 -0600
Message-ID: <w2ofa686aa41004282043y97738d60o94aaed133b645682@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/2] powerpc: add platform registration for
	ALSA SoC drivers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>,
	Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 28, 2010 at 6:36 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2010-04-28 at 13:07 +0100, Mark Brown wrote:
>> > The device-tree helps keep the platform .c file simple and devoid of too
>> > horrible hacks, it allows to easily pass various configuration data to
>> > leaf drivers such as i2c thingies, PHY devices etc... without gross
>> > hooks between these and the platform, but the platform code still has
>> > the upper hand for doing ad-hoc bits and pieces (or overwriting the
>> > device-tree based behaviour) if necessary.
>>
>> Once again, if you can get the device tree guys to buy into this and
>> stick with it that sounds good but my experience has been that this
>> isn't where any of these discussions end up.
>
> Well, as the person who came up with the flattened device-tree format in
> the first place I suppose I qualify as a "device-tree" guy here :-)
>
> At the moment, I'd say Grant (and to some extent Jeremy Kerr) are the
> guys in charge though, but yes, I agree with you, there's a tendency to
> be too over-exited and to want to do "too much" with the DT and that is
> counter productive. It's a good tool but it's not going to solve world
> hunger and in some places an ad-hoc bit of C code is a better option :)
>
> Now, I don't think Grant is totally off the tracks here but I must admit
> I haven't taken the time to ensure I understand perfectly everybody's
> position in that debate. At least I made mine clear, hope this helps :-)

After an IRC conversation with Timur, I think we've pretty much sorted
out the best way to handle the mpc8610 use case that allows the
ssi/dma/codec drivers to remain blissfully ignorant and bind in the
appropriate ASoC machine driver for the board.

g.
