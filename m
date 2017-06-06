Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wj1y20ZB8zDqNX
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 05:31:06 +1000 (AEST)
Date: Tue, 6 Jun 2017 21:30:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Vineet Gupta <vgupta@synopsys.com>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
 Johan Hovold <johan@kernel.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Krzysztof Kozlowski <krzk@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 10/16] powerpc: vio: use dev_groups and not dev_attrs for
 bus_type
Message-ID: <20170606193058.GA2497@kroah.com>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
 <20170606192221.1617-11-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170606192221.1617-11-gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 06, 2017 at 09:22:15PM +0200, Greg Kroah-Hartman wrote:
> The dev_attrs field has long been "depreciated" and is finally being
> removed, so move the driver to use the "correct" dev_groups field
> instead for struct bus_type.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: <linuxppc-dev@lists.ozlabs.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/powerpc/platforms/pseries/vio.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
> index 28b09fd797ec..fd6595598662 100644
> --- a/arch/powerpc/platforms/pseries/vio.c
> +++ b/arch/powerpc/platforms/pseries/vio.c
> @@ -1537,6 +1537,7 @@ static ssize_t name_show(struct device *dev,
>  {
>  	return sprintf(buf, "%s\n", to_vio_dev(dev)->name);
>  }
> +static DEVICE_ATTR_RO(name);
>  
>  static ssize_t devspec_show(struct device *dev,
>  		struct device_attribute *attr, char *buf)
> @@ -1545,6 +1546,7 @@ static ssize_t devspec_show(struct device *dev,
>  
>  	return sprintf(buf, "%s\n", of_node_full_name(of_node));
>  }
> +static DEVICE_ATTR_RO(devspec);
>  
>  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  			     char *buf)
> @@ -1566,6 +1568,7 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
>  
>  	return sprintf(buf, "vio:T%sS%s\n", vio_dev->type, cp);
>  }
> +static DEVICE_ATTR_RO(modalias);
>  
>  static struct device_attribute vio_dev_attrs[] = {
>  	__ATTR_RO(name),
> @@ -1573,6 +1576,13 @@ static struct device_attribute vio_dev_attrs[] = {
>  	__ATTR_RO(modalias),
>  	__ATTR_NULL
>  };
> +static struct attribute *vio_dev_attrs[] = {

Hm, this feels wrong, odd that 0-day passed it.  I should be deleting
the above vio_dev_attrs field as well.  Is powerpc really a dead
platform?  :)

thanks,

greg k-h
