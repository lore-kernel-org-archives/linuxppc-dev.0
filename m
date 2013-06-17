Return-Path: <B31939@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1FA5F2C0174
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 15:36:31 +1000 (EST)
Received: from mail174-co9 (localhost [127.0.0.1])	by
 mail174-co9-R.bigfish.com (Postfix) with ESMTP id 5A29E9800DE	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 05:36:28 +0000 (UTC)
Received: from CO9EHSMHS015.bigfish.com (unknown [10.236.132.229])	by
 mail174-co9.bigfish.com (Postfix) with ESMTP id 140FC34006E	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 05:36:26 +0000 (UTC)
Message-ID: <51BEA072.1040902@freescale.com>
Date: Mon, 17 Jun 2013 13:36:50 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 5/5] powerpc/fsl_msi: add 'msiregs' kernel parameter
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371194159-17332-5-git-send-email-Minghuan.Lian@freescale.com>
 <1371248034.2996.18@snotra>
In-Reply-To: <1371248034.2996.18@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

please see my comments inline.

On 06/15/2013 06:13 AM, Scott Wood wrote:
> On 06/14/2013 02:15:59 AM, Minghuan Lian wrote:
>> 1. Only MSIIR1 can index 16 MSI registers, but when using MSIIR1
>> the IRQs of a register are not continuous. for example, the first
>> register irq values are 0x0, 0x10, 0x20, 0x30 ... 0x1f0. So it
>> is hard to use 'msi-available-ranges' property to indicate the
>> available ranges and 'msi-available-ranges' property has been
>> removed from dts node, so this patch removes the related code.
>>
>> 2. Add 'msiregs' kernel parameter instead of 'msi-available-ranges'
>> functionality.
>
> The reason we used a device tree property was because this is for 
> virtualization and AMP scenarios where this instance of Linux does not 
> own all of the MSI registers.
>
> I don't see any reasonable way to partition an MPIC v4.3 MSI group -- 
> but there are more groups, so it's not that bad.  What's the use case 
> for this patch?
>
[Minghuan] I do not known any case about this patch. I add 'msiregs' 
just for achieving "msi-available-ranges" functionality. I do not want 
to remove partition functionality when updating to mpic4.3, although I 
do not see virtualization and AMP cases on T4(KVM does not need this 
functionality).
If you hope to keep 'msi-available-ranges' property for older mpic, can 
I add 'msi-available-regs' property for mpic4.3.
Using 'msi-available-regs' to implement partition is similar to 
'msi-available-ranges'. When considering the consistency, 
'msi-available-regs' is better than msiregs.
> -Scott
