Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytWFl242jzDqlc
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 23:03:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Cc: "open list\:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] powerpc/powernv: Add pci_reset_phbs parameter to issue
 a PHB reset
In-Reply-To: <c756e923-791e-154e-cdcb-50cb6bd06dd7@linux.vnet.ibm.com>
References: <20171025152754.25166-1-gpiccoli@linux.vnet.ibm.com>
 <CAKTCnz=yR1Nm1mCzNVVbDkxz=es5H9v-+J-y+8FN5ttB1EZ=Bg@mail.gmail.com>
 <95c483cf-93dc-6b99-f406-cb59d3263442@linux.vnet.ibm.com>
 <CAKTCnz=JLBGDF7O9saMiGNC4jUsHDpp1A3oRk+7TDfn5st_CKA@mail.gmail.com>
 <c756e923-791e-154e-cdcb-50cb6bd06dd7@linux.vnet.ibm.com>
Date: Fri, 08 Dec 2017 23:03:06 +1100
Message-ID: <874lp1h1fp.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:

> On 11/21/2017 12:35 AM, Balbir Singh wrote:
>> On Thu, Nov 16, 2017 at 11:14 PM, Guilherme G. Piccoli
>> <gpiccoli@linux.vnet.ibm.com> wrote:
>>> On 11/16/2017 01:49 AM, Balbir Singh wrote:
>>>> On Thu, Oct 26, 2017 at 2:27 AM, Guilherme G. Piccoli
>>>> <gpiccoli@linux.vnet.ibm.com> wrote:
>>>>> During a kdump kernel boot in PowerPC, we request a reset of the PHBs
>>>>> to the FW. It makes sense, since if we are booting a kdump kernel it
>>>>> means we had some trouble before and we cannot rely in the adapters'
>>>>> health; they could be in a bad state, hence the reset is needed.
>>>>>
>>>>> But this reset is useful not only in kdump - there are situations,
>>>>> specially when debugging drivers, that we could break an adapter in
>>>>> a way it requires such reset. One can tell to just go ahead and
>>>>> reboot the machine, but happens that many times doing kexec is much
>>>>> faster, and so preferable than a full power cycle.
>>>>>
>>>>> This patch adds the pci_reset_phbs parameter to perform such reset
>>>>> when desired by the user.
>>>>>
>>>>
>>>> Do we care to reset specific phbs or all of them? I guess all based on
>>>> your description.
>>>
>>> Exactly Balbir, it does reset all of them. We could add such
>>> granularity, but I don't see much usability..
>>> But if somebody feels it's useful, we can change...
>>>
>> 
>> OK.. makes sense, any reason why this can't be folded into reset_devices?
>> I guess we want reset_phbs to be independent of reset_devices
>
> It was, in v1. But mpe asked it to be a powerpc specific parameter heheh

LOL. Turtles.

I still feel like we shouldn't be creating a generically named parameter
like this, though we have done it many times in the past.

Can we call it "ppc_reset_phbs". And then I'll merge it without further
quibbling, honest.

cheers
