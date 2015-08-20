Return-Path: <prvs=6671701fa=david.vrabel@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0EEBD1A1D63
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Aug 2015 19:56:20 +1000 (AEST)
Message-ID: <55D5A42E.7070800@citrix.com>
Date: Thu, 20 Aug 2015 10:55:58 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Julien Grall <julien.grall@citrix.com>, <xen-devel@lists.xenproject.org>
CC: <ian.campbell@citrix.com>, <stefano.stabellini@eu.citrix.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, David Vrabel <david.vrabel@citrix.com>,
 "Boris Ostrovsky" <boris.ostrovsky@oracle.com>, Jiri Slaby <jslaby@suse.cz>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Xen-devel] [PATCH v3 11/20] tty/hvc: xen: Use xen page definition
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-12-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438966019-19322-12-git-send-email-julien.grall@citrix.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/08/15 17:46, Julien Grall wrote:
> The console ring is always based on the page granularity of Xen.
[...]
> --- a/drivers/tty/hvc/hvc_xen.c
> +++ b/drivers/tty/hvc/hvc_xen.c
> @@ -230,7 +230,7 @@ static int xen_hvm_console_init(void)
>  	if (r < 0 || v == 0)
>  		goto err;
>  	gfn = v;
> -	info->intf = xen_remap(gfn << PAGE_SHIFT, PAGE_SIZE);
> +	info->intf = xen_remap(gfn << XEN_PAGE_SHIFT, PAGE_SIZE);

You need XEN_PAGE_SIZE here I think...

>  	if (info->intf == NULL)
>  		goto err;
>  	info->vtermno = HVC_COOKIE;
> @@ -472,7 +472,7 @@ static int xencons_resume(struct xenbus_device *dev)
>  	struct xencons_info *info = dev_get_drvdata(&dev->dev);
>  
>  	xencons_disconnect_backend(info);
> -	memset(info->intf, 0, PAGE_SIZE);
> +	memset(info->intf, 0, XEN_PAGE_SIZE);

...particularly since you use it here.

David
