Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75CC0DE147
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 00:21:59 +1000 (EST)
Date: Thu, 9 Apr 2009 16:21:42 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] AOA: Convert onyx and tas codecs to new-style i2c   
	drivers
Message-ID: <20090409162142.653decf9@hyperion.delvare>
In-Reply-To: <1239280485.4953.6.camel@johannes.local>
References: <20090408150249.5a62a56c@hyperion.delvare>
	<1239205899.16477.32.camel@johannes.local>
	<20090408224858.04cb6dc4@hyperion.delvare>
	<1239263089.24548.30.camel@johannes.local>
	<20090409141945.116772e3@hyperion.delvare>
	<1239280485.4953.6.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Benjamin, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Takashi Iwai <tiwai@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Johannes,

On Thu, 09 Apr 2009 14:34:44 +0200, Johannes Berg wrote:
> > My new approach doesn't auto-load anything. Here we go, what you think?
> > This time there is no logic change, I'm really only turning legacy code
> > into new-style i2c code (basically calling i2c_new_device() instead of
> > i2c_attach_client()) and that's about it.
> > 
> > (Once again this is only build-tested and I would like people with the
> > hardware to give it a try.)
> 
> Looks reasonable.
> 
> >  static int onyx_create(struct i2c_adapter *adapter,
> >  		       struct device_node *node,
> >  		       int addr)
> >  {
> > +	struct i2c_board_info info;
> > +	struct i2c_client *client;
> > +
> > +	memset(&info, 0, sizeof(struct i2c_board_info));
> > +	strlcpy(info.type, "aoa_codec_onyx", I2C_NAME_SIZE);
> > +	if (node) {
> > +		info.addr = addr;
> > +		info.platform_data = node;
> > +		client = i2c_new_device(adapter, &info);
> > +	} else {
> > +		/* probe both possible addresses for the onyx chip */
> > +		unsigned short probe_onyx[] = {
> > +			0x46, 0x47, I2C_CLIENT_END
> > +		};
> > +
> > +		client = i2c_new_probed_device(adapter, &info, probe_onyx);
> > +	}
> > +	if (!client)
> > +		return -ENODEV;
> > +
> > +	list_add_tail(&client->detected, &client->driver->clients);
> 
> That list_add looks a little hackish, and wouldn't it be racy?

Yes it is a little hackish, the idea is to let i2c-core remove the
device if our i2c_driver is removed (which happens when you rmmod the
module). I'll add a comment to explain that. If there are more use
cases I might move that to a helper function in i2c-core.

No it's not racy, we're called with i2c-core's main mutex held.

> > +static const struct i2c_device_id onyx_i2c_id[] = {
> > +	{ "aoa_codec_onyx", 0 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, onyx_i2c_id);
> 
> Should it really export the device table?
> 
> (same comments for tas)

No, that's a leftover, I intended to remove it but forgot. It's gone
now. That being said, it's useless, but I don't think it would hurt.

> It'll be until mid next week that I can test anything.

OK, thanks.

-- 
Jean Delvare
