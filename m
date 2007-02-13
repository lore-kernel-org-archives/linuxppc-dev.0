Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4833DDE10F
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 04:37:47 +1100 (EST)
In-Reply-To: <45D1F46C.4050901@freescale.com>
References: <11710513671236-git-send-email-timur@freescale.com>
	<45CCDEFB.5050504@ru.mvista.com> <45CCDFBC.1090104@freescale.com>
	<45CCE07F.9040107@ru.mvista.com> <45D1F46C.4050901@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5B1BBAE9-00FC-454B-8855-7D362DF59850@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Check mac-address first in fsl_soc.c
Date: Tue, 13 Feb 2007 11:37:04 -0600
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 13, 2007, at 11:25 AM, Timur Tabi wrote:

> Sergei Shtylyov wrote:
>
>>    I'm mainly concerned about 85xx. I guess the needed change  
>> should be very alike...
>
> I've submitted U-Boot patches for 83xx, 85xx, 86xx, and 5xxx to the  
> maintainers.  You'll have to ask them when the patches will be  
> applied.
>
>>> I wanted to keep my patch simple.
>>    That's clearly an over-simplification to repeat the same code  
>> thrice.
>
> Actually, the 2nd and third instances are conditionally compiled,  
> so in most cases only one instance of the code will actually be  
> compiled.  gfar_of_init() should probably also be conditionally  
> compiled, so if I make it a separate function, I'd have to prefix  
> it with something like this:
>
> #if defined(CONFIG_GIANFAR) || defined(CONFIG_CPM2) || defined 
> (CONFIG_8xx)
>
> and then I would need to pass a bunch of parameters.  I don't  
> really think that's an improvement.
>
> Paul, if there are no serious objections, please apply this patch.

Paul asked me to look at this.

I'd ask one style change.

	if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {

How about something like comparing against a local null array  
instead.  Something like:

	u8 null_mac_addr[6] = { 0 };
	if (!mac_addr || (memcmp(mac_addr, null_mac_addr, 6) == 0)) {

- k
