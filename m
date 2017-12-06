Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysTDx6xcJzDsLw
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Dec 2017 06:28:49 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vB6JSDfV001374
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Dec 2017 14:28:46 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2epm1wfkvu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 06 Dec 2017 14:28:46 -0500
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Wed, 6 Dec 2017 14:28:44 -0500
Subject: Re: [PATCH v2] powerpc/powernv: Add pci_reset_phbs parameter to issue
 a PHB reset
To: Balbir Singh <bsingharora@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
References: <20171025152754.25166-1-gpiccoli@linux.vnet.ibm.com>
 <CAKTCnz=yR1Nm1mCzNVVbDkxz=es5H9v-+J-y+8FN5ttB1EZ=Bg@mail.gmail.com>
 <95c483cf-93dc-6b99-f406-cb59d3263442@linux.vnet.ibm.com>
 <CAKTCnz=JLBGDF7O9saMiGNC4jUsHDpp1A3oRk+7TDfn5st_CKA@mail.gmail.com>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Wed, 6 Dec 2017 17:28:39 -0200
MIME-Version: 1.0
In-Reply-To: <CAKTCnz=JLBGDF7O9saMiGNC4jUsHDpp1A3oRk+7TDfn5st_CKA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <c756e923-791e-154e-cdcb-50cb6bd06dd7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/2017 12:35 AM, Balbir Singh wrote:
> On Thu, Nov 16, 2017 at 11:14 PM, Guilherme G. Piccoli
> <gpiccoli@linux.vnet.ibm.com> wrote:
>> On 11/16/2017 01:49 AM, Balbir Singh wrote:
>>> On Thu, Oct 26, 2017 at 2:27 AM, Guilherme G. Piccoli
>>> <gpiccoli@linux.vnet.ibm.com> wrote:
>>>> During a kdump kernel boot in PowerPC, we request a reset of the PHBs
>>>> to the FW. It makes sense, since if we are booting a kdump kernel it
>>>> means we had some trouble before and we cannot rely in the adapters'
>>>> health; they could be in a bad state, hence the reset is needed.
>>>>
>>>> But this reset is useful not only in kdump - there are situations,
>>>> specially when debugging drivers, that we could break an adapter in
>>>> a way it requires such reset. One can tell to just go ahead and
>>>> reboot the machine, but happens that many times doing kexec is much
>>>> faster, and so preferable than a full power cycle.
>>>>
>>>> This patch adds the pci_reset_phbs parameter to perform such reset
>>>> when desired by the user.
>>>>
>>>
>>> Do we care to reset specific phbs or all of them? I guess all based on
>>> your description.
>>
>> Exactly Balbir, it does reset all of them. We could add such
>> granularity, but I don't see much usability..
>> But if somebody feels it's useful, we can change...
>>
> 
> OK.. makes sense, any reason why this can't be folded into reset_devices?
> I guess we want reset_phbs to be independent of reset_devices

It was, in v1. But mpe asked it to be a powerpc specific parameter heheh
Cheers,


Guilherme

> 
> Balbir
> 
