Return-Path: <jonsmirl@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id A5A53DDEF2
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 00:09:08 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so486126yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 07:09:07 -0700 (PDT)
Message-ID: <9e4733910807230709l4249eaf6m750bad811342ba13@mail.gmail.com>
Date: Wed, 23 Jul 2008 10:09:01 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	"Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH 2/2] Allow a custom ASOC machine driver with
	soc-of-simple
In-Reply-To: <20080723105334.GC8377@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
	<20080723105334.GC8377@sirena.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/23/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Jul 22, 2008 at 07:53:51PM -0400, Jon Smirl wrote:
>
>  > Allow a custom ASOC machine driver with soc-of-simple
>
>
> As with the clocking configuration: this looks fine from an ASoC point
>  of view but please fix the checkpatch warnings.  However...
>
>
>  >       /* Only register the device if both the codec and platform have
>  >        * been registered */
>  > -     if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
>  > +     if ((!of_soc->device.codec_data) || (!of_soc->platform_node) || !machine_name)
>  >               return;
>
>
> ...this doesn't just allow a custom machine driver, it requires that
>  something configures at least the machine name.  That's not a problem
>  from the ASoC point of view but possibly from the PowerPC side?

You have to configure at least the name. Otherwise if the machine
driver is the last to register, how do you know to hold off the final
registration and wait for the machine driver to appear?

Or is it ok for me to change these after the platform device has been created?
		of_soc->dai_link.ops = machine_ops;
		of_soc->machine.name = machine_name;

I have to have the machine driver in order to control my external clock chips.

-- 
Jon Smirl
jonsmirl@gmail.com
