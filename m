Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 98FC7DE089
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 22:38:24 +1000 (EST)
Date: Tue, 15 Jul 2008 16:38:22 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] leds: implement OpenFirmare GPIO LED driver
Message-ID: <20080715123822.GA10893@polina.dev.rtsoft.ru>
References: <20080714164114.GA18784@polina.dev.rtsoft.ru>
	<20080715131004.32646dae.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20080715131004.32646dae.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, Richard Purdie <rpurdie@rpsys.net>,
	linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Stephen,

On Tue, Jul 15, 2008 at 01:10:04PM +1000, Stephen Rothwell wrote:
[...]
> > +	led->np = np;
> 
> You need to take a reference if you are keeping a pointer to a
> device_node, so:
> 	led->np = of_node_get(np);
> 
> > +	led->cdev.name = of_get_property(np, "label", NULL);
> > +	if (!led->cdev.name)
> > +		led->cdev.name = ofdev->dev.bus_id;
> 
> Please use dev_name() in new code:
> 		led->cdev.name = dev_name(&ofdev->dev);
> 
> > +	led->cdev.brightness_set = gpio_led_set;
> > +
> > +	ret = gpio_request(led->gpio, ofdev->dev.bus_id);
> 
> dev_name() again.
> 
> > +err_get_gpio:
> 
> 	of_node_put(led->np);
> 
> > +	kfree(led);
> > +	return ret;
> > +}
> > +
> > +static int __devexit of_gpio_leds_remove(struct of_device *ofdev)
> > +{
> > +	struct of_gpio_led *led = dev_get_drvdata(&ofdev->dev);
> > +
> > +	led_classdev_unregister(&led->cdev);
> > +	cancel_work_sync(&led->work);
> > +	gpio_free(led->gpio);
> > +	of_node_put(led->np);
> 
> This was going to be unbalanced, but is now correct.

Thank you so much for the review, corrected version follows.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
