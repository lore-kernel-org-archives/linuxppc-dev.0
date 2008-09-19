Return-Path: <chretien@enseirb.fr>
Received: from plan.enseirb.fr (plan.enseirb.fr [147.210.18.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8B43DE349
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 03:49:22 +1000 (EST)
Message-ID: <48D3E5BF.6000809@enseirb.fr>
Date: Fri, 19 Sep 2008 19:47:43 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?= <chretien@enseirb.fr>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: ioremap and vmalloc
References: <319b0ac50809190415g6d132058l9bb8521046502eab@mail.gmail.com>	<20080919134933.GA7849@secretlab.ca>
	<48D3D47E.5050200@gmail.com>	<20080919163819.GB4492@yoda.jdub.homelinux.org>	<48D3D70D.3060404@enseirb.fr>	<20080919165833.GD4492@yoda.jdub.homelinux.org>
	<fa686aa40809191012q76d1c450ye12094ac63bc68a7@mail.gmail.com>
In-Reply-To: <fa686aa40809191012q76d1c450ye12094ac63bc68a7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I made a mistake. The right code is :

ioremap(0x20000000,0x40000) and ioremap(0x80000000,0x50000)



Grant Likely a écrit :
> On Fri, Sep 19, 2008 at 10:58 AM, Josh Boyer <jwboyer@gmail.com> wrote:
>   
>> On Fri, Sep 19, 2008 at 06:45:01PM +0200, =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien_ wrote:
>>     
>>> if I write :
>>> ioremap(0x20000000,0x40000) and ioremap(0x20000000,0x50000)
>>>
>>> Will it crash ?
>>>       
>> I have no idea.  You haven't given us enough information to really answer
>> that.
>>     
>
> But I can say that the second ioremap() call makes the first ioremap()
> both redundant and inefficient.  You're using exactly the same base
> address so the same region is getting mapped twice.  Since the second
> call uses a bigger region than the first then the kernel will probably
> need to allocate another chunk of virtual address space to map it
> instead of reusing the first mapping.
>
> g.
>
>
>   
