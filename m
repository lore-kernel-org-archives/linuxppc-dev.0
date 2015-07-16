Return-Path: <prvs=632e2375c=Stefano.Stabellini@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E09331A075F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 01:49:10 +1000 (AEST)
Date: Thu, 16 Jul 2015 16:36:53 +0100
From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
To: Julien Grall <julien.grall@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-arm-kernel@lists.infradead.org>,
 <ian.campbell@citrix.com>, <stefano.stabellini@eu.citrix.com>,
 <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, David Vrabel
 <david.vrabel@citrix.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 11/20] tty/hvc: xen: Use xen page definition
In-Reply-To: <1436474552-31789-12-git-send-email-julien.grall@citrix.com>
Message-ID: <alpine.DEB.2.02.1507161636470.17378@kaball.uk.xensource.com>
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-12-git-send-email-julien.grall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 9 Jul 2015, Julien Grall wrote:
> The console ring is always based on the page granularity of Xen.
> 
> Signed-off-by: Julien Grall <julien.grall@citrix.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: David Vrabel <david.vrabel@citrix.com>
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: linuxppc-dev@lists.ozlabs.org

Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

>  drivers/tty/hvc/hvc_xen.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/hvc/hvc_xen.c b/drivers/tty/hvc/hvc_xen.c
> index a9d837f..2135944 100644
> --- a/drivers/tty/hvc/hvc_xen.c
> +++ b/drivers/tty/hvc/hvc_xen.c
> @@ -230,7 +230,7 @@ static int xen_hvm_console_init(void)
>  	if (r < 0 || v == 0)
>  		goto err;
>  	mfn = v;
> -	info->intf = xen_remap(mfn << PAGE_SHIFT, PAGE_SIZE);
> +	info->intf = xen_remap(mfn << XEN_PAGE_SHIFT, XEN_PAGE_SIZE);
>  	if (info->intf == NULL)
>  		goto err;
>  	info->vtermno = HVC_COOKIE;
> @@ -392,7 +392,7 @@ static int xencons_connect_backend(struct xenbus_device *dev,
>  	if (xen_pv_domain())
>  		mfn = virt_to_mfn(info->intf);
>  	else
> -		mfn = __pa(info->intf) >> PAGE_SHIFT;
> +		mfn = __pa(info->intf) >> XEN_PAGE_SHIFT;
>  	ret = gnttab_alloc_grant_references(1, &gref_head);
>  	if (ret < 0)
>  		return ret;
> @@ -476,7 +476,7 @@ static int xencons_resume(struct xenbus_device *dev)
>  	struct xencons_info *info = dev_get_drvdata(&dev->dev);
>  
>  	xencons_disconnect_backend(info);
> -	memset(info->intf, 0, PAGE_SIZE);
> +	memset(info->intf, 0, XEN_PAGE_SIZE);
>  	return xencons_connect_backend(dev, info);
>  }
>  
> -- 
> 2.1.4
> 
