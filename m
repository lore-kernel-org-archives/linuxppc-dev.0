Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6CE3DDFED
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Apr 2009 19:49:06 +1000 (EST)
Date: Tue, 21 Apr 2009 11:48:53 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Takashi Iwai <tiwai@suse.de>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] keywest: Convert to new-style i2c driver
Message-ID: <20090421114853.7a9d82c1@hyperion.delvare>
In-Reply-To: <s5hzleah5x4.wl%tiwai@suse.de>
References: <20090420225659.7b92a184@hyperion.delvare>
	<18924.63578.495727.152443@cargo.ozlabs.ibm.com>
	<s5hzleah5x4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul, Takashi,

On Tue, 21 Apr 2009 08:33:43 +0200, Takashi Iwai wrote:
> At Tue, 21 Apr 2009 08:34:02 +1000,
> Paul Mackerras wrote:
> > 
> > Jean Delvare writes:
> > 
> > > Takashi, please push this patch to Linus quickly, as this is blocking
> > > the removal of the legacy i2c binding model, which is scheduled for
> > > 2.6.30.
> > 
> > I really don't think you can remove it from Linus' tree at this stage
> > in the 2.6.30 cycle.  If it was going to be removed it should have
> > been removed in the merge window.

It would have happened if the developers/maintainers who see
deprecation warnings when they build their drivers had paid attention
to them. And actually some did, but not all. The remaining drivers are
the ones nobody cared about, and this is the reason why I have to take
care of them myself, that late in the development cycle.

Note that the removal had already been scheduled for 2.6.29, and it did
not happen. The set of legacy drivers did shrink a bit between
2.6.29-rc1 and 2.6.30-rc1 (thanks to Hans Verkuil) but not as much as
it should have. Basically the number of remaining driver was halved. If
the number of remaining drivers is halved with each release cycle, the
legacy model is never going to be removed ;)

> > Removing it now has too much risk
> > of introducing regressions in my opinion.

Not removing it now has a high risk of developers continuing to ignore
the deprecation warnings and adding new legacy drivers, which I then
must convert to the new model. This never ends.

I know my behavior may seem a bit rude, but apparently this is the only
way to get things to actually happen. I've been waiting for over a year
already!

I don't think the risk is that high, at least not for sound drivers.
The conversions are fairly easy and if something really went wrong,
fixing it is a matter of minutes.

Please note that the removal of the legacy model isn't my goal per se.
The fact is that the legacy model needs to be removed for further
developments of i2c-core to happen, in particular the support of i2C
bus multiplexers. There are patches waiting for inclusion since early
February, which I can't take as long as the legacy i2c model is in.
This is why I am pushing.

> > I presume you have a development tree where you queue up commits for
> > the i2c subsystem for the next merge window.  I suggest you do the
> > removal there now (or whenever you like) and push it to Linus in the
> > next merge window.
> 
> At least, the conversion patch Jean posted can be in 2.6.30, I think.
> As the old API is marked deprecated, it should be fixed sooner or
> later.
> 
> Whether to remove the whole old i2c-binding in 2.6.30 is a different
> question, although I myself feel it's feasible.

I have converted all remaining drivers by now:
http://i2c.wiki.kernel.org/index.php/Legacy_drivers_to_be_converted
It's really only a matter of getting them tested in time now. Given
that most drivers are powermac ones, what I really need here is
powermac users/maintainers to test my patches and report success or
failure.

Thanks,
-- 
Jean Delvare
