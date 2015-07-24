Return-Path: <prvs=640adc679=david.vrabel@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 005E51A0987
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2015 19:52:46 +1000 (AEST)
Message-ID: <55B20AD0.8050007@citrix.com>
Date: Fri, 24 Jul 2015 10:52:16 +0100
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Julien Grall <julien.grall@citrix.com>, <xen-devel@lists.xenproject.org>
CC: <linux-arm-kernel@lists.infradead.org>, <ian.campbell@citrix.com>,
 <stefano.stabellini@eu.citrix.com>, <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 11/20] tty/hvc: xen: Use xen page definition
References: <1436474552-31789-1-git-send-email-julien.grall@citrix.com>
 <1436474552-31789-12-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1436474552-31789-12-git-send-email-julien.grall@citrix.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/07/15 21:42, Julien Grall wrote:
> The console ring is always based on the page granularity of Xen.
[...]
> --- a/drivers/tty/hvc/hvc_xen.c
> +++ b/drivers/tty/hvc/hvc_xen.c
> @@ -392,7 +392,7 @@ static int xencons_connect_backend(struct xenbus_device *dev,
>  	if (xen_pv_domain())
>  		mfn = virt_to_mfn(info->intf);
>  	else
> -		mfn = __pa(info->intf) >> PAGE_SHIFT;
> +		mfn = __pa(info->intf) >> XEN_PAGE_SHIFT;

Change this to

gfn = xen_page_to_gfn(virt_to_page(info->intf));

and drop the if()?

David
