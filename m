Return-Path: <boris.ostrovsky@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 285D21A00E9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 09:21:09 +1000 (AEST)
Message-ID: <55C147DD.7000600@oracle.com>
Date: Tue, 04 Aug 2015 19:16:45 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
MIME-Version: 1.0
To: Julien Grall <julien.grall@citrix.com>, xen-devel@lists.xenproject.org
CC: ian.campbell@citrix.com, stefano.stabellini@eu.citrix.com,
 linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 David Vrabel <david.vrabel@citrix.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 =?UTF-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Wei Liu <wei.liu2@citrix.com>, Juergen Gross <jgross@suse.com>,
 "James E.J. Bottomley" <JBottomley@odin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jslaby@suse.com>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger.kernel.org,
 netdev@vger.kernel.org, linux-scsi@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/8] xen: Use the correctly the Xen memory terminologies
References: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
 <1438711972-18752-5-git-send-email-julien.grall@citrix.com>
In-Reply-To: <1438711972-18752-5-git-send-email-julien.grall@citrix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/04/2015 02:12 PM, Julien Grall wrote:
>   
>   /*
>    * We detect special mappings in one of two ways:
> @@ -217,9 +232,13 @@ static inline unsigned long bfn_to_local_pfn(unsigned long mfn)
>   
>   /* VIRT <-> MACHINE conversion */
>   #define virt_to_machine(v)	(phys_to_machine(XPADDR(__pa(v))))
> -#define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))
>   #define virt_to_mfn(v)		(pfn_to_mfn(virt_to_pfn(v)))
>   #define mfn_to_virt(m)		(__va(mfn_to_pfn(m) << PAGE_SHIFT))
> +#define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))

This looks like unnecessary change.


> diff --git a/drivers/video/fbdev/xen-fbfront.c b/drivers/video/fbdev/xen-fbfront.c
> index 09dc447..25e3cce 100644
> --- a/drivers/video/fbdev/xen-fbfront.c
> +++ b/drivers/video/fbdev/xen-fbfront.c
> @@ -539,7 +539,7 @@ static int xenfb_remove(struct xenbus_device *dev)
>   
>   static unsigned long vmalloc_to_mfn(void *address)
>   {
> -	return pfn_to_mfn(vmalloc_to_pfn(address));
> +	return pfn_to_gfn(vmalloc_to_pfn(address));
>   }

Are you sure? This will return vmalloc_to_pfn(address)).


-boris
