Return-Path: <suzuki@in.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 37C65B6FAF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 21:50:26 +1000 (EST)
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p53BdL0B020617
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2011 07:39:21 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p53BoHG1087580
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2011 07:50:17 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p53BoHAs006892
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2011 08:50:17 -0300
Message-ID: <4DE8CA76.2060303@in.ibm.com>
Date: Fri, 03 Jun 2011 17:20:14 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [RFC][PATCH] Kexec support for PPC440x
References: <4DE345B0.8020505@in.ibm.com> <4DE50617.7090509@linutronix.de>
	<4DE72EFE.8080502@in.ibm.com>
In-Reply-To: <4DE72EFE.8080502@in.ibm.com>
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

On 06/02/11 12:04, Suzuki Poulose wrote:
> On 05/31/11 20:45, Sebastian Andrzej Siewior wrote:
>>
>> Suzuki Poulose wrote:
>>> Index: powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
>>> ===================================================================
>>> --- /dev/null
>>> +++ powerpc/arch/powerpc/kernel/44x_kexec_mapping.S
>> ....
>>
>>> + *
>>> + */
>>> + bl nxtins /* Find our address */
>>> +nxtins: mflr r5 /* Make it accessible */
>>
>> Please don't mix labels and instructions.
> OK.
>>
>>> + tlbsx r23,0,r5 /* Find entry we are in */
>>
>> using tabs instead of spaces would make it look nice. Please also separate the arguments of the instruction i.e.
>> tlbsx r23, 0, r5
>
> Sure.
>>
>>
>>> Index: powerpc/arch/powerpc/kernel/misc_32.S
>>> ===================================================================
>>> --- powerpc.orig/arch/powerpc/kernel/misc_32.S
>>> +++ powerpc/arch/powerpc/kernel/misc_32.S
>>> @@ -736,6 +736,28 @@ relocate_new_kernel:
>>> mr r5, r31
>>>
>>> li r0, 0
>>> +#elif defined(CONFIG_44x) && !defined(CONFIG_47x)
>>> +
>>> + mr r29, r3
>>> + mr r30, r4
>>> + mr r31, r5
>>> +
>>> +#include "44x_kexec_mapping.S"
>>
>> The way you setup the 1:1 mapping should be close to what you are doing on
>> kernel entry.Isn't it possible to include the file here and in the entry
>> code?

> I will make this change and resend the patch.

I took a look at the way we do it at kernel entry. It looks more cleaner to leave
it untouched. Especially, when we add the support for 47x in the future, the code
  will become more unreadable.

What do you think ?

Thanks

Suzuki
>
> Thanks
>
> Suzuki
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
