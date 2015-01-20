Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 92F3F1A064E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jan 2015 13:51:43 +1100 (AEDT)
Date: Tue, 20 Jan 2015 09:41:59 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] i2c: drop ancient protection against sysfs refcounting
 issues
Message-ID: <20150120014159.GA3349@kroah.com>
References: <1421693756-12917-1-git-send-email-wsa@the-dreams.de>
 <20150119190142.GA9451@kroah.com>
 <20150119230427.GH26493@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150119230427.GH26493@n2100.arm.linux.org.uk>
Cc: linux-mips@linux-mips.org, Wolfram Sang <wsa@the-dreams.de>,
 Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
 linux-kernel@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>,
 Jean Delvare <jdelvare@suse.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 19, 2015 at 11:04:27PM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 20, 2015 at 03:01:42AM +0800, Greg Kroah-Hartman wrote:
> > On Mon, Jan 19, 2015 at 07:55:56PM +0100, Wolfram Sang wrote:
> > > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > > index 39d25a8cb1ad..15cc5902cf89 100644
> > > --- a/drivers/i2c/i2c-core.c
> > > +++ b/drivers/i2c/i2c-core.c
> > > @@ -41,7 +41,6 @@
> > >  #include <linux/of_device.h>
> > >  #include <linux/of_irq.h>
> > >  #include <linux/clk/clk-conf.h>
> > > -#include <linux/completion.h>
> > >  #include <linux/hardirq.h>
> > >  #include <linux/irqflags.h>
> > >  #include <linux/rwsem.h>
> > > @@ -1184,8 +1183,7 @@ EXPORT_SYMBOL_GPL(i2c_new_dummy);
> > >  
> > >  static void i2c_adapter_dev_release(struct device *dev)
> > >  {
> > > -	struct i2c_adapter *adap = to_i2c_adapter(dev);
> > > -	complete(&adap->dev_released);
> > > +	/* empty, but the driver core insists we need a release function */
> > 
> > Yeah, it does, but I hate to see this in "real" code as something is
> > probably wrong with it if it happens.
> > 
> > Please move the rest of 'i2c_del_adapter' into the release function
> > (what was after the wait_for_completion() call), and then all should be
> > fine.
> 
> Are you sure about that?  Some drivers do this, eg,
> 
>         i2c_del_adapter(&drv_data->adapter);
>         free_irq(drv_data->irq, drv_data);
> 
> where drv_data was allocated using devm_kzalloc(), and so will be
> released when the ->remove callback (which calls the above
> i2c_del_adapter()) returns... freeing the embedded device struct.

But that will fail today if the memory is freed in i2c_del_adapter(), so
there shouldn't be any change in logic here.

Or am I missing something obvious?

thanks,

greg k-h
