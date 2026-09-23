Return-Path: <linuxppc-dev+bounces-28041-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E87C98304
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 16:01:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqhYK1WBpz2xjM;
	Thu, 24 Sep 2026 02:01:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.167 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790179317;
	cv=pass; b=GG+O1G4ouP0l93LXM9fK/tb4hB0dtAdBgMOKKVC2dDgJ1zUFjR01cDKdopbwOJ8lW78jpZ7vITwqI652SidUqjuToUicHBh1vYA0BYjlD5/WWYHmzIU/RRYedga0tP5X+Hoxw/9jt37MXJV9mGPlBJ8FjWb9qkpt3B5dKAOLGqj5X6SNT+pCSIIOvoY3y5QFpghofzi8NYytj14IreMO+mHecBygzEw5xwXU1IBUxxMdyjeZQg8iGJ480Yy/6/oHD/LhWMqpqHh8AnNdnEKrtkkAYlztwjZrhtAFtA167fVoAWxphdhe8XXn67DdsEH2GoW/lJj0BtbkOTMhnr1HCg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790179317; c=relaxed/relaxed;
	bh=k8aC1yqiexKg/elm9G/Oi2GEUVdsj7REN/2CBXvTffM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=fpV28nt3PQ+5oUdqfRzyYulb2Ty6nh8oMwCXoz/L14FSVmPecEJ3ROa5EflRSw5YucTcXpEgU8zkp5KXbgcJ0746KBVrxCaykLG2p0dwnfHezXeCF7wk1+5JIA7/iH01PVSI9ABNTf5//ccdNcIqp39JxSChWdt42RDfCtwkZ6nFzDOBEFgtpnA1y/MGTeYmNTwxiryLqoL6TLOQzogSXF4SN3h6lfrMpYBnxfm7RokVdDVWebmLjAmezLRGYtEtZMXWZeuVET2sJuzoIEZarG03EV2LCyRvseojwj0N0yEIGUow3V/ND2xCyTiDBD35wabo22s9UCDgROuQPXQqNQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=fV6WUNxk; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=zkUC5Mqj; dkim-atps=neutral; spf=pass (client-ip=81.169.146.167; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=fV6WUNxk;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=zkUC5Mqj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.167; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqhYD4B91z2xST
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 02:01:49 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1790179271; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Pzx86zGqTjHxQniV2WZQriqIVc3j3tPcWxldwAYom33uZdmQNP/plpU7nuXEVZOLBD
    xfKd+XPDeAsgiYBnZKRBaf0XWErmcQLA78ymNuiGyjL4GbKq2j0D7uUouQL9W8WzXSqt
    ahm03YEqyE+/2AiwSLjLcOXmWoPTfkxPZ7b/qvpR0KCXrrTzWJMIMrrh1/jYtXuHOkzi
    /Lss0TFF+K+V5WFUhd3Y6em6R6GYOnrz3G2pYM2ujwT66F9NAd+x7uWIvT5C931EHdgQ
    eOxTSaRhyGD+V4skim+XoY2Cn9qlttA/Ok6OFBlNyNJxrWYO35wrfni2+CcxSJ+1lDH9
    Z/Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790179271;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=k8aC1yqiexKg/elm9G/Oi2GEUVdsj7REN/2CBXvTffM=;
    b=SWSd4n1Vk2//0S9+6mLwIenIq+9ZsXQyou4/GYSRd4o3ObmmnzsCiPLzggbFpDqm9B
    jaRPUoIX7FmayvyeqiCnOLmuBq6rkMnwnkYEguYq7kMqXj104y6dU7QME5SMr91YUO5M
    PlrnZCPq8lQ+YPoCw75zG4GPITNVsfA1n1kLFtUqtX0jRnvHLWJW2+dWzvrCOSHyJiVp
    UVsfyaoYqZKsXdun9vjkDP1Q2wAv0nqHIwj2j5cXQRuoqOmhqQZ3YPJ+OIkCv2R5ejdh
    EXe2lWzhEjE3BV4CC5Nk20Ag87M/czYouaWUYRzrTDzNPYrT8osHyFU3tmm8GD3vne9U
    Vitg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790179271;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=k8aC1yqiexKg/elm9G/Oi2GEUVdsj7REN/2CBXvTffM=;
    b=fV6WUNxk7VmPdUgVb2o8Q4KdtnrX1UNLRo++TQp62fkXsx/TtSEFielaTWTR1O7kxM
    tCPKSpwbhRx3YD4R2hWhkYvYriphybGIoHqkxMF5sf17q267Ik4wBMuTBAyZdSafWDxR
    PT10+t8bSr8lZs1juSRQzke0WdE3q7QwHmq1MqtF+fR7pB/b61fLZmdGk1dqw6oJa+dP
    VHyu94meb50eF3UYmxXdWypUDahKS0YE50Is1WLUE1Ab/ffe5+NV3FiKRO/QoLHWzurG
    fAmHR1vCF5H3nyigpsJPUIh44sGzuGqQFWOGbmb4dLvlV1d08f4S5l9c9erorRZSXCcw
    va/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790179271;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=k8aC1yqiexKg/elm9G/Oi2GEUVdsj7REN/2CBXvTffM=;
    b=zkUC5MqjF4UyF2WbbE/ZHjcfVKoLinHdO3Lutka5dAlZOCCCFHyOrQuBn+FNGPbRfR
    4AgkOUgl3Vf14I2u6aDw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+l6xPg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.2 DYNA|AUTH)
    with ESMTPSA id ee2bee28NG19VTX
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 23 Sep 2026 18:01:09 +0200 (CEST)
Subject: Re: [Linux PPC] Disable PREEMPT
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
 =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, harshpb@linux.ibm.com,
 Gautam Menghani <gautam@linux.ibm.com>, amachhiw@linux.ibm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, "R.T.Dickinson" <rtd2@xtra.co.nz>,
 hypexed@yahoo.com.au, mad skateman <madskateman@gmail.com>,
 Christian Zigotzky <info@xenosoft.de>, Samir M <samir@linux.ibm.com>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
 Narayana Murty N <nnmlinux@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <aqfTU79SlNB3ykDi@kunlun.suse.cz>
 <25cf64ab-2a32-4d4c-a0c7-2e9007c276d4@linux.ibm.com>
 <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
 <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
 <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
 <aqu9hA1Bq58GFrVw@kunlun.suse.cz>
 <b2a5d53f-05e8-48ae-adb7-12fc74523b4e@linux.ibm.com>
 <aqvnOg9JfkM2k0TX@kunlun.suse.cz>
 <7ad57b61-4567-42c8-a9f6-faaabe7766a7@linux.ibm.com>
 <7e06fb84-ca2e-dbb4-47bd-e95ee11113c9@xenosoft.de>
 <aqzj9xsPRsGgCI5M@kunlun.suse.cz>
 <79f9d4e3-ce55-d238-e4a9-b11e9ce27c5f@xenosoft.de>
 <33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de>
 <b887c351-f7da-4e24-8cee-30a5a2dbfadb@linux.ibm.com>
 <7fb5baa6-9d06-2c61-2b43-6835e8fb0d1a@xenosoft.de>
 <9c1d7cf0-40f5-4a93-81ee-f5a4c5adcb9d@linux.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de>
