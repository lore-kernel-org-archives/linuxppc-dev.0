Return-Path: <linuxppc-dev+bounces-27646-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979F1C982D2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 02:40:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmH172HrCz2y7r;
	Fri, 18 Sep 2026 12:40:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=85.215.255.54 arc.chain=strato.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789699243;
	cv=pass; b=Jjj9nhH1rmMLyjH2qAR/erlKX9+R8GOLaNlJZ01GeVyKTeSPLkM4HoriG7JyDxk/k1OeEQtmG962f2+XtVDQaMH3GAEKxpmxwIrm1eijL0JyY2ITpBZuIjCs6RQJwtzb7gbZ8rcCBEtl77ZdwXryHanjF7k+9JwNdD4sk1Cx1QWlcJjCvCezAKdN6frBB/GkxCCVGNBcHjVqfhQdZUvfVlxSkScBFSue4amCKwAWMlQAzELR0pcxM9C9JRtCvyZvTNrgHcM3Xj0HPkIrE+jOLnqJE6Y9Sz5cYpgCFkHs6A77kVtS4mck5UtMnd00ft2PlR5Ln7/Xu456j6YQRHDVWQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789699243; c=relaxed/relaxed;
	bh=h7bgIghYy6rIQpeuTEPDhR0x4PHXDnfd0N0XviJQESk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oyyEGtQgj1CJqJs7psw2T9p7mW+RK4Xn+qlw4f53htEEonAWciWuQqfFz6bNTLqizLWr7J6HPf7LRRFQStA275AWLanZXShHesuZfYPUMAWfRddMVCyN2S3G49dJYPlVBS1hEZadd2f2/Ilbpqx8ccCxvhRPAtswY3TNz+tFXs3DS77kB5A02pG203N3vIz5V6k+Uzt46aW606DY30WwyDzZAOQz7kIbXAYWzmd0+yUYOG6OHGik88qnQogH8bsgThh6iveTe19YnxHAEWdEdY06AI+1SsI7LUP32yF9NkxTNSmoRSpyggiHbxWCmGOigQgZNMHchDiXFwbjpl9dvQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de; dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OHTYlD3H; dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=L1whxBc7; dkim-atps=neutral; spf=pass (client-ip=85.215.255.54; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org) smtp.helo=mo4-p01-ob.smtp.rzone.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=xenosoft.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=OHTYlD3H;
	dkim=pass header.d=xenosoft.de header.i=@xenosoft.de header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=L1whxBc7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.helo=mo4-p01-ob.smtp.rzone.de (client-ip=85.215.255.54; helo=mo4-p01-ob.smtp.rzone.de; envelope-from=chzigotzky@xenosoft.de; receiver=lists.ozlabs.org)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmH116TKrz2y2W
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2026 12:40:35 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1789699200; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=tRxi2WWq29SmcPgJVtWOC7Lkr2dmx68NvDlqHrAR3HzYYRqtzp+wTyDoP0eu7BlYDK
    j6ShgP7/rEzDjHe7TVkEDfKeC4PA3VVnnHWtc8S3syjUUZ3OodHdYqsOYsik8POcVlmp
    VJ7zS1ABCOAAlD++YglbFoIL6BP4EGrcAKGRcO0v/cUYbFV22v+IQYrS3Zc7t10I4jwl
    Yf1QDpRiNZySSZqlCJ7RqPL+cSa4zvJZDzixAEp+qNlfneRFbYoZtYweCJIaUV96UnO7
    XranNnQNwgWdBxPQQQpQYIyyovPDAud/06QgpS3LdmLjwbXdQpIn0mtmuUepFyOciFkE
    XZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789699200;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=h7bgIghYy6rIQpeuTEPDhR0x4PHXDnfd0N0XviJQESk=;
    b=F7KA0AKuHhjB9Gv5Ywy9lXvXu+spp0dHQFZzktCeye1JZp4uwiY5yNENxVPKoUtgQZ
    UyLbnzoma1p4fNeAFDL2uH7DURu66IAsXvVSMipmkqXYosMybA2y/CDnbY8lUNui7sZg
    Ab9x8zQB0yewSm9amLKdJw24oC0Y5W522C3o0/ejd+XEvslB1reCHuSGAIwrMAcn2n7l
    +2ORsTU8IoC5OAhPIIKE8WA/THkDw68iZBwyIu8TvGHM/HrL1nKAyGdlp4uMHo6ssMzR
    9TEBhJJan757D7urnm52QQai+86uxaf+xCn1apZ9k4ZuprmIk7RmlfY9/GerZte6RSbr
    foew==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789699200;
    s=strato-dkim-0002; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=h7bgIghYy6rIQpeuTEPDhR0x4PHXDnfd0N0XviJQESk=;
    b=OHTYlD3HX0WMSB62ocsh+IVfMce2PGK0JWOvqXMbBcbQ5LHeJ04vCqSizJtCa3wPTr
    2bn65fQBnon2tEfD/rnBNi3+NIPSSRPOjX8tsmey/ga1S++5uPbs/wYFh/UtQJ/wTIpt
    GnCRRTZBKg4ZVsD4EQ7Y8/XpigPusWH2mGoJtHxvLg+GeeK2DwfpaGBYZLLbUE8/lgXj
    5673jX+loJBB3x3zzI4mf7uBi7LYusF7v+hrbmvSorhC4BpWMwpaYu+S61chSMyBmOuI
    y/gfgcB01c5zWP2+qkMn6xo0RiR142XNBxOrO76UEj2kCf3cGG1LgrSJNANuo44Pv5LY
    6ZDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789699200;
    s=strato-dkim-0003; d=xenosoft.de;
    h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=h7bgIghYy6rIQpeuTEPDhR0x4PHXDnfd0N0XviJQESk=;
    b=L1whxBc7v4TfxP1REiYartKLSNAuoxu2tpE8fD0tyIrLIjFQf1v48PLniKYf6N+x2q
    Of0Yi31hQ6GtkDMRmlAw==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+m7R3g"
