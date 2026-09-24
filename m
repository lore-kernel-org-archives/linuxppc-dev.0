Return-Path: <linuxppc-dev+bounces-28143-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD63C9830E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:48:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLsF6zHRz30T9;
	Fri, 25 Sep 2026 03:48:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.51 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790272081;
	cv=pass; b=c6MkPkF/EutsjrFdCGvZNKDtp0190oPEPr+5+6JAIwApIeRPLw2Hb6mxkVppGSpq8cH4VYVCsJW6a+tyD44h82C80v1Fh6BUKh8kq5WHGfBqwzQNzXS7kXRPo3RfeQLAnItuyYX+7d+hUNg+XZe9PHKg2Gj0Ozeu+gtEF4nZQm7CYRcCZ1NXz/xjIhhJUNLv1KHQce8nXd8/nlWww+us4+OnMbec2cn9vowvQ0mPc4Lngef+WoRxhucLCYAujNdTOQ+VwHP33CssiomWMvqyKfpysZyFUEDAKiC5OkjuRixMnG5aMjLXGjtW+wufblWiKpK7KcWPChAvL0X6H37gCw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790272081; c=relaxed/relaxed;
	bh=k09pSqkcBcXfPeKupiDHj7zwfc4tUihP1PYAmgGdSIY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LAfII/nqfXkLFgRfHq434KMtnPJQN+XOpZuppf0dqxkRli8lBDu+37haVc87M3i7BtFMSVQ+Yacm22bB22aVHsw0aIj4GTNxxObFBglilvu0nXBPi89wGS4QS5dHS6U2vKaf2TNYwKYYIxfZ9m6tZztI6cVQYbBDoDYUKebBoPk13B6rQ0wE/k66YJrGtm2j3wVLnZXJu6J+d/cxNOW+qPi9NitLGtLxcw1mfy88G+s2DT2oZw+i0m76D4pi8P+7mNRmcYvh+gVDwHMXpQlNxRw6ZH/HTe9PQCeDUjVRXda274udTton6W9r6dskHfLmaiaFE8CD91yb3nb28OBdjA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=stiLf87S; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=zdCLeaPJ; dkim-atps=neutral; spf=pass (client-ip=85.215.255.51; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=stiLf87S;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=zdCLeaPJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.51; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLs92qlfz2y7Y
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:47:54 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1790272035; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Yq9Edzd7sqLCyxkFx3JjGbqdRTDW5D71FIEzy/IqwGYdb2GWckguiH6p5ZdXsDpl37
    qb/Q+3tHhaX44MmLErVrQW2CQHY4piBQ3pr9gP3MFXnMPKuKt6T89lM9/JVJXN1rCGOo
    XIZkG5cp2AQfx1QJ47LuWjZbg69+pU6ru2ipcQvl5/nUgVqhWnM0pQ8ycwywjQO6csl7
    MyMEDbJ3ZQvTYJgTq20rJCv0qdS8bu2kvl6sZyzZuCSh4hlXjd/w4+Z9MXZZeVp9Jrxy
    OSx7ixWNriFpkhaHwl6XhpOJ5zUgfkH2M4RpBOYBgY/SxR9aYF5gwXhah58t79XVHEyX
    /qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790272035;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=k09pSqkcBcXfPeKupiDHj7zwfc4tUihP1PYAmgGdSIY=;
    b=LQEFiRnceWm6pBhsJASETKmFFSs50BRSOeSJ/xGTiSU4mCelg7Om8jN8nG7Q4NOE8I
    yXmkejSDR0wN7+LaUUqi7pRq49jzu7x62xDUzDzzkRNvhpdAKa7ns9cSpAtbeo0dH+R9
    RSuhJv1sTo5g4dGfTHQ37HHCEgld0oHL4t+2pACnhMb16LeK/9iZB9caZKYpDwf+s5Mv
    enwpHM1srbEJneiyxq8Z4UWlVFrY9mHCmrBprciRcIJPHk+hytfrJsoiktxw74V192rm
    4ACitbHMof8/7CrBsyJO12DH1RHubiew+PJjQeGfBfDeIbCjyf2XGvccWwSRrIL404Gz
    4DlQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790272035;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=k09pSqkcBcXfPeKupiDHj7zwfc4tUihP1PYAmgGdSIY=;
    b=stiLf87SGLsTuCMN48YlyKFAhh42FxQOM7+f9UUeJXFGgTAzEOkiCtiM9jRXTZv9Po
    6Jsi6bQzGZNY+WSm3gZNZemMnL1eiTlroA38Lb/sRsD6ORMtGWIdJ+95kRW5jMTYgqkl
    NGR7Thy3vc6d2E9ZLentmbcckXl2sDtSBjo4SFD9lrU2K5RIGgt+Nz7k5eKTBILsTmUC
    TOw+3rWHQLbAYPxQ6K/iEGdwEGhXz3wSg3X9r66wF4RwJKZiYGGLDI9wwJY1ms8sNwAK
    sNNqUYnJpGF/tr3Im/D4eRov5JWD+LY1lQOeBqmSMgaAHNgv8xCaDRaGHm7LBEhM3jAh
    eyuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790272035;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=k09pSqkcBcXfPeKupiDHj7zwfc4tUihP1PYAmgGdSIY=;
    b=zdCLeaPJVWqSHt6Mv67yUOovsqxFgYVaBDFM+vPNc2gYNqyjDWLuumesDtXMfuqj/i
    S2msW7/il4FfK8qEP8Ag==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIC+m7h/g"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.2 DYNA|AUTH)
    with ESMTPSA id ee2bee28OHlDZsJ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 24 Sep 2026 19:47:13 +0200 (CEST)
Subject: Re: [Linux PPC] Disable PREEMPT
To: Shrikanth Hegde <sshegde@linux.ibm.com>
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
 Hari Bathini <hbathini@linux.ibm.com>, =?UTF-8?Q?Michal_Such=c3=a1nek?=
 <msuchanek@suse.de>
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
 <b8f82519-9ae5-c247-e020-e79c627e57df@xenosoft.de>
 <0fbc2522-791a-482b-a756-f3e6e61d2e29@linux.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <a9fd6f5f-cdfa-a010-05b9-507689026fe4@xenosoft.de>
Date: Thu, 24 Sep 2026 19:47:12 +0200
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
In-Reply-To: <0fbc2522-791a-482b-a756-f3e6e61d2e29@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/23/2026 08:42 PM, Shrikanth Hegde wrote:
> Hi
>
> On 9/23/26 9:31 PM, Christian Zigotzky wrote:
>> On 23/09/26 07:13, Shrikanth Hegde wrote:
>>>
>>>
>>> On 9/23/26 10:39 AM, Christian Zigotzky wrote:
>>>> On 21/09/26 07:12, Shrikanth Hegde wrote:
>>>>> Hi Christian.
>>>>>
>>>>> I see it is mostly busy with printing
>>>>> WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884
>>>>>
>>>>> The path seems to be same also.
>>>>>
>>>>> [c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
>>>>> [c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
>>>>> [c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c
>>>>>
>>>>>
>>>>> Does below help to boot or make it stable?
>>>>> ---
>>>>>  arch/powerpc/kvm/booke.c | 9 ++++++++-
>>>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>>>>> index 13ad4cf5fa71..d4be7a306bfc 100644
>>>>> --- a/arch/powerpc/kvm/booke.c
>>>>> +++ b/arch/powerpc/kvm/booke.c
>>>>> @@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu 
>>>>> *vcpu, unsigned int exit_nr)
>>>>>          if (s <= 0)
>>>>>              r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>>>>>          else {
>>>>> -            /* interrupts now hard-disabled */
>>>>> +            /*
>>>>> +             * interrupts now hard-disabled. i.e EE=0
>>>>> +             * But irqs_disabled relies on PACA entries
>>>>> +             * and fixup below enables it.
>>>>> +             * So irqs_disabled == false
>>>>> +             */
>>>>>              kvmppc_fix_ee_before_entry();
>>>>> +            preempt_disable();
>>>>>              kvmppc_load_guest_fp(vcpu);
>>>>>              kvmppc_load_guest_altivec(vcpu);
>>>>> +            preempt_enable_no_resched();
>>>>>          }
>>>>>      }
>>>>>
>>>>>
>>>> Hi,
>>>>
>>>> Thanks a lot for your patch!
>>>>
>>>> I patched the 7.3-rc4 kernel sources with your new patch and 
>>>> compiled the kernel again yesterday. [1]
>>>>
>>>
>>> Thanks for trying.
>>>
>>>> Unfortunately, the issue still exists.
>>>>
>>>
>>> Can you share the console log of the kernel with the patch applied?
>>> We need to see where it is stuck now. Has it made forward progress?
>>>
>>>> I tested it with a guest kernel with and without preempt support.
>>>>
>>>> Cheers,
>>>> Christian
>>>>
>>>> [1] 
>>>> https://github.com/chzigotzky/kernels/releases/tag/v7.3.0-rc4-2-preempt 
>>>>
>>>>
>>>
>> Here is a new serial log from the patched kernel: 
>> https://github.com/user-attachments/files/32570808/e5500_preempt_pcie_ports_compat_patched_putty.log
>>
>
> That paca mismatch is independent of preemption modes.
>
> It shows a few warnings and even after that a console message has come 
> through.
> Do warning continue forever?
>
> To fix those warnings, can you try this diff on the top of the earlier 
> ones?
> (Igonore whitespace mangling if any, Also patch is UNTESTED. It is 
> more of my
> speculation.).
>
> Sorry, I don't have any way to test it out locally.
>
> ---
>
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 9194cf492d1c..0a014fa45b20 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -147,6 +147,19 @@ int kvmppc_prepare_to_enter(struct kvm_vcpu *vcpu)
>                         continue;
>                 }
>
> +#ifdef CONFIG_PPC64
> +               if (unlikely(local_paca->irq_happened != 
> PACA_IRQ_HARD_DIS)) {
> +               /*
> +                * An interrupt arrived between the soft and hard
> +                * disable. Replay it and retry guest entry.
> +                */
> +                       local_irq_enable();
> +                       local_irq_disable();
> +                       hard_irq_disable();
> +                       continue;
> +               }
> +#endif
> +
>                 guest_enter_irqoff();
>                 return 1;
>         }
>

Hi,

I patched the RC4 of kernel 7.3 with the two patches and compiled it 
again today.

I'm happy to report that the patched PREEMPT kernel with KVM HV works on 
the X5000/40. (e5500)

Serial log: 
https://github.com/user-attachments/files/32619259/e5500_preempt_pcie_ports_compat_patched-2_putty.log

I also successfully tested it with KVM PR on the X1000 today. (PA6T)

Further information: 
https://github.com/chzigotzky/kernels/issues/19#issuecomment-5818925408

Many thanks for your help,

Christian

-- 
Sent with BrassMonkey 34.3.2.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.3.2.1)


