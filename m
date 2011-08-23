Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B9A7B6F57
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Aug 2011 05:04:53 +1000 (EST)
Message-ID: <4E53F9CE.1040106@freescale.com>
Date: Tue, 23 Aug 2011 14:04:46 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Kumar Gala
	<galak@kernel.crashing.org>
Subject: Re: [PATCH 8/9] arch/powerpc/sysdev/ehv_pic.c: add missing kfree
References: <1312802283-9107-8-git-send-email-julia@diku.dk>
	<CAOZdJXX_BS7GMtmyqiS91QByhrjANtKpbqrstR8g-L80r_N8qg@mail.gmail.com>
In-Reply-To: <CAOZdJXX_BS7GMtmyqiS91QByhrjANtKpbqrstR8g-L80r_N8qg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kernel-janitors@vger.kernel.org, Julia Lawall <julia@diku.dk>,
	linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben, Kumar, can one of you take a look at my question and help me out?

 wrote:
> On Mon, Aug 8, 2011 at 7:18 AM, Julia Lawall <julia@diku.dk> wrote:
> 
>> diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
>> index af1a5df..b6731e4 100644
>> --- a/arch/powerpc/sysdev/ehv_pic.c
>> +++ b/arch/powerpc/sysdev/ehv_pic.c
>> @@ -280,6 +280,7 @@ void __init ehv_pic_init(void)
>>
>>        if (!ehv_pic->irqhost) {
>>                of_node_put(np);
>> +               kfree(ehv_pic);
>>                return;
>>        }
> 
> Although the fix is correct, I think there is another bug in this
> function.  'np' is not released when the function finishes
> successfully.   I've looked at other functions that use
> irq_alloc_host(), and most of them do the same thing: they don't call
> of_node_put() on the device node pointer.  The only exception I've
> found is mpc5121_ads_cpld_pic_init().
> 
> Ben, Kumar: am I missing something?  irq_alloc_host() calls of_node_get():
> 
> 	host->of_node = of_node_get(of_node);
> 
> so doesn't that mean that the caller of irq_alloc_host() should
> release the device node pointer?
> 


-- 
Timur Tabi
Linux kernel developer at Freescale