Received: from void-ppc.a-eon.tld
    by smtp.strato.de (RZmta 55.6.2 DYNA|AUTH)
    with ESMTPSA id ee2bee28I2dwDK6
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 18 Sep 2026 04:39:58 +0200 (CEST)
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
References: <aqKUhHb9UTfVq4As@kunlun.suse.cz>
 <aqKfsVArHHaIK6M9@kunlun.suse.cz>
 <baeb1ae4-7c0f-4e4e-8fc5-09367cb7c4e9@linux.ibm.com>
 <aqfTU79SlNB3ykDi@kunlun.suse.cz>
 <25cf64ab-2a32-4d4c-a0c7-2e9007c276d4@linux.ibm.com>
 <aqj1KxZttNgY5ZVR@kunlun.suse.cz>
 <ba9759d0-b1f2-4b33-aff5-769cf89bd584@linux.ibm.com>
 <9b58bd58-d0e4-463e-bff9-e33b153b2987@linux.ibm.com>
 <aqu9hA1Bq58GFrVw@kunlun.suse.cz>
 <b2a5d53f-05e8-48ae-adb7-12fc74523b4e@linux.ibm.com>
 <aqvnOg9JfkM2k0TX@kunlun.suse.cz>
 <7ad57b61-4567-42c8-a9f6-faaabe7766a7@linux.ibm.com>
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Organization: A-EON Open Source
Message-ID: <7e06fb84-ca2e-dbb4-47bd-e95ee11113c9@xenosoft.de>
Date: Fri, 18 Sep 2026 04:39:57 +0200
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
In-Reply-To: <7ad57b61-4567-42c8-a9f6-faaabe7766a7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/09/26 16:15, Shrikanth Hegde wrote:
>
> Hi Michal,
>
>>>
>>> Give it a try.
>>>
>>> I am suspecting both lockup, stack corruptions are secondary 
>>> symptoms here.
>>> While recreate, I have different type of traces.
>>
>> Yes, it does work for the crash I see.
>
> Thanks. Give me sometime to see further on that. Didn't get any time 
> today.
>
>> However, we hijacked the report
>> of KVM locking up on FSL Cyrus+, and that is likely a different problem
>> still not addressed.
>>
>
> Ah, that's what you meant. Yes, i still don't know where FSL Cyrus+ is 
> stuck.
>
> I would need help from FSL Cyrus+ to get some logs or is there a way 
> we can spin of
> a QEMU guest of it? We should have the log to start somewhere.
>
>
It's difficult to get a log because it freezes and can't write any error 
messages to the log files. This bug is very old. We had this issue some 
years ago but we was able to disable PREEMPT because we don't need it.

-- Christian

-- 
Sent with BrassMonkey 34.3.2.1 (https://github.com/chzigotzky/Web-Browsers-and-Suites-for-Linux-PPC/releases/tag/BrassMonkey_34.3.2.1)


