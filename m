Return-Path: <khali@linux-fr.org>
Received: from bamako.nerim.net (bamako.nerim.net [62.4.17.28])
	by ozlabs.org (Postfix) with ESMTP id 30E22B7BC2
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Oct 2009 20:35:25 +1100 (EST)
Date: Sun, 4 Oct 2009 11:35:21 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH] sound: Don't assume i2c device probing always succeeds
Message-ID: <20091004113521.6a0c1dbb@hyperion.delvare>
In-Reply-To: <s5hiqezk3lg.wl%tiwai@suse.de>
References: <20090930152542.3ef753ee@hyperion.delvare>
	<s5hbpksy0yq.wl%tiwai@suse.de>
	<20090930170006.76e145ca@hyperion.delvare>
	<s5h4oqkxy3e.wl%tiwai@suse.de>
	<20090930185505.1261e183@hyperion.delvare>
	<s5hiqezk3lg.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Johannes Berg <johannes@sipsolutions.net>,
	Tim Shepard <shep@alum.mit.edu>, alsa-devel@alsa-project.org,
	Jaroslav Kysela <perex@perex.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Takashi,

On Thu, 01 Oct 2009 08:52:59 +0200, Takashi Iwai wrote:
> At Wed, 30 Sep 2009 18:55:05 +0200,
> Jean Delvare wrote:
> > 
> > On Wed, 30 Sep 2009 17:15:49 +0200, Takashi Iwai wrote:
> > > Yes, indeed I prefer NULL check because the user can know the error
> > > at the right place.  I share your concern about the code addition,
> > > though :)
> > > 
> > > I already made a patch below, but it's totally untested.
> > > It'd be helpful if someone can do review and build-test it.
> > > 
> > > 
> > > thanks,
> > > 
> > > Takashi
> > > 
> > > ---
> > > diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
> > > index f0ebc97..0f810c8 100644
> > > --- a/sound/aoa/codecs/tas.c
> > > +++ b/sound/aoa/codecs/tas.c
> > > @@ -897,6 +897,10 @@ static int tas_create(struct i2c_adapter *adapter,
> > >  	client = i2c_new_device(adapter, &info);
> > >  	if (!client)
> > >  		return -ENODEV;
> > > +	if (!client->driver) {
> > > +		i2c_unregister_device(client);
> > > +		return -ENODEV;
> > > +	}
> > >  
> > >  	/*
> > >  	 * Let i2c-core delete that device on driver removal.
> > > diff --git a/sound/ppc/keywest.c b/sound/ppc/keywest.c
> > > index 835fa19..473c5a6 100644
> > > --- a/sound/ppc/keywest.c
> > > +++ b/sound/ppc/keywest.c
> > > @@ -59,6 +59,13 @@ static int keywest_attach_adapter(struct i2c_adapter *adapter)
> > >  	strlcpy(info.type, "keywest", I2C_NAME_SIZE);
> > >  	info.addr = keywest_ctx->addr;
> > >  	keywest_ctx->client = i2c_new_device(adapter, &info);
> > > +	if (!keywest_ctx->client)
> > > +		return -ENODEV;
> > > +	if (!keywest_ctx->client->driver) {
> > > +		i2c_unregister_device(keywest_ctx->client);
> > > +		keywest_ctx->client = NULL;
> > > +		return -ENODEV;
> > > +	}
> > >  	
> > >  	/*
> > >  	 * Let i2c-core delete that device on driver removal.
> > 
> > This looks good to me. Please add the following comment before the
> > client->driver check in both drivers:
> > 
> > 	/*
> > 	 * We know the driver is already loaded, so the device should be
> > 	 * already bound. If not it means binding failed, and then there
> > 	 * is no point in keeping the device instantiated.
> > 	 */
> > 
> > Otherwise it's a little difficult to understand why the check is there.
> 
> Fair enough.  I applied the patch with the comment now.
> Thanks!

I see this is upstream now. While the keywest fix was essentially
theoretical, the tas one addresses a crash which really could happen,
so I think it would be worth sending to stable for 2.6.31. What do you
think? Will you take care, or do you want me to?

Thanks,
-- 
Jean Delvare
