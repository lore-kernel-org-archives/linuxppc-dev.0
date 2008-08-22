Return-Path: <xenidis@gmail.com>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.249])
	by ozlabs.org (Postfix) with ESMTP id 36E45DEE25
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 23:56:45 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so132506hsz.9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 06:56:44 -0700 (PDT)
Message-Id: <08A55D0E-C75A-49F4-9DBF-EB80E1C7755E@pobox.com>
From: Jimi Xenidis <jimix@pobox.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <542DF8C9-8EB7-40D9-AC66-67D4CF7598F6@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
Date: Fri, 22 Aug 2008 09:56:16 -0400
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<81439C52-0CB6-4C46-9A97-3D30B84F58AF@kernel.crashing.org>
	<48AD7815.70107@linux.vnet.ibm.com>
	<9E570AE9-6811-489F-9E2C-EF5A6B95ED5C@kernel.crashing.org>
	<20080821161622.GB15669@ld0162-tx32.am.freescale.net>
	<48AE73E2.2010706@linux.vnet.ibm.com>
	<542DF8C9-8EB7-40D9-AC66-67D4CF7598F6@kernel.crashing.org>
Sender: Jimi Xenidis <xenidis@gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, kvm-ppc@vger.kernel.org,
	hollisb@us.ibm.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2008, at 4:17 AM, Kumar Gala wrote:

>
> On Aug 22, 2008, at 3:08 AM, Christian Ehrhardt wrote:
>
>> Scott Wood wrote:
>>> On Thu, Aug 21, 2008 at 09:21:39AM -0500, Kumar Gala wrote:
>>>
>>>> Where is the other discussion?  I'd like to understand what's  
>>>> going on  here.. (especially since I added the wrtee[i] changes  
>>>> to kernel way  back when).
>>>>
>>>
>>> Presumably, they want to be able to replace wrtee with a store to a
>>> hypervisor/guest shared memory area, and there's no store-immediate
>>> instruction.
>>>
>>> -Scott
>>>
>> Exactly Scott
>>
>> And for your question Kumar, in the last submission I was asked to  
>> split host and guest patches.
>> So the host discussion lives on kvm-ppc@vger.kernel.org as I  
>> mentioned (maybe a bit too hidden)
>> in the [0/4] mail of this series.
>
> Maybe I'm missing something but it seems like just changing the code  
> to wrtee isn't the best way to ensure you have enough space to put  
> the set of instructions you guys want.
>

Sorry, I have not really been following this, I assume you are  
replacing SPR accesses with load/stores that do not trap.
I believe thats fine for reading any SPR, but not true for modifying  
some SPRs, particularly MSR.
IMHO you must trap on any instruction that modifies the MSR.
So you should prolly not rewrite mtmsr or wrtee* but let them trap.

BTW: actually moving problem SPRs (like MSRs) to a read only page  
makes decoding far more efficient, but it does burn another TLB entry.

-JX


> - k
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
