Return-Path: <prvs=645aa2f63=wei.liu2@citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BEA81A0BBE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 20:24:14 +1000 (AEST)
Date: Wed, 29 Jul 2015 11:13:24 +0100
From: Wei Liu <wei.liu2@citrix.com>
To: Julien Grall <julien.grall@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <ian.campbell@citrix.com>,
 <stefano.stabellini@eu.citrix.com>, <linux-kernel@vger.kernel.org>, "Russell
 King" <linux@arm.linux.org.uk>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 "David Vrabel" <david.vrabel@citrix.com>, Thomas Gleixner
 <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>, "H. Peter Anvin"
 <hpa@zytor.com>, <x86@kernel.org>, Roger Pau =?iso-8859-1?Q?Monn=E9?=
 <roger.pau@citrix.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wei Liu
 <wei.liu2@citrix.com>, Juergen Gross <jgross@suse.com>, "James E.J.
 Bottomley" <JBottomley@odin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Jiri Slaby" <jslaby@suse.com>, Jean-Christophe
 Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen
 <tomi.valkeinen@ti.com>, <linux-input@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-fbdev@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 4/8] xen: Use the correctly the Xen memory terminologies
Message-ID: <20150729101323.GW5111@zion.uk.xensource.com>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 28, 2015 at 04:02:45PM +0100, Julien Grall wrote:
[...]
> diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
> index 7d50711..3b7b7c3 100644
> --- a/drivers/net/xen-netback/netback.c
> +++ b/drivers/net/xen-netback/netback.c
> @@ -314,7 +314,7 @@ static void xenvif_gop_frag_copy(struct xenvif_queue *queue, struct sk_buff *skb
>  		} else {
>  			copy_gop->source.domid = DOMID_SELF;
>  			copy_gop->source.u.gmfn =
> -				virt_to_mfn(page_address(page));
> +				virt_to_gfn(page_address(page));
>  		}
>  		copy_gop->source.offset = offset;
>  
> @@ -1284,7 +1284,7 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
>  		queue->tx_copy_ops[*copy_ops].source.offset = txreq.offset;
>  
>  		queue->tx_copy_ops[*copy_ops].dest.u.gmfn =
> -			virt_to_mfn(skb->data);
> +			virt_to_gfn(skb->data);
>  		queue->tx_copy_ops[*copy_ops].dest.domid = DOMID_SELF;
>  		queue->tx_copy_ops[*copy_ops].dest.offset =
>  			offset_in_page(skb->data);

Reviewed-by: Wei Liu <wei.liu2@citrix.com>

One possible improvement is to change gmfn in copy_gop to gfn as well.
But that's outside of netback code.

Wei.
