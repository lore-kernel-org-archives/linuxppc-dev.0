Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 97E96B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 08:25:42 +1100 (EST)
Message-ID: <1327613137.24487.0.camel@pasglop>
Subject: Re: [PATCH 1/1] carma-fpga: fix race between data dumping and DMA
 callback
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Fri, 27 Jan 2012 08:25:37 +1100
In-Reply-To: <1327611614-18508-1-git-send-email-iws@ovro.caltech.edu>
References: <1327611614-18508-1-git-send-email-iws@ovro.caltech.edu>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-01-26 at 13:00 -0800, Ira W. Snyder wrote:
> 
> @@ -970,7 +984,13 @@ static ssize_t data_en_show(struct device *dev, struct device_attribute *attr,
>                             char *buf)
>  {
>         struct fpga_device *priv = dev_get_drvdata(dev);
> -       return snprintf(buf, PAGE_SIZE, "%u\n", priv->enabled);
> +       int ret;
> +
> +       spin_lock_irq(&priv->lock);
> +       ret = snprintf(buf, PAGE_SIZE, "%u\n", priv->enabled);
> +       spin_unlock_irq(&priv->lock);
> +
> +       return ret;
>  } 

I don't think the lock buys you anything here.

Cheers,
Ben.
