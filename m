Return-Path: <linuxppc-dev+bounces-27795-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B91C982E1
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2026 13:05:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hnmnX3TNsz2y8G;
	Sun, 20 Sep 2026 23:05:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=81.169.146.167 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789909552;
	cv=pass; b=JFbq20x0peezMpUUwnR9WzksioZi7wPO+wT/mDWSs35AZXFlDJ4tq0k92CdZPdO/2cjVwKz0dNei3TvRVHxznvOQwjCp4hDTjQ4v80mvzYm5NhanggHx1v5bHnSOc7c/h0WewvFJ9z82JLwzX+r/H8xUm0h5sTNGSTqK+AAeto65hCPx7LRBRi20K4fZ3NGkqGQFudqPMMJ87Jm/u1eSOEz63PKuZbI5EWXrWCbWzeg9fhngxyrMkbysME865XqtBWM9jmzYxxpsn0ISJI0daXk9ep/mFhXigtW56Z52enXYhWR2P/3+x1CyirAAtsS6HOVr/DsXjvIQHIpR0crQXg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789909552; c=relaxed/relaxed;
	bh=9Ak1CrscBpIUeZSB2TFLCl6Cj/LM1rn7lgmXEVu2Quo=;
	h=Subject:From:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RAHGQBvEnlmKcb2f0HHmexnzqZWQRwTQhEZvY072ts4J8wvqpRGr0M2TK0Dc7h1u/gSQSQcRpWHql0Kpfqn3jczt8xeTbDfAQi5sFTl4WockUhLVWhYenwRTDTftUd+fWZfMBlSgN5iGoep/iSAkz487WBKN6KyKrrjLKuOSt0amyY+vnq2pf1ZKLCCYes+f+iG0/oiAPgAmH/ew3VW05Oh8HOv6Z8py/80GuE9IjeRtIWgYg7opF7IWGDO3RaZHnKYW7kBSk/h+5xSxQUERs3bO/7wUKO2JEjyzQGMK+tqFIz5t4GSpCyYSm+nM8oN/gkVFM3S0rx8oun8Q463ung==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=hKAxGC5Z; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=nll1Fe+Q; dkim-atps=neutral; spf=pass (client-ip=81.169.146.167; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=hKAxGC5Z;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=nll1Fe+Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=81.169.146.167; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hnmnR6q64z2xCC
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2026 23:05:45 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1789909500; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Gtyxb0dzCM/rFZABZLuMYRsLawVO1kstil/PHVKFwJklO6eMTvlAbA85x1Z4obYq/a
    TasFJoEjWBDy2WdDLFRGUFtckQBrI4uaqOsesDBe6afLkd9dvG+2QFSzK4MraWi1ycih
    xcrcAxgCkWfCloAjTcCc6tWIGgaKEOxVXrPbtbclMGRe/59CdKiAoFcjoHHU+IxoHTiJ
    +5ZLxpYf21Q2n32HmxbLjMUW13iXXPmUpai5JJf3rPY1DLXTEDUZp6e6wp/tIh4Tg2Jq
    r9AeLR0Qrm9mhmv0ieTR0LV/NBw9WndFCh4IgmINw1bbdWiIHmWENLfSW6T2tR8GpKcp
    A/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789909500;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=9Ak1CrscBpIUeZSB2TFLCl6Cj/LM1rn7lgmXEVu2Quo=;
    b=A0dq6YVzh4n45Gl0V9ofx4wf0GvPIAXPCSbIMQuZywg6XCanEZICBuRciE93gjdsRU
    Fwfl4MNhWWnGtyiFkhDmPW3HRN8bHolekALtzP6GjIwfPIdIE2dF6yBgceb5MkKvd0HO
    e+46kW6olaWK/US9vnIITGC4uIKcYvdm1eZ87NXCaqshk7LEhDq/uD9HeIhRUk1HG5JI
    4h2ibVD5m64UjB2SIZn6VCXBjS/95DljZjPfV7shEVCYKW5abMXqzyIJsmT+WLQQ13F0
    ByoFlPDUoH9r12eI4n6zkfDaaIMrdM7coZgv655bEd9d+9lVlGx9n98YKM+Pam02LCM9
    HS8w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789909500;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=9Ak1CrscBpIUeZSB2TFLCl6Cj/LM1rn7lgmXEVu2Quo=;
    b=hKAxGC5ZvSkYADUP7iKdv6JQ1sBOQ5rAV4KZ6cRldjYCkLDXT11a91YOyCMN4+huOY
    gZsCeesj0xep3HJvafyr8XUD0mPMzug8z8rncTQ/Jy9lENuZ1yQXuZDitfZQ0kHy3omE
    C2bTMklY8vifW+1D2F7kZSoFldjvJO+K0Vad3leOexLqDA2Qmd0osJn897iAhVvpFOwb
    ULAig8lur7i0Y91IITb9Ch1Moqod/1L6cT48YW67Z1fx6BviSMfrDaCet1XBMdvDgKnZ
    R8FFFApdNamy7CQ0JmXKD9gLojyFJyDM7xtdPAgxZ5ynvFpN8OEZVnNrXvU+G8EtUB8+
    Cueg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789909500;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:References:Cc:To:From:Subject:Cc:Date:
    From:Subject:Sender;
    bh=9Ak1CrscBpIUeZSB2TFLCl6Cj/LM1rn7lgmXEVu2Quo=;
    b=nll1Fe+QqhUFMzYUIr1X1mdMuEwcko5PuWRXdFSRuwckWWE23VKeuD58pbIi1I9PKe
    LBRg7bJboi0IFy+EEpAA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIS+l7hng"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.2 DYNA|AUTH)
    with ESMTPSA id ee2bee28KD4wJ1v
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 20 Sep 2026 15:04:58 +0200 (CEST)
Subject: Re: [Linux PPC] Disable PREEMPT
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
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
Organization: A-EON Open Source
Message-ID: <33342fbf-eb7b-bde6-2c8c-254fe8bfb993@xenosoft.de>
Date: Sun, 20 Sep 2026 15:04:57 +0200
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
In-Reply-To: <79f9d4e3-ce55-d238-e4a9-b11e9ce27c5f@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/20/2026 01:49 PM, Christian Zigotzky wrote:
> On 09/18/2026 09:10 AM, Michal Suchánek wrote:
>> On Fri, Sep 18, 2026 at 04:39:57AM +0200, Christian Zigotzky wrote:
>>> On 17/09/26 16:15, Shrikanth Hegde wrote:
>>>> Hi Michal,
>>>>
>>>>>> Give it a try.
>>>>>>
>>>>>> I am suspecting both lockup, stack corruptions are secondary
>>>>>> symptoms here.
>>>>>> While recreate, I have different type of traces.
>>>>> Yes, it does work for the crash I see.
>>>> Thanks. Give me sometime to see further on that. Didn't get any time
>>>> today.
>>>>
>>>>> However, we hijacked the report
>>>>> of KVM locking up on FSL Cyrus+, and that is likely a different 
>>>>> problem
>>>>> still not addressed.
>>>>>
>>>> Ah, that's what you meant. Yes, i still don't know where FSL Cyrus+ is
>>>> stuck.
>>>>
>>>> I would need help from FSL Cyrus+ to get some logs or is there a 
>>>> way we
>>>> can spin of
>>>> a QEMU guest of it? We should have the log to start somewhere.
>>>>
>>>>
>>> It's difficult to get a log because it freezes and can't write any 
>>> error
>>> messages to the log files. This bug is very old. We had this issue some
>>> years ago but we was able to disable PREEMPT because we don't need it.
>> I would expect serial console and sysrq could give something, depending
>> on how much of the kernel is frozen.
>>
>> Thanks
>>
>> Michal
> Here is a serial log: 
> https://github.com/user-attachments/files/32433586/e5500_preempt_putty.log
>
Another serial log with pcie_ports=compat: 
https://github.com/user-attachments/files/32434487/e5500_preempt_pcie_ports_compat_putty.log

-- 
Sent with BrassMonkey 34.3.2.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.3.2.1)


