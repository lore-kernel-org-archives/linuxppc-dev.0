Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjPdM5ZQ2zDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 20:17:59 +1000 (AEST)
Date: Wed, 7 Jun 2017 12:17:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Geoff Levand <geoff@infradead.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 08/16] powerpc: ps3: use dev_groups and not dev_attrs for
 bus_type
Message-ID: <20170607101751.GA25319@kroah.com>
References: <20170606192221.1617-1-gregkh@linuxfoundation.org>
 <20170606192221.1617-9-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170606192221.1617-9-gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 06, 2017 at 09:22:13PM +0200, Greg Kroah-Hartman wrote:
> The dev_attrs field has long been "depreciated" and is finally being
> removed, so move the driver to use the "correct" dev_groups field
> instead for struct bus_type.
> 
> Cc: Geoff Levand <geoff@infradead.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: <linuxppc-dev@lists.ozlabs.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  arch/powerpc/platforms/ps3/system-bus.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/ps3/system-bus.c b/arch/powerpc/platforms/ps3/system-bus.c
> index 2d2e5f80a3d3..3e98b4ea3df9 100644
> --- a/arch/powerpc/platforms/ps3/system-bus.c
> +++ b/arch/powerpc/platforms/ps3/system-bus.c
> @@ -471,11 +471,13 @@ static ssize_t modalias_show(struct device *_dev, struct device_attribute *a,
>  
>  	return (len >= PAGE_SIZE) ? (PAGE_SIZE - 1) : len;
>  }
> +static DEVICE_ATTR_RO(modalias);
>  
> -static struct device_attribute ps3_system_bus_dev_attrs[] = {
> -	__ATTR_RO(modalias),
> -	__ATTR_NULL,
> +static struct attribute *ps3_system_bus_dev_attrs[] = {
> +	&dev_attr_modalias.attr,
> +	NULL,
>  };
> +ATTRIBUTE_GROUPS(ps3_system_bus);

This should be:
ATTRIBUTE_GROUPS(ps3_system_bus_dev);

I've fixed it up and am now running it through 0-day.

thanks,

greg k-h
