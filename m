Return-Path: <jonsmirl@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.234])
	by ozlabs.org (Postfix) with ESMTP id AFA11DDF59
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 14:44:09 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so3180751wra.1
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 21:44:08 -0700 (PDT)
Message-ID: <9e4733910807262144l7be98192l95dd526bf08e0434@mail.gmail.com>
Date: Sun, 27 Jul 2008 00:44:07 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] Allow a custom ASOC machine driver with soc-of-simple
In-Reply-To: <20080727011206.GD12191@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
	<20080727011206.GD12191@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 7/26/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> On Tue, Jul 22, 2008 at 07:53:51PM -0400, Jon Smirl wrote:
>
> > Allow a custom ASOC machine driver with soc-of-simple
>  >
>  > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
>
>
> Sorry I didn't respond earlier.  OLS kept me pretty distracted.
>
>  Need a more detailed comment block about how your changing things and
>  why.
>
>
>  > ---
>  >
>  >  include/sound/soc-of-simple.h |    2 ++
>  >  sound/soc/fsl/soc-of-simple.c |   26 +++++++++++++++++++++-----
>  >  2 files changed, 23 insertions(+), 5 deletions(-)
>  >
>  > diff --git a/include/sound/soc-of-simple.h b/include/sound/soc-of-simple.h
>  > index 696fc51..1e83f2f 100644
>  > --- a/include/sound/soc-of-simple.h
>  > +++ b/include/sound/soc-of-simple.h
>  > @@ -18,4 +18,6 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
>  >                                struct device_node *node,
>  >                                struct snd_soc_dai *cpu_dai);
>  >
>  > +void of_snd_soc_register_machine(char *name, struct snd_soc_ops *ops);
>  > +
>  >  #endif /* _INCLUDE_SOC_OF_H_ */
>  > diff --git a/sound/soc/fsl/soc-of-simple.c b/sound/soc/fsl/soc-of-simple.c
>  > index 0382fda..dd2fa23 100644
>  > --- a/sound/soc/fsl/soc-of-simple.c
>  > +++ b/sound/soc/fsl/soc-of-simple.c
>  > @@ -38,8 +38,8 @@ struct of_snd_soc_device {
>  >       struct device_node *codec_node;
>  >  };
>  >
>  > -static struct snd_soc_ops of_snd_soc_ops = {
>  > -};
>  > +static struct snd_soc_ops *machine_ops = NULL;
>  > +static char *machine_name = NULL;
>
>
> Doing this prevents multiple instances of this machine driver (which is
>  exactly what I have on my board).  To register a machine driver it
>  creates a 3-way bind condition instead of the existing 2-way one.  Right
>  now it is easy to match up codec and platform drivers because a common
>  key is available in the device tree.
>
>  Alternately, it might be okay to only allow for a single machine driver
>  that is able to create multiple sound card instances, but this current
>  code just uses the same name and ops for each registered device.
>
We need to call them fabric drivers since we already have machine
drivers in arch/.... It is too confusing.

My fabric driver was getting probed after the rest of ASOC bound,
that's why I had to add the third condition.

An important feature for me is the ability to compile in multiple
fabric drivers and then get the right one selected based on the
machine name in the device tree.  I'm doing via my machine driver.

Could we dynamically build an OF fabric device entry with a compatible
string like this: compatible="machinename-fabric,generic-fabric"
Now a hard requirement for a fabric driver is ok since one of those
two will load for sure. generic-fabric is just a do nothing driver
that is always built in.

/* Trigger the platform specific ASOC driver to load */
static struct platform_device platform = {
        .name           = "dspeak01-fabric",
        .id             = -1,
};

static struct platform_device *devices[] = {
        &platform,
};

static void __init digispeaker_declare_platform_devices(void)
{
        mpc52xx_declare_of_platform_devices();
        platform_add_devices(&devices[0], ARRAY_SIZE(devices));
}

define_machine(digispeaker_platform) {
        .name           = "dspeak01",
        .probe          = digispeaker_probe,
        .setup_arch     = digispeaker_setup_arch,
        .init           = digispeaker_declare_platform_devices,
        .init_IRQ       = mpc52xx_init_irq,
        .get_irq        = mpc52xx_get_irq,
        .restart        = mpc52xx_restart,
        .calibrate_decr = generic_calibrate_decr,
};


>
>  >
>  >  static struct of_snd_soc_device *
>  >  of_snd_soc_get_device(struct device_node *codec_node)
>  > @@ -61,7 +61,7 @@ of_snd_soc_get_device(struct device_node *codec_node)
>  >       of_soc->machine.dai_link = &of_soc->dai_link;
>  >       of_soc->machine.num_links = 1;
>  >       of_soc->device.machine = &of_soc->machine;
>  > -     of_soc->dai_link.ops = &of_snd_soc_ops;
>  > +     of_soc->dai_link.ops = machine_ops;
>  >       list_add(&of_soc->list, &of_snd_soc_device_list);
>  >
>  >       return of_soc;
>  > @@ -74,7 +74,7 @@ static void of_snd_soc_register_device(struct of_snd_soc_device *of_soc)
>  >
>  >       /* Only register the device if both the codec and platform have
>  >        * been registered */
>  > -     if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
>  > +     if ((!of_soc->device.codec_data) || (!of_soc->platform_node) || !machine_name)
>
>
> I'm not thrilled with the hard requirement for a machine driver, but I
>  see what you're trying to do.  I want to find a clean way to trigger
>  this behaviour in the device tree without resorting to encoding linux
>  internal details into the data.  Need to think about this more.
>
>
>  >               return;
>  >
>  >       pr_info("platform<-->codec match achieved; registering machine\n");
>  > @@ -159,7 +159,7 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
>  >       of_soc->platform_node = node;
>  >       of_soc->dai_link.cpu_dai = cpu_dai;
>  >       of_soc->device.platform = platform;
>  > -     of_soc->machine.name = of_soc->dai_link.cpu_dai->name;
>  > +     of_soc->machine.name = machine_name;
>
>
> As mentioned above, either there needs to be multiple machine drivers
>  or the ability to change the name for each platform--codec pair.
>
>
>  >
>  >       /* Now try to register the SoC device */
>  >       of_snd_soc_register_device(of_soc);
>  > @@ -169,3 +169,19 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
>  >       return rc;
>  >  }
>  >  EXPORT_SYMBOL_GPL(of_snd_soc_register_platform);
>  > +
>  > +void of_snd_soc_register_machine(char *name, struct snd_soc_ops *ops)
>  > +{
>  > +     struct of_snd_soc_device *of_soc;
>  > +
>  > +     machine_name = name;
>  > +     machine_ops = ops;
>  > +
>  > +     list_for_each_entry(of_soc, &of_snd_soc_device_list, list) {
>  > +             of_soc->dai_link.ops = machine_ops;
>  > +             of_soc->machine.name = machine_name;
>  > +             of_snd_soc_register_device(of_soc);
>  > +     }
>  > +
>  > +}
>
>
> You need to hold the mutex when manipulating the list.
>


-- 
Jon Smirl
jonsmirl@gmail.com
