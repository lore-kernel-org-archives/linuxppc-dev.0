Return-Path: <prvs=65203c0ee=julien.grall@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3EA1D1A0787
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Aug 2015 20:51:59 +1000 (AEST)
Message-ID: <55C1EA95.5060504@citrix.com>
Date: Wed, 5 Aug 2015 11:51:01 +0100
From: Julien Grall <julien.grall@citrix.com>
MIME-Version: 1.0
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 <xen-devel@lists.xenproject.org>
CC: <linux-fbdev@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Jiri
 Slaby" <jslaby@suse.com>, <stefano.stabellini@eu.citrix.com>, Russell King
 <linux@arm.linux.org.uk>, <linux-scsi@vger.kernel.org>, <x86@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>, <linux-input@vger.kernel.org>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 <ian.campbell@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 "James E.J. Bottomley" <JBottomley@odin.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 <linux-arm-kernel@lists.infradead.org>, Juergen Gross <jgross@suse.com>,
 "Wei Liu" <wei.liu2@citrix.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 <linux-kernel@vger.kernel.org>, David Vrabel <david.vrabel@citrix.com>,
 <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 =?windows-1252?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [PATCH v2 4/8] xen: Use the correctly the Xen memory terminologies
References: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
 <1438711972-18752-5-git-send-email-julien.grall@citrix.com>
 <55C147DD.7000600@oracle.com>
In-Reply-To: <55C147DD.7000600@oracle.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Boris,

On 05/08/15 00:16, Boris Ostrovsky wrote:
> On 08/04/2015 02:12 PM, Julien Grall wrote:
>>     /*
>>    * We detect special mappings in one of two ways:
>> @@ -217,9 +232,13 @@ static inline unsigned long
>> bfn_to_local_pfn(unsigned long mfn)
>>     /* VIRT <-> MACHINE conversion */
>>   #define virt_to_machine(v)    (phys_to_machine(XPADDR(__pa(v))))
>> -#define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))
>>   #define virt_to_mfn(v)        (pfn_to_mfn(virt_to_pfn(v)))
>>   #define mfn_to_virt(m)        (__va(mfn_to_pfn(m) << PAGE_SHIFT))
>> +#define virt_to_pfn(v)          (PFN_DOWN(__pa(v)))
> 
> This looks like unnecessary change.

Right, I made the mistake when I re-introduced virt_to_mfn in this
version. It was dropped in the previous one.

>> diff --git a/drivers/video/fbdev/xen-fbfront.c
>> b/drivers/video/fbdev/xen-fbfront.c
>> index 09dc447..25e3cce 100644
>> --- a/drivers/video/fbdev/xen-fbfront.c
>> +++ b/drivers/video/fbdev/xen-fbfront.c
>> @@ -539,7 +539,7 @@ static int xenfb_remove(struct xenbus_device *dev)
>>     static unsigned long vmalloc_to_mfn(void *address)
>>   {
>> -    return pfn_to_mfn(vmalloc_to_pfn(address));
>> +    return pfn_to_gfn(vmalloc_to_pfn(address));
>>   }
> 
> Are you sure? This will return vmalloc_to_pfn(address)).

I guess you mean vmalloc_to_mfn will return vmalloc_to_pfn?

If so, it will be only the case on auto-translated case (because pfn ==
gfn). In the case of PV, the mfn will be returned.

Although, this function is misnamed. It's fixed in a follow-up patch
(see #6) because it's required more renaming than this function. I
didn't want to add such changes within this patch.

Regards,

-- 
Julien Grall
