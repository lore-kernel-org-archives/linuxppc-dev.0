Return-Path: <linuxppc-dev+bounces-27955-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F360C982EA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 05:10:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqQ5L1ntJz2xs1;
	Wed, 23 Sep 2026 15:10:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.52 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790140214;
	cv=pass; b=Q/5QPiUkBT3sqz8rnLESNJHt66NFjUz3FaG6zUIlRAd/hgcPKkItAB/TniJXweZ15sgmJaaLS5/HmgVHdpW5Fl0jy/jhc7d7G8PubbVRiPJyexhxfTggFg1mdzk7z4rZbi6LVHCOS9l7VjdUyhurrvCj+FB4honRJbKHTR+7B40RaGF3P9SzHv/45kGACp+1kyZfKB1nkt0mKVMIZe/iYu2A3URMEceru1sAoAyuydjc8wLaxLlq1NWYKiwvDzZjvw8AtTkK3lSa9GqNCfdvzUsCtPFlKLv3MB28JO22pt5vamkXbnfYm7x037JLnAivccTp4KfZhq3J9cg+eS0wFw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790140214; c=relaxed/relaxed;
	bh=I0i0OPSwLnlwmd1Ge2jLkM996882q3b2fyl+HB2ZyS8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=TBqhh9f0VNf7jd7SItdSa4IDrTNBHwDjQF/sJ+9Pvbck/hvT3YSz5xZwR7TCAoq8YCAjDlmCc2Ln59FmvPXB4ILdlEKncH3DP93hxxVgxs6DUyH/Vt3VpqzS1Jj/zg7AI9v5QWhhuuUx8n99tt62Edq8XxQNj58XMagcaLGwd20oBpF8FhIJ3lhJg2euLFF4BPWHLDe7wwAFU9Si7wXFds9PpYmK+IkCcPouJFpyAG2M9Nd2Qtm8XnbR4qvuwcdS0eZ4/h9Drv9pwp0Hpj8WcJmnyDCpQHE+WSoEHNtyB987E7OVKc9ldMSz+4O5jF9CJ+RrdG3jQYoRPQM1QakEqA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mrflG7ub; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=O9eAzcSL; dkim-atps=neutral; spf=pass (client-ip=85.215.255.52; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=mrflG7ub;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=O9eAzcSL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.52; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqQ5F1hGJz2xk7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 15:10:06 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1790140157; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=cwXR2nygRcvjuUpCKhbDUtkUHOlXEB3sv8Tj1uSMjOcsAxhSrsUChe0CR/SPlIVEZC
    1msCv2LQfsXqeH3Zzdx4VgI6ZscFgoliDglnpnPb9PSkdcTk+dUwgtHtG9eJflBuiC2p
    2WDv/tbfoU2n7NIxvEKBlE0FeYd3Dd0aUzBw5Cy6aZPlZzJPB/rkODkBn9cEUL7uYoYw
    9F5vfW90hcpBNNpAYYN10l4+rvlMXffHTsd5kP425tRa4mfxdWy2njgFY8s+ann7WIOc
    guCIiyd7QV40lk+g2C8W7Ag83Tk6Vm4TKR1xOYBFNERAcBfvGsZsyHp+/vqcNY+wICUq
    r6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790140157;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=I0i0OPSwLnlwmd1Ge2jLkM996882q3b2fyl+HB2ZyS8=;
    b=fZdud6tpCP5+MJYSVdVDzSaQTfDBekDbGKilvenyRwfrzdlhoC4p+LfkHHlhmSLiPb
    pwHWkQJYFaV/9P1H1J3szhu0ht3AjEjZMCIQ2z1v3WH7Ge3WwHuZy7t4T8a9DT3Ox6uI
    rhcGa3RVGjdeVgk5EWpAUW8CMb6MJoTKH7ViNWRaV9Su7nF9P7v4dOy0dG4WY84bqINp
    WWtMnQtlQCNkelibIaczRPVD5KWjx+dl1liwPfrkA8EAh25cfqRKy2ZXwnIn/JgbNuzw
    /SXz6YOi9pb6dF+LoyGfrKOsncogpDjHmCTyiaPzXv8Gjb8j6X26Cj2x7RRXUnh90xjr
    slVQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790140157;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=I0i0OPSwLnlwmd1Ge2jLkM996882q3b2fyl+HB2ZyS8=;
    b=mrflG7ubXcW4jWmcpnCNmUMlM9tpJ4gj/sr3HUxMPlEU23DA0mikM2YBpNsbvCXDpH
    Mg6GhxvqVXTdCAgSDzTngmuNs9cuPwcclsGOLe/mun7FmFbCiKoFl1UDLoy0jiWJYAko
    xKk0nsBAJgB3uKoeCXDXl2p9QsR1sqAXt7DLzcRME7GPBCmG9Vv7Zy00mYcAsn78/iPz
    AhGjfTOG9pRjNH3Cavtzs5VfpUn7NrF+qz4S6z4eY0ee3VDczeP7/4HnYHg94s/w8cFj
    wNqdKC6BQMHmzh6dKKhyBDvCfXxP4JeasHfpChYpM0z3PAf76DvOtoCd4SI/Twlt7LUK
    B95A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790140157;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=I0i0OPSwLnlwmd1Ge2jLkM996882q3b2fyl+HB2ZyS8=;
    b=O9eAzcSLLrLuM9ptd+Zz2+cpQUKjigXrgCnjVzs6CXGKiLA6rjXSUoOUyeFIPK28xr
    6T3vRurqn+PjqkAoAZBw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+l6xPg"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.2 DYNA|AUTH)
    with ESMTPSA id ee2bee28N59FSJi
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 23 Sep 2026 07:09:15 +0200 (CEST)
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
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <7fb5baa6-9d06-2c61-2b43-6835e8fb0d1a@xenosoft.de>
Date: Wed, 23 Sep 2026 07:09:14 +0200
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
In-Reply-To: <b887c351-f7da-4e24-8cee-30a5a2dbfadb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 21/09/26 07:12, Shrikanth Hegde wrote:
> Hi Christian.
>
> On 9/20/26 6:34 PM, Christian Zigotzky wrote:
>> On 09/20/2026 01:49 PM, Christian Zigotzky wrote:
>>> On 09/18/2026 09:10 AM, Michal Suchánek wrote:
>>>> On Fri, Sep 18, 2026 at 04:39:57AM +0200, Christian Zigotzky wrote:
>>>>> On 17/09/26 16:15, Shrikanth Hegde wrote:
>>>>>> Hi Michal,
>>>>>>
>>>>>>>> Give it a try.
>>>>>>>>
>>>>>>>> I am suspecting both lockup, stack corruptions are secondary
>>>>>>>> symptoms here.
>>>>>>>> While recreate, I have different type of traces.
>>>>>>> Yes, it does work for the crash I see.
>>>>>> Thanks. Give me sometime to see further on that. Didn't get any time
>>>>>> today.
>>>>>>
>>>>>>> However, we hijacked the report
>>>>>>> of KVM locking up on FSL Cyrus+, and that is likely a different 
>>>>>>> problem
>>>>>>> still not addressed.
>>>>>>>
>>>>>> Ah, that's what you meant. Yes, i still don't know where FSL 
>>>>>> Cyrus+ is
>>>>>> stuck.
>>>>>>
>>>>>> I would need help from FSL Cyrus+ to get some logs or is there a 
>>>>>> way we
>>>>>> can spin of
>>>>>> a QEMU guest of it? We should have the log to start somewhere.
>>>>>>
>>>>>>
>>>>> It's difficult to get a log because it freezes and can't write any 
>>>>> error
>>>>> messages to the log files. This bug is very old. We had this issue 
>>>>> some
>>>>> years ago but we was able to disable PREEMPT because we don't need 
>>>>> it.
>>>> I would expect serial console and sysrq could give something, 
>>>> depending
>>>> on how much of the kernel is frozen.
>>>>
>>>> Thanks
>>>>
>>>> Michal
>>> Here is a serial log: 
>>> https://github.com/user-attachments/files/32433586/e5500_preempt_putty.log
>>>
>
> Thanks Michal for helping to get the traces.
>
>> Another serial log with pcie_ports=compat: 
>> https://github.com/user-attachments/files/32434487/e5500_preempt_pcie_ports_compat_putty.log 
>>
>>
>
> I see it is mostly busy with printing
> WARNING: at .enable_kernel_fp+0x30/0x78, CPU#3: qemu-system-ppc/4884
>
> The path seems to be same also.
>
> [c000000085ca7700] [c00000000005de84] .kvmppc_load_guest_fp+0x30/0x80
> [c000000085ca7780] [c00000000005f2a0] .kvmppc_handle_exit+0x5bc/0x5cc
> [c000000085ca7830] [c00000000006204c] .kvmppc_resume_host+0xb8/0x10c
>
>
> Does below help to boot or make it stable?
> ---
>  arch/powerpc/kvm/booke.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 13ad4cf5fa71..d4be7a306bfc 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -1404,10 +1404,17 @@ int kvmppc_handle_exit(struct kvm_vcpu *vcpu, 
> unsigned int exit_nr)
>          if (s <= 0)
>              r = (s << 2) | RESUME_HOST | (r & RESUME_FLAG_NV);
>          else {
> -            /* interrupts now hard-disabled */
> +            /*
> +             * interrupts now hard-disabled. i.e EE=0
> +             * But irqs_disabled relies on PACA entries
> +             * and fixup below enables it.
> +             * So irqs_disabled == false
> +             */
>              kvmppc_fix_ee_before_entry();
> +            preempt_disable();
>              kvmppc_load_guest_fp(vcpu);
>              kvmppc_load_guest_altivec(vcpu);
> +            preempt_enable_no_resched();
>          }
>      }
>
>
Hi,

Thanks a lot for your patch!

I patched the 7.3-rc4 kernel sources with your new patch and compiled 
the kernel again yesterday. [1]

Unfortunately, the issue still exists.

I tested it with a guest kernel with and without preempt support.

Cheers,
Christian

[1] https://github.com/chzigotzky/kernels/releases/tag/v7.3.0-rc4-2-preempt

-- 
Sent with BrassMonkey 34.3.2.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.3.2.1)


