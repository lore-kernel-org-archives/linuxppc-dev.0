Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A017DB6F69
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 15:38:12 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id p5T5bXq9009470
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2011 15:37:33 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5T5b1Z21282124
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2011 15:37:01 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p5T5cAlX012604
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2011 15:38:11 +1000
Message-ID: <4E0ABA3F.5040809@in.ibm.com>
Date: Wed, 29 Jun 2011 11:08:07 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC][PATCH] Kexec support for PPC440x
References: <4DE345B0.8020505@in.ibm.com> <4DE50617.7090509@linutronix.de>
	<4DE72EFE.8080502@in.ibm.com> <4DE8CA76.2060303@in.ibm.com>
	<4DE8E746.2080100@linutronix.de>
In-Reply-To: <4DE8E746.2080100@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux ppc dev <linuxppc-dev@lists.ozlabs.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/03/11 19:23, Sebastian Andrzej Siewior wrote:
> Suzuki Poulose wrote:
>>>> The way you setup the 1:1 mapping should be close to what you are doing on
>>>> kernel entry.Isn't it possible to include the file here and in the entry
>>>> code?
>>
>>> I will make this change and resend the patch.
>>
>> I took a look at the way we do it at kernel entry. It looks more cleaner to leave
>> it untouched. Especially, when we add the support for 47x in the future, the code
>> will become more unreadable.
>>
>> What do you think ?
>
> So the entry code has one 256MiB mapping, you need 8 of those. Entry goes for TLB 63 and you need to be flexible and avoid TLB 63 :).
> So after all you don't have that much in common with the entry code. If
> you look at the FSL-book code then you will notice that I tried to share
> some code.
>
> I don't understand why you don't flip the address space bit. On fsl we
> setup the tmp mapping in the "other address" space so we don't have two
> mappings for the same address. The entry code could be doing this with STS
> bit, I'm not sure.

I am not sure if I understood this correctly.
Could you explain how could there be two mappings for the same address ?
We are setting up 1:1 mapping for 0-2GiB and the only mapping that could exist
(in other words, not invalidated) is PAGE_OFFSET mapping. Since PAGE_OFFSET < 2GiB
we won't have multiple mappings. Or in other words we could limit KEXEC_*_MEMORY_LIMIT
to PAGE_OFFSET to make sure the crossing doesn't occur.

The kernel entry code sets up the mapping without a tmp mapping in 44x. i.e, it uses
the mapping setup by the firmware/boot loader.

Thanks
Suzuki
