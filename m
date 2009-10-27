Return-Path: <Matteo.Fortini@mta.it>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9F499B7BB9
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 21:02:59 +1100 (EST)
Received: from rly11a.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly11a.srv.mailcontrol.com (MailControl) with ESMTP id
	n9RA2qm7022270
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 10:02:53 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly11a.srv.mailcontrol.com (MailControl) id n9RA2Foe019796
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Oct 2009 10:02:15 GMT
Message-ID: <4AE6C51F.9050203@mta.it>
Date: Tue, 27 Oct 2009 11:02:07 +0100
From: Fortini Matteo <matteo.fortini@mta.it>
MIME-Version: 1.0
To: Kenneth Johansson <kenneth@southpole.se>
Subject: Re: Acceleration for map_copy_from on powerpc 512x
References: <4ADC1AAD.60606@mta.it> <1256135453.22238.27.camel@kenjo-laptop>
In-Reply-To: <1256135453.22238.27.camel@kenjo-laptop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The simple_map_init() works at a higher level, what I'm redefining is a 
function called by mtd->read()

The block size for e.g. a dd if=/dev/mtd0 of=/dev/null
with the default block size (I believe it's 512Bytes), fetches from 
/dev/mtd0 4096 Bytes at a time.
I'd prefer the kernel to be scheduling other tasks meanwhile, instead of 
busy-waiting on completion.

Regards

Kenneth Johansson ha scritto:
> On Mon, 2009-10-19 at 09:52 +0200, Fortini Matteo wrote:
>
>   
>> I didn't find a cleaner way than just #ifdef'ing the map_copy_from call 
>> and substitute with my call on relevant cases. I wonder if there is a 
>> cleaner way.
>>     
>
> Remove the call to simple_map_init() and do it manually in your driver
> with your own functions.
>
>   
>> And yes, as soon as I've cleaned up the code a little bit, I will 
>> definitely post a patch about it.
>>
>> Moreover: a huge benefit would come from exploiting DMA on these 
>> transfers, 
>>     
>
> probably depends on the block size if it's a gain or not. What is the
> size you normally see. 
>
>
>   
