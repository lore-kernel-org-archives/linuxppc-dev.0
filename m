Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id EAC8ADDF6C
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 02:34:25 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z59so493246pyg.27
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Jul 2008 09:34:24 -0700 (PDT)
Date: Thu, 3 Jul 2008 10:33:51 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/3] ALSA SoC: Add OpenFirmware helper for
	matching bus and codec drivers
Message-ID: <20080703163351.GJ2284@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<9e4733910807020827k115fe63r7a0dd09daffc1895@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807020827k115fe63r7a0dd09daffc1895@mail.gmail.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: liam.girdwood@wolfsonmicro.com, alsa-devel@alsa-project.org,
	broonie@opensource.wolfsonmicro.com, timur@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 02, 2008 at 11:27:17AM -0400, Jon Smirl wrote:
> On 7/1/08, Grant Likely <grant.likely@secretlab.ca> wrote:
> >  +static struct of_snd_soc_device *
> >  +of_snd_soc_get_device(struct device_node *codec_node)
> >  +{
> >  +       struct of_snd_soc_device *of_soc;
> >  +
> >  +       list_for_each_entry(of_soc, &of_snd_soc_device_list, list) {
> >  +               if (of_soc->codec_node == codec_node)
> >  +                       return of_soc;
> >  +       }
> >  +
> >  +       of_soc = kzalloc(sizeof(struct of_snd_soc_device), GFP_KERNEL);
> >  +       if (!of_soc)
> >  +               return NULL;
> >  +
> >  +       /* Initialize the structure and add it to the global list */
> >  +       of_soc->codec_node = codec_node;
> >  +       of_soc->id = of_snd_soc_next_index++;
> >  +       of_soc->machine.dai_link = &of_soc->dai_link;
> >  +       of_soc->machine.num_links = 1;
> >  +       of_soc->device.machine = &of_soc->machine;
> >  +       of_soc->dai_link.ops = &of_snd_soc_ops;
> >  +       list_add(&of_soc->list, &of_snd_soc_device_list);
> >  +
> >  +       return of_soc;
> >  +}
> 
> Isn't this performing the same basic function as this code (except for
> spi)? Should this list be maintained in alsa or should there be an
> equivalent for searching the spi bus? If you follow the link to the
> codec node and get it's parent you know which bus to search. But it
> might be simpler to just search the buses sequentially for the node.
> 
> static int of_dev_node_match(struct device *dev, void *data)
> {
>         return dev->archdata.of_node == data;
> }
> 
> struct i2c_client *of_find_i2c_device_by_node(struct device_node *node)
> {
> 	struct device *dev;
> 	
> 	dev = bus_find_device(&i2c_bus_type, NULL, node,
> 					 of_dev_node_match);
> 	if (!dev)
> 		return NULL;
> 		
> 	return to_i2c_client(dev);
> }
> EXPORT_SYMBOL(of_find_i2c_device_by_node);

Yes, but you hadn't written these functions when I wrote this helper.
:-P.  I believe ASoC v2 makes all this stuff unnecessary, but I'm
waiting for v2 to hit mainline before I port forward.

g.