Date: Wed, 23 Sep 2026 18:01:09 +0200
X-Mailer: BrassMonkey/34.3.2.1
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <9c1d7cf0-40f5-4a93-81ee-f5a4c5adcb9d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 23/09/26 07:13, Shrikanth Hegde wrote:
>
>
> On 9/23/26 10:39 AM, Christian Zigotzky wrote:
>> On 21/09/26 07:12, Shrikanth Hegde wrote:
>>> Hi Christian.
>>>
>>> On 9/20/26 6:34 PM, Christian Zigotzky wrote:
>>>> On 09/20/2026 01:49 PM, Christian Zigotzky wrote:
>>>>> On 09/18/2026 09:10 AM, Michal Suchánek wrote:
>>>>>> On Fri, Sep 18, 2026 at 04:39:57AM +0200, Christian Zigotzky wrote:
>>>>>>> On 17/09/26 16:15, Shrikanth Hegde wrote:
>>>>>>>> Hi Michal,
>>>>>>>>
>>>>>>>>>> Give it a try.
>>>>>>>>>>
>>>>>>>>>> I am suspecting both lockup, stack corruptions are secondary
>>>>>>>>>> symptoms here.
>>>>>>>>>> While recreate, I have different type of traces.
>>>>>>>>> Yes, it does work for the crash I see.
>>>>>>>> Thanks. Give me sometime to see further on that. Didn't get any 
>>>>>>>> time
>>>>>>>> today.
>>>>>>>>
>>>>>>>>> However, we hijacked the report
>>>>>>>>> of KVM locking up on FSL Cyrus+, and that is likely a 
>>>>>>>>> different problem
>>>>>>>>> still not addressed.
>>>>>>>>>
>>>>>>>> Ah, that's what you meant. Yes, i still don't know where FSL 
>>>>>>>> Cyrus+ is
>>>>>>>> stuck.
>>>>>>>>
>>>>>>>> I would need help from FSL Cyrus+ to get some logs or is there 
>>>>>>>> a way we
>>>>>>>> can spin of
>>>>>>>> a QEMU guest of it? We should have the log to start somewhere.
>>>>>>>>
>>>>>>>>
>>>>>>> It's difficult to get a log because it freezes and can't write 
>>>>>>> any error
>>>>>>> messages to the log files. This bug is very old. We had this 
>>>>>>> issue some
>>>>>>> years ago but we was able to disable PREEMPT because we don't 
>>>>>>> need it.
>>>>>> I would expect serial console and sysrq could give something, 
>>>>>> depending
>>>>>> on how much of the kernel is frozen.
>>>>>>
>>>>>> Thanks
>>>>>>
>>>>>> Michal
>>>>> Here is a serial log: 
>>>>> https://github.com/user-attachments/files/32433586/e5500_preempt_putty.log
>>>>>
>>>
>>> Thanks Michal for helping to get the traces.
>>>
>>>> Another serial log with pcie_ports=compat: 
>>>> https://github.com/user-attachments/files/32434487/e5500_preempt_pcie_ports_compat_putty.log
>>>>
>>>
>>> I see it is mostly busy with printing
>>> WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884
>>>
>>> The path seems to be same also.
>>>
>>> [c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
>>> [c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
>>> [c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c
>>>
>>>
>>> Does below help to boot or make it stable?
>>> ---
>>>  arch/powerpc/kvm/booke.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>>> index 13ad4cf5fa71..d4be7a306bfc 100644
>>> --- a/arch/powerpc/kvm/booke.c
>>> +++ b/arch/powerpc/kvm/booke.c
>>> @@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu 
>>> *vcpu, unsigned int exit_nr)
>>>          if (s <= 0)
>>>              r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>>>          else {
>>> -            /* interrupts now hard-disabled */
>>> +            /*
>>> +             * interrupts now hard-disabled. i.e EE=0
>>> +             * But irqs_disabled relies on PACA entries
>>> +             * and fixup below enables it.
>>> +             * So irqs_disabled == false
>>> +             */
>>>              kvmppc_fix_ee_before_entry();
>>> +            preempt_disable();
>>>              kvmppc_load_guest_fp(vcpu);
>>>              kvmppc_load_guest_altivec(vcpu);
>>> +            preempt_enable_no_resched();
>>>          }
>>>      }
>>>
>>>
>> Hi,
>>
>> Thanks a lot for your patch!
>>
>> I patched the 7.3-rc4 kernel sources with your new patch and compiled 
>> the kernel again yesterday. [1]
>>
>
> Thanks for trying.
>
>> Unfortunately, the issue still exists.
>>
>
> Can you share the console log of the kernel with the patch applied?
> We need to see where it is stuck now. Has it made forward progress?
>
>> I tested it with a guest kernel with and without preempt support.
>>
>> Cheers,
>> Christian
>>
>> [1] 
>> https://github.com/chzigotzky/kernels/releases/tag/v7.3.0-rc4-2-preempt
>>
>
Here is a new serial log from the patched kernel: 
https://github.com/user-attachments/files/32570808/e5500_preempt_pcie_ports_compat_patched_putty.log

Thanks

-- 
Sent with BrassMonkey 34.3.2.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.3.2.1)


