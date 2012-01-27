Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 9220D1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Jan 2012 03:08:01 +1100 (EST)
Date: Fri, 27 Jan 2012 08:07:58 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/1] carma-fpga: fix race between data dumping and DMA
 callback
Message-ID: <20120127160757.GA23496@ovro.caltech.edu>
References: <1327611614-18508-1-git-send-email-iws@ovro.caltech.edu>
 <1327613137.24487.0.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327613137.24487.0.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 27, 2012 at 08:25:37AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2012-01-26 at 13:00 -0800, Ira W. Snyder wrote:
> > 
> > @@ -970,7 +984,13 @@ static ssize_t data_en_show(struct device *dev, struct device_attribute *attr,
> >                             char *buf)
> >  {
> >         struct fpga_device *priv = dev_get_drvdata(dev);
> > -       return snprintf(buf, PAGE_SIZE, "%u\n", priv->enabled);
> > +       int ret;
> > +
> > +       spin_lock_irq(&priv->lock);
> > +       ret = snprintf(buf, PAGE_SIZE, "%u\n", priv->enabled);
> > +       spin_unlock_irq(&priv->lock);
> > +
> > +       return ret;
> >  } 
> 
> I don't think the lock buys you anything here.
> 

You're right. Feel free to drop the hunk.

Ira

> Cheers,
> Ben.
> 
> 
