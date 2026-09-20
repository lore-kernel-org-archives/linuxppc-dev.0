Return-Path: <linuxppc-dev+bounces-27794-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C4CC982DA
	for <linuxppc-dev@archiver.kernel.org>; Sun, 20 Sep 2026 11:50:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hnl6s3XG4z2y8c;
	Sun, 20 Sep 2026 21:50:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.54 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789905045;
	cv=pass; b=IQnukH+3kiHkiX4an5VTwBEfqttadZrmgRpJuiL+/PlxX05vwW+E5MyTWYJbwA77Ogi91jaPYhcvqPyp3/P4DdIdYnQkUVGbK9iK9RGek+/zwQlJV7oTlD2A0RB0K+Ckt+XTF0jArzbympAW+OkEP9BJq+k0EyIyf7NC0j/ezmakg9mXeWnztEZUA2hwiif78xCx1qE+d3AiAA6Qw2WTZHq8qa1RMfUUhpH7PDDE2PqfiogmNXL5pGmCH2RLEvgrnYrTwYNNEfxPYdhfopbh1E3OYY/1jhR65fwkXRzGTE0ImHHVdzMh1mjiPGNR5Oufu3+fl1utPxLVlaq8MlXifg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789905045; c=relaxed/relaxed;
	bh=JKBiCFk4QK7ZfXmeY5KFaZ2nWbOUEQe4lYWt/P4V9lk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UotW9uQSYMTW4eTkz4CL+Xr3NiGl6Cj9OqaIWvuCkihOBJ4Anka1lNmciF64sF4CRN76HZrzOMrddeE/dxIBRMWdAXKSDKjXSpHR0QJpTQRwhbnc/7JgmrxHezwoIGsS8DomVLQSBXMTrNy3h73pECoAxbvvHMjHvEAuoCq2Jy8e/Rl2hkMzjDjceaQSMyl6zKV091JZBCOSQOpzwwkfC+iL4eAggXtJMELCiQRosCfCPO3XpZchbt+kRxlMLv6Qms6Q8uI6K0fqHh27fbm1oTTMDzCp0XnKIOa5BsnffVfGixK6tHxuviPPPSgdN/o8M+08Nkp8qkBRyQvvABpvkQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=r9l5RNDe; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ROKYovHY; dkim-atps=neutral; spf=pass (client-ip=85.215.255.54; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=r9l5RNDe;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=ROKYovHY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.54; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hnl6l6bq0z2xM9
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Sep 2026 21:50:37 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1789904990; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KcA1VGLQ7M/V+dfBJogqc1IQJMsq5bHAinBjEKmdBcT7BtRCnWuQ/dfnJrcdWbC9Z+
    k1fU/Ab/WVc8CWlISm0CZfy9/hdmosaKB3TxOHvQ0HNZsx2wk5DuZc5ke7hc1dpBhJUh
    bBV/kZh0umR+L9w7DENK/kigEDhmCSMoLBo67G2y371YU2UPjd1H7rJIZAsGFtv9pXHu
    2EC05J+szTS7zwasWw3yMFYMRCqiLpJ/5PJUzhphdNUU7qpALbH8CZxA4NLKWOgS+JNI
    9qzlM3o5pdS4o5GgBBP3FJLYsf2wQdho4e/CvflWqaNC0fAxITTlrpcar5fJV+ZGwu4e
    MKEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789904990;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=JKBiCFk4QK7ZfXmeY5KFaZ2nWbOUEQe4lYWt/P4V9lk=;
    b=OvfhTi6nbUC6SQ3O2uR9BLXoG+ZNPybJsQe3oqxlkhjyvZY8B0ZbWoVML+ysRrOK6d
    9SeBugjzMJAfnN1OxGb7iWvWDS2ZJsxlhBVB8m0mGZr/SzLk61mOL+5xNPj0XEdmoRg3
    GD3pbcDfD7yc4LszhqZ+edS6EuPHYGr250dXHrh0bEmdWkMxK2oqVLE8+VbF9ngSFIWB
    cU3L8QQGXYJqyNGxdoB6JLagPVZYbr0TbI4gjGnnWB6yQE/148AN5kprKPudexx0Ere0
    WhNlB4kWMsVW1e+NtxTY/6hIiV8pvkq9xKYhY+B7GFB8g/pOMww/snWW5X0jGU7P2rc5
    iZ4w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789904990;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=JKBiCFk4QK7ZfXmeY5KFaZ2nWbOUEQe4lYWt/P4V9lk=;
    b=r9l5RNDeiNtCHL4ipRyz8Q1RcdERjSXSfyVh9GRaSNsmgIu20M/meBBE6QnUZ9DuWu
    zvBtY625pjB7baM1HHsGCGfCiSe02Ze+Mv0wyMNDWkrOqz7RP4wWnXPIE3fPSx8+Uzyd
    bGIyimXk/2YDVeo9Z6HlYiHPQ8Hx3ulg7jgrzprSz4qapl1jR57CaCh1cTgCFKOsXGAe
    sSatVZ2nMGupdfJfMXVprnv894MycHeQO8KEX+3J++G5cbDibJqSPbBoBl4prOQbSdNg
    5Altjh0IRqXnQD/cCrCAIxDBieeKWaB1lyujQHGfE0q7R5FWFIHw5kJpmoOXkV1mM1+Q
    5oDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789904990;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=JKBiCFk4QK7ZfXmeY5KFaZ2nWbOUEQe4lYWt/P4V9lk=;
    b=ROKYovHY2EoBW7gQ33/khmP8Emf0WMF2Agnzh5qulyid11YTukSAbCItbTwQ+3UWtL
    lefb8IG3dV5Uyz16VmAA==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIS+l7hng"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.2 DYNA|AUTH)
    with ESMTPSA id ee2bee28KBnmIsd
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 20 Sep 2026 13:49:48 +0200 (CEST)
Subject: Re: [Linux PPC] Disable PREEMPT
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
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <79f9d4e3-ce55-d238-e4a9-b11e9ce27c5f@xenosoft.de>
Date: Sun, 20 Sep 2026 13:49:47 +0200
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
In-Reply-To: <aqzj9xsPRsGgCI5M@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/18/2026 09:10 AM, Michal Suchánek wrote:
> On Fri, Sep 18, 2026 at 04:39:57AM +0200, Christian Zigotzky wrote:
>> On 17/09/26 16:15, Shrikanth Hegde wrote:
>>> Hi Michal,
>>>
>>>>> Give it a try.
>>>>>
>>>>> I am suspecting both lockup, stack corruptions are secondary
>>>>> symptoms here.
>>>>> While recreate, I have different type of traces.
>>>> Yes, it does work for the crash I see.
>>> Thanks. Give me sometime to see further on that. Didn't get any time
>>> today.
>>>
>>>> However, we hijacked the report
>>>> of KVM locking up on FSL Cyrus+, and that is likely a different problem
>>>> still not addressed.
>>>>
>>> Ah, that's what you meant. Yes, i still don't know where FSL Cyrus+ is
>>> stuck.
>>>
>>> I would need help from FSL Cyrus+ to get some logs or is there a way we
>>> can spin of
>>> a QEMU guest of it? We should have the log to start somewhere.
>>>
>>>
>> It's difficult to get a log because it freezes and can't write any error
>> messages to the log files. This bug is very old. We had this issue some
>> years ago but we was able to disable PREEMPT because we don't need it.
> I would expect serial console and sysrq could give something, depending
> on how much of the kernel is frozen.
>
> Thanks
>
> Michal
Here is a serial log: 
https://github.com/user-attachments/files/32433586/e5500_preempt_putty.log

-- 
Sent with BrassMonkey 34.3.2.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.3.2.1)


