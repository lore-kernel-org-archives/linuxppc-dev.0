Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 69FB2B6F9B
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 00:40:49 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp09.au.ibm.com (8.14.4/8.13.1) with ESMTP id p5FEed8c023944
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 00:40:39 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5FEda8e909426
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 00:39:38 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5FEeasp010909
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jun 2011 00:40:36 +1000
Message-ID: <4DF8C453.70500@in.ibm.com>
Date: Wed, 15 Jun 2011 20:10:19 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Relocatable kernel for ppc44x
References: <4DF74E5D.9020908@monstr.eu> <4DF84D92.2030803@in.ibm.com>
	<1308132715.2516.1.camel@pasglop>
In-Reply-To: <1308132715.2516.1.camel@pasglop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, monstr@monstr.eu,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/15/11 15:41, Benjamin Herrenschmidt wrote:
> On Wed, 2011-06-15 at 11:43 +0530, Suzuki Poulose wrote:
>> On 06/14/11 17:34, Michal Simek wrote:
>>> Hi,
>>>
>>> have someone tried to support RELOCATABLE kernel on ppc44x?
>> As Josh, mentioned, I will be working on this. In fact I was trying a couple of
>> patches towards this on PPC440x. But, I am stuck in debugging the hang that I am
>> experiencing with the changes. I am setting up a RISCWatch processor probe to
>> debug the same.
>>
>> Here is some information that I wanted to share :
>>
>> The PPC440X currently uses 256M TLB entries to pin the lowmem. When we go for a
>> relocatable kernel we have to :
>>
>> 1) Restrict the kernel load address to be 256M aligned
>
> Wait a minute ... :-)
>
> There's a difference between having the kernel run from any address and
> mapping the linear mapping not starting at 0.
>
> Those are completely orthogonal.
>
> I don't see why off hand you are changing the way the TLB is used.

I started off with PHYSICAL_START support and that kind of hogged me into
this approach :-).
The
> only possible change needed is to make sure the initial bolted entry set
> by the asm code properly covers the kernel in whatever it's "current"
> location is. The rest is a matter of fixing up the relocations...
Could we do something like,

If kernel is loaded at X,

1. map : ((X-1) & ~256M) to PAGE_OFFSET and so on to cover the kernel in 256M
chunks.
2. Then process the relocations with (X % 256M)

Thanks

Suzuki
