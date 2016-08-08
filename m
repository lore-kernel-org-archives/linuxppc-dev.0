Return-Path: <robh+dt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7TKT41k3zDqd7
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 06:19:40 +1000 (AEST)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id 0FC0B20274
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 20:19:38 +0000 (UTC)
Received: from mail-yb0-f174.google.com (mail-yb0-f174.google.com
 [209.85.213.174])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 44AD4201DD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Aug 2016 20:19:36 +0000 (UTC)
Received: by mail-yb0-f174.google.com with SMTP id g133so41627085ybf.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Aug 2016 13:19:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <65cd098a-f29d-4b7c-5df1-0a88630d3d21@candw.ms>
References: <ce142972-52a8-452f-8911-70af927ae425@candw.ms>
 <a9fe88f0-14ba-7ca6-66b4-69b84fa8a823@huawei.com>
 <d5280537-e579-0ee6-9011-f2fa6157204c@candw.ms>
 <5194d5e9-0c2a-004b-f295-b34ece0d9004@huawei.com>
 <65cd098a-f29d-4b7c-5df1-0a88630d3d21@candw.ms>
From: Rob Herring <robh+dt@kernel.org>
Date: Mon, 8 Aug 2016 15:19:15 -0500
Message-ID: <CAL_JsqJxL6KRqpt6nBH_5kLtqW3S34=5WcVwRrKvZ3p0A2OszQ@mail.gmail.com>
Subject: Re: Problem booting Kernel 4.8-rc1 on Sam460ex ( Canyonlands)
To: Julian Margetson <runaway@candw.ms>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>, imunsie@au1.ibm.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 8, 2016 at 2:25 PM, Julian Margetson <runaway@candw.ms> wrote:
> On 8/8/2016 9:39 AM, Kefeng Wang wrote:
>>
>> +cc Rob
>>
>> On 2016/8/8 20:51, Julian Margetson wrote:
>>>
>>> On 8/8/2016 8:22 AM, Kefeng Wang wrote:
>>>>
>>>> On 2016/8/8 19:52, Julian Margetson wrote:
>>>>>
>>>>> Problem booting Kernel 4.8-rc1 on Sam460ex ( Canyonlands) machine .
>>>>>
>>>>> This is what I get with the bisect.
>>>>
>>>> Hi Julian
>>>>
>>>> I have no Sam460ex machine, could you show the good and bad kernel
>>>> bootlog?
>>
>> I have no experience about PowerPC, the status shows below,
>> version                 boot
>> v4.7                    ok
>> v4.8-rc1                fail
>> v4.7 + this patch       fail(right?)
>>
>> Does PowerPC support earlyprintk/earlycon? Please set it, and let's show
>> somethings from earlyprintk.
>
> Not getting any output with earlyprintk so not sure if it works or if my
> settings are incorrect .

This should work: earlycon=uart8250,mmio,ef600300,115200n8

Adding "initcall_debug debug" would also be useful here.

> I tried to revert the commit but the result is the same so I suspect that
> this one may not really be the problem .
> Looks like the real problem may be something affecting the the device tree
> loading .

That's strange. If it is this commit, the init order changes as it
changed from device to arch initcall. I haven't seen any other
platforms having problems.

Rob
