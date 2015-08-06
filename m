Return-Path: <prvs=653e5651f=julien.grall@citrix.com>
Received: from SMTP02.CITRIX.COM (smtp02.citrix.com [66.165.176.63])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CDF51A0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 21:18:35 +1000 (AEST)
Message-ID: <55C34250.3040801@citrix.com>
Date: Thu, 6 Aug 2015 12:17:36 +0100
From: Julien Grall <julien.grall@citrix.com>
MIME-Version: 1.0
To: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: <linux-fbdev@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Jiri
 Slaby" <jslaby@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Russell King <linux@arm.linux.org.uk>, <linux-scsi@vger.kernel.org>, "Tomi
 Valkeinen" <tomi.valkeinen@ti.com>, <x86@kernel.org>, Ingo Molnar
 <mingo@redhat.com>, <linux-input@vger.kernel.org>,
 <xen-devel@lists.xenproject.org>, Jean-Christophe Plagniol-Villard
 <plagnioj@jcrosoft.com>, <ian.campbell@citrix.com>, "James E.J. Bottomley"
 <JBottomley@odin.com>, Thomas Gleixner <tglx@linutronix.de>,
 <linux-arm-kernel@lists.infradead.org>, Juergen Gross <jgross@suse.com>,
 "Wei Liu" <wei.liu2@citrix.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 <linux-kernel@vger.kernel.org>, David Vrabel <david.vrabel@citrix.com>,
 <netdev@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 =?windows-1252?Q?Roger_Pau_Monn=E9?= <roger.pau@citrix.com>
Subject: Re: [Xen-devel] [PATCH v2 4/8] xen: Use the correctly the Xen memory
 terminologies
References: <1438711972-18752-1-git-send-email-julien.grall@citrix.com>
 <1438711972-18752-5-git-send-email-julien.grall@citrix.com>
 <55C33E4E.4050704@citrix.com>
 <alpine.DEB.2.02.1508061205190.11337@kaball.uk.xensource.com>
In-Reply-To: <alpine.DEB.2.02.1508061205190.11337@kaball.uk.xensource.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/08/15 12:06, Stefano Stabellini wrote:
> On Thu, 6 Aug 2015, Julien Grall wrote:
>> Hi,
>>
>>
>> On 04/08/15 19:12, Julien Grall wrote:
>>> diff --git a/include/xen/page.h b/include/xen/page.h
>>> index c5ed20b..e7e1425 100644
>>> --- a/include/xen/page.h
>>> +++ b/include/xen/page.h
>>> @@ -3,9 +3,9 @@
>>>  
>>>  #include <asm/xen/page.h>
>>>  
>>> -static inline unsigned long page_to_mfn(struct page *page)
>>> +static inline unsigned long page_to_gfn(struct page *page)
>>>  {
>>> -	return pfn_to_mfn(page_to_pfn(page));
>>> +	return pfn_to_gfn(page_to_pfn(page));
>>>  }
>>
>> I've just noticed that there is a function gfn_to_page used for KVM.
>>
>> Maybe I should rename page_to_gfn to xen_page_to_gfn to avoid confusion
>> with KVM one?
> 
> Yeah, prepending xen would help to avoid namespace pollution.

Will do. May I keep your Reviewed-by for this mechanical change?

Regards,

-- 
Julien Grall
