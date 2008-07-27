Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id 77929DDF22
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 14:04:49 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so4716507wfg.15
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jul 2008 21:04:49 -0700 (PDT)
Date: Sat, 26 Jul 2008 19:12:06 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 2/2] Allow a custom ASOC machine driver with soc-of-simple
Message-ID: <20080727011206.GD12191@secretlab.ca>
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080722235351.11648.56387.stgit@terra>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 22, 2008 at 07:53:51PM -0400, Jon Smirl wrote:
> Allow a custom ASOC machine driver with soc-of-simple
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Sorry I didn't respond earlier.  OLS kept me pretty distracted.

Need a more detailed comment block about how your changing things and
why.

> ---
> 
>  include/sound/soc-of-simple.h |    2 ++
>  sound/soc/fsl/soc-of-simple.c |   26 +++++++++++++++++++++-----
>  2 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/include/sound/soc-of-simple.h b/include/sound/soc-of-simple.h
> index 696fc51..1e83f2f 100644
> --- a/include/sound/soc-of-simple.h
> +++ b/include/sound/soc-of-simple.h
> @@ -18,4 +18,6 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
>  				 struct device_node *node,
>  				 struct snd_soc_dai *cpu_dai);
>  
> +void of_snd_soc_register_machine(char *name, struct snd_soc_ops *ops);
> +
>  #endif /* _INCLUDE_SOC_OF_H_ */
> diff --git a/sound/soc/fsl/soc-of-simple.c b/sound/soc/fsl/soc-of-simple.c
> index 0382fda..dd2fa23 100644
> --- a/sound/soc/fsl/soc-of-simple.c
> +++ b/sound/soc/fsl/soc-of-simple.c
> @@ -38,8 +38,8 @@ struct of_snd_soc_device {
>  	struct device_node *codec_node;
>  };
>  
> -static struct snd_soc_ops of_snd_soc_ops = {
> -};
> +static struct snd_soc_ops *machine_ops = NULL;
> +static char *machine_name = NULL;

Doing this prevents multiple instances of this machine driver (which is
exactly what I have on my board).  To register a machine driver it
creates a 3-way bind condition instead of the existing 2-way one.  Right
now it is easy to match up codec and platform drivers because a common
key is available in the device tree.

Alternately, it might be okay to only allow for a single machine driver
that is able to create multiple sound card instances, but this current
code just uses the same name and ops for each registered device.

>  
>  static struct of_snd_soc_device *
>  of_snd_soc_get_device(struct device_node *codec_node)
> @@ -61,7 +61,7 @@ of_snd_soc_get_device(struct device_node *codec_node)
>  	of_soc->machine.dai_link = &of_soc->dai_link;
>  	of_soc->machine.num_links = 1;
>  	of_soc->device.machine = &of_soc->machine;
> -	of_soc->dai_link.ops = &of_snd_soc_ops;
> +	of_soc->dai_link.ops = machine_ops;
>  	list_add(&of_soc->list, &of_snd_soc_device_list);
>  
>  	return of_soc;
> @@ -74,7 +74,7 @@ static void of_snd_soc_register_device(struct of_snd_soc_device *of_soc)
>  
>  	/* Only register the device if both the codec and platform have
>  	 * been registered */
> -	if ((!of_soc->device.codec_data) || (!of_soc->platform_node))
> +	if ((!of_soc->device.codec_data) || (!of_soc->platform_node) || !machine_name)

I'm not thrilled with the hard requirement for a machine driver, but I
see what you're trying to do.  I want to find a clean way to trigger
this behaviour in the device tree without resorting to encoding linux
internal details into the data.  Need to think about this more.

>  		return;
>  
>  	pr_info("platform<-->codec match achieved; registering machine\n");
> @@ -159,7 +159,7 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
>  	of_soc->platform_node = node;
>  	of_soc->dai_link.cpu_dai = cpu_dai;
>  	of_soc->device.platform = platform;
> -	of_soc->machine.name = of_soc->dai_link.cpu_dai->name;
> +	of_soc->machine.name = machine_name;

As mentioned above, either there needs to be multiple machine drivers
or the ability to change the name for each platform--codec pair.

>  
>  	/* Now try to register the SoC device */
>  	of_snd_soc_register_device(of_soc);
> @@ -169,3 +169,19 @@ int of_snd_soc_register_platform(struct snd_soc_platform *platform,
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(of_snd_soc_register_platform);
> +
> +void of_snd_soc_register_machine(char *name, struct snd_soc_ops *ops)
> +{
> +	struct of_snd_soc_device *of_soc;
> +	
> +	machine_name = name;
> +	machine_ops = ops;
> +	
> +	list_for_each_entry(of_soc, &of_snd_soc_device_list, list) {
> +		of_soc->dai_link.ops = machine_ops;
> +		of_soc->machine.name = machine_name;
> +		of_snd_soc_register_device(of_soc);
> +	}
> +
> +}

You need to hold the mutex when manipulating the list.
