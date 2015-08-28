Return-Path: <prvs=6759bbf6f=julien.grall@citrix.com>
Received: from SMTP.CITRIX.COM (smtp.citrix.com [66.165.176.89])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 646A01A0541
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2015 01:06:57 +1000 (AEST)
Message-ID: <55E07832.1010802@citrix.com>
Date: Fri, 28 Aug 2015 16:03:14 +0100
From: Julien Grall <julien.grall@citrix.com>
MIME-Version: 1.0
To: David Vrabel <david.vrabel@citrix.com>, <xen-devel@lists.xenproject.org>
CC: Jiri Slaby <jslaby@suse.cz>, <ian.campbell@citrix.com>,
 <stefano.stabellini@eu.citrix.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>, Boris Ostrovsky
 <boris.ostrovsky@oracle.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Xen-devel] [PATCH v3 11/20] tty/hvc: xen: Use xen page definition
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-12-git-send-email-julien.grall@citrix.com>
 <55D5A42E.7070800@citrix.com>
In-Reply-To: <55D5A42E.7070800@citrix.com>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi David,

On 20/08/15 10:55, David Vrabel wrote:
> On 07/08/15 17:46, Julien Grall wrote:
>> The console ring is always based on the page granularity of Xen.
> [...]
>> --- a/drivers/tty/hvc/hvc_xen.c
>> +++ b/drivers/tty/hvc/hvc_xen.c
>> @@ -230,7 +230,7 @@ static int xen_hvm_console_init(void)
>>  	if (r < 0 || v == 0)
>>  		goto err;
>>  	gfn = v;
>> -	info->intf = xen_remap(gfn << PAGE_SHIFT, PAGE_SIZE);
>> +	info->intf = xen_remap(gfn << XEN_PAGE_SHIFT, PAGE_SIZE);
> 
> You need XEN_PAGE_SIZE here I think...

Right, I did the mistake while rebase on my s/mfn/gfn/ series. I will
fix it in the next version.

Regards,

-- 
Julien Grall
