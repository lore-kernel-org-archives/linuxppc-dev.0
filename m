Return-Path: <Matteo.Fortini@mta.it>
Received: from cluster-a.mailcontrol.com (cluster-a.mailcontrol.com
	[85.115.52.190])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.mailcontrol.com",
	Issuer "DigiCert Global CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C9475B6EED
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Dec 2009 22:17:02 +1100 (EST)
Received: from rly11a.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly11a.srv.mailcontrol.com (MailControl) with ESMTP id
	nB3BGm3b030563
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Dec 2009 11:16:57 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly11a.srv.mailcontrol.com (MailControl) id nB3BG8Ck024298
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 3 Dec 2009 11:16:08 GMT
Message-ID: <4B179DF5.90600@mta.it>
Date: Thu, 3 Dec 2009 12:16:05 +0100
From: Fortini Matteo <matteo.fortini@mta.it>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Recommended functions for accessing internal registers
References: <4B1547E5.6050301@mta.it> <1259787475.2076.1160.camel@pasglop>
In-Reply-To: <1259787475.2076.1160.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I'm on an embedded system, so every resource counts.
One of the biggest impacts is when writing to a communication/memory 
access FIFO or reading/writing configurations.
In these cases, I'd just need to make sure that there's no I/O 
reordering and/or subsequent r/w are not optimized away, I believe.

Should I switch to the deprecated "volatile" attribute?

Thank you.

Cheers,
Matteo

Il 02/12/2009 21.57, Benjamin Herrenschmidt ha scritto:
> On Tue, 2009-12-01 at 17:44 +0100, Fortini Matteo wrote:
>    
>> I see that throughout the kernel source, internal PPC registers are
>> accessed through [in|out]_be[32|16|8]() functions. However, they are
>> translated into 3 inline assembly instructions, one of which is an
>> isync, which has a huge performance hit.
>> I tried using readl_be() which seems to be the right function according
>> to the Documentation/ dir, but it is translated directly to in_be32(),
>> so no luck.
>>
>> Is it really necessary to use all those instructions? I know I could use
>> a (volatile u32 *) variable to avoid subsequent read/writes to be
>> optimized out, but it seems to be a deprecated use.
>>      
> There are good reasons why the accessors contain those barriers. What
> are you doing that would be performance critical enough for those to be
> a problem ?
>
> Cheers,
> Ben.
>
>
>    
