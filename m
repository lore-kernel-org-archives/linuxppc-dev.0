Return-Path: <martyn.welch@gefanuc.com>
Received: from ext-nj2ut-2.online-age.net (ext-nj2ut-2.online-age.net
	[64.14.54.231])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ext-nj2ut.online-age.net",
	Issuer "Savvis Communications Root CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 947C0DDF29
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 03:01:18 +1100 (EST)
Received: from int-nj2ut-6.online-age.net (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by ext-nj2ut-2.online-age.net (8.13.6/8.13.6/20051114-SVVS-TLS-DNSBL)
	with ESMTP id n12G12Y0008664
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Feb 2009 11:01:02 -0500
Received: from cinmlip01.e2k.ad.ge.com (int-nj2ut-6.online-age.net
	[3.159.237.75])
	by int-nj2ut-6.online-age.net (8.13.6/8.13.6/20050510-SVVS) with ESMTP
	id n12G12DD001297
	for <linuxppc-dev@ozlabs.org>; Mon, 2 Feb 2009 11:01:02 -0500
Message-ID: <498718B6.3030307@gefanuc.com>
Date: Mon, 02 Feb 2009 16:00:54 +0000
From: Martyn Welch <martyn.welch@gefanuc.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Booting 2.6.29-rc3 on mpc8661d_hpcn failing
References: <4982F311.4050507@gefanuc.com>
	<F764D461-8EFB-4B31-ABFC-ECBB7A3FBA01@kernel.crashing.org>
	<9B0CCADB-C891-42B2-BE94-0927B5715A00@kernel.crashing.org>
	<4986BEB9.3030606@gefanuc.com>
	<E00697F4-1313-49C2-9F8A-79FC9E511022@kernel.crashing.org>
In-Reply-To: <E00697F4-1313-49C2-9F8A-79FC9E511022@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Feb 2, 2009, at 3:36 AM, Martyn Welch wrote:
> 
>> Becky Bruce wrote:
>>> On Jan 30, 2009, at 8:42 AM, Kumar Gala wrote:
>>>>
>>>> On Jan 30, 2009, at 6:31 AM, Martyn Welch wrote:
>>>>
>>>>> Hi Guys,
>>>>>
>>>>> It seems that 2.6.29-rc3 is not booting on the MPC8641 HPCN. I have 
>>>>> just updated u-boot to the latest git to see if that improved 
>>>>> matters, however I get stuck at the following. Any ideas?
>>>>
>>>> did you update your .dtb as well?
>>
>> Yup, just double checked it. SOC mapped at ffe00000. If I use the 
>> wrong DTB I don't get any serial output...
>>
>>> We've changed the memory map for that board in the latest u-boot, 
>>> which is why you need a new .dtb.  If this still failing, let me 
>>> know, and I'll give it a try on my board and see what's up since this 
>>> is probably my fault :)
>>
>> It appears the same problem is affecting our sbc610 as well, the 
>> location of the SOC hasn't changed on that board.
>>
>> Martyn
> 
> Hm.. maybe try a git-bisect between 2.6.28 and 2.6.29-rc3?
> 

That's was today's "little" task. I was just in the process of writing an email :-)

It got me to the following commit:

commit 64b3d0e8122b422e879b23d42f9e0e8efbbf9744
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>

    powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED

I tried reverting it, but as I had kinda thought, that really didn't help.

I'm just recompiling to check that I didn't screw-up during the bisection.

Martyn

-- 
Martyn Welch MEng MPhil MIET (Principal Software Engineer)   T:+44(0)1327322748
GE Fanuc Intelligent Platforms Ltd,        |Registered in England and Wales
Tove Valley Business Park, Towcester,      |(3828642) at 100 Barbirolli Square,
Northants, NN12 6PF, UK T:+44(0)1327359444 |Manchester,M2 3AB  VAT:GB 729849476
