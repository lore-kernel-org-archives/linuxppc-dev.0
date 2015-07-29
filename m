Return-Path: <prvs=645f71718=julien.grall@citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D06271A0894
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 21:36:54 +1000 (AEST)
Message-ID: <55B8BA9A.8000502@citrix.com>
Date: Wed, 29 Jul 2015 12:35:54 +0100
From: Julien Grall <julien.grall@citrix.com>
MIME-Version: 1.0
To: Wei Liu <wei.liu2@citrix.com>
CC: <linux-fbdev@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, <stefano.stabellini@eu.citrix.com>, "Russell
 King" <linux@arm.linux.org.uk>, <linux-scsi@vger.kernel.org>,
 <x86@kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jiri Slaby
 <jslaby@suse.com>, <xen-devel@lists.xenproject.org>, "Jean-Christophe
 Plagniol-Villard" <plagnioj@jcrosoft.com>, <linux-input@vger.kernel.org>,
 <ian.campbell@citrix.com>, "James E.J. Bottomley" <JBottomley@odin.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 <linux-arm-kernel@lists.infradead.org>, Juergen Gross <jgross@suse.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, Dmitry Torokhov
 <dmitry.torokhov@gmail.com>, <linux-kernel@vger.kernel.org>, David Vrabel
 <david.vrabel@citrix.com>, <netdev@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, =?windows-1252?Q?Roger_Pau_Monn=E9?=
 <roger.pau@citrix.com>
Subject: Re: [Xen-devel] [PATCH 4/8] xen: Use the correctly the Xen memory
 terminologies
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
 <1438095769-2560-5-git-send-email-julien.grall@citrix.com>
 <20150729101323.GW5111@zion.uk.xensource.com>
In-Reply-To: <20150729101323.GW5111@zion.uk.xensource.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wei,

On 29/07/15 11:13, Wei Liu wrote:
> On Tue, Jul 28, 2015 at 04:02:45PM +0100, Julien Grall wrote:
> [...]
>> diff --git a/drivers/net/xen-netback/netback.c b/drivers/net/xen-netback/netback.c
>> index 7d50711..3b7b7c3 100644
>> --- a/drivers/net/xen-netback/netback.c
>> +++ b/drivers/net/xen-netback/netback.c
>> @@ -314,7 +314,7 @@ static void xenvif_gop_frag_copy(struct xenvif_queue *queue, struct sk_buff *skb
>>  		} else {
>>  			copy_gop->source.domid = DOMID_SELF;
>>  			copy_gop->source.u.gmfn =
>> -				virt_to_mfn(page_address(page));
>> +				virt_to_gfn(page_address(page));
>>  		}
>>  		copy_gop->source.offset = offset;
>>  
>> @@ -1284,7 +1284,7 @@ static void xenvif_tx_build_gops(struct xenvif_queue *queue,
>>  		queue->tx_copy_ops[*copy_ops].source.offset = txreq.offset;
>>  
>>  		queue->tx_copy_ops[*copy_ops].dest.u.gmfn =
>> -			virt_to_mfn(skb->data);
>> +			virt_to_gfn(skb->data);
>>  		queue->tx_copy_ops[*copy_ops].dest.domid = DOMID_SELF;
>>  		queue->tx_copy_ops[*copy_ops].dest.offset =
>>  			offset_in_page(skb->data);
> 
> Reviewed-by: Wei Liu <wei.liu2@citrix.com>
> 
> One possible improvement is to change gmfn in copy_gop to gfn as well.
> But that's outside of netback code.

The structure gnttab_copy is part of the hypervisor interface. Is it
fine to differ on the naming between Xen and Linux?

Or maybe we could do the change in the public headers in Xen repo too.
Is it fine to do field renaming in public headers?

Regards,

-- 
Julien Grall
