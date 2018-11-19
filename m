Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE912C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 19:14:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0DC2086A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 19:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pe2nRtkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0DC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zJRY03kZzF3Bd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 06:14:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pe2nRtkd";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=mr.nuke.me@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pe2nRtkd"; 
 dkim-atps=neutral
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zJP144MkzF3QC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 06:12:05 +1100 (AEDT)
Received: by mail-oi1-x244.google.com with SMTP id y23so17066068oia.4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Nov 2018 11:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=798Y91enXE4kDi8T02D0jxp54tLLl+SmkeKec8c0lgM=;
 b=pe2nRtkd02iRqUe2Cmpyfjoo7s8vp6JfGQnlyx+yl3JbDJ/UEd0A1CrsLZr6sHI678
 7KHkn8Yd0z6z8mNh9A+LnbBc6QDDcDU25ERDmZygniAQ2jntZ6aavxRbUVKjvogquzYe
 crQ8s0mI9DlKhx6sPeCroqgh625mD+H8WdReCDY7fJvK8LsnIqxGaYG9vUYk41xjNW4W
 P5EZnnccDc88P2wUA2EJlU8h3xyqLCvwbmvjTvXl8OL8NW/xxjyhGl9/lUSvmkXEy/OL
 N2WblqYO+hRQ41xnTAJMjJIViGn2k+KGwhraxzXbsvCcIGHQVgr+15/0c7thD0fjiW+v
 OKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=798Y91enXE4kDi8T02D0jxp54tLLl+SmkeKec8c0lgM=;
 b=D4f9aJPAqXpScF+fRn1dQDMm6zIYKbFF7IqH4qqSK9KPn0rbi31s06grNZzFy4dI2C
 4FW/J7n/0jT3Vxa3p0wj4VqEfh9v3Zfhq/QnAetB72g3PzTe8/3t4+xipT6EOZbdzm+2
 qwNRVblnTwLqUr9mZKKWURrvF4mqdT9binnxTSvUn5BW1O7qI57nZ1YInx1B1Y9/t8zG
 54a4M8/gPmy6iTTzffOtpCB8U6TxfYt0KJUaShuKkGURe/cB8VM0VxV/7tyOFWD7CyfL
 MtjAf1WfgUtqbriBUMag4qZhjK20tGhauQZlOyx1jrP7rn7N8Ii4yzFE7ATve7ZuEjsU
 +C5Q==
X-Gm-Message-State: AGRZ1gJnqK+XwHeTp+SWstERsXF651fIK6Eu6MvonaFuTpz/PwEHY3me
 hCzOQDWZyQMKPG7PdAD2xNT4HPWi
X-Google-Smtp-Source: AFSGD/VzW34qb8UDQ4/gkJRMCiPPPUofdYNRO069laG+3fgnkYymun/4QAPcxRTMmRIMj+soo9m5Tw==
X-Received: by 2002:aca:5681:: with SMTP id k123mr5607738oib.106.1542654722259; 
 Mon, 19 Nov 2018 11:12:02 -0800 (PST)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net.
 [98.195.139.126])
 by smtp.gmail.com with ESMTPSA id u136sm9202283oie.38.2018.11.19.11.12.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Nov 2018 11:12:01 -0800 (PST)
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To: Sinan Kaya <okaya@kernel.org>, Keith Busch <keith.busch@intel.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
 <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
From: "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
Date: Mon, 19 Nov 2018 13:11:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: alex_gagniuc@dellteam.com, Tyler Baicar <baicar.tyler@gmail.com>,
 sbobroff@linux.ibm.com, linux-pci@vger.kernel.org, Shyam_Iyer@dell.com,
 rjw@rjwysocki.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-acpi@vger.kernel.org, lukas@wunner.de, oohall@gmail.com,
 bhelgaas@google.com, austin_bolen@dell.com, linuxppc-dev@lists.ozlabs.org,
 lenb@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/19/2018 12:24 PM, Sinan Kaya wrote:
> On 11/19/2018 1:10 PM, Keith Busch wrote:
>>> We can't really turn off firmware first in the kernel without asking 
>>> help
>>> from the firmware.
>> The _OSC method this patch utilizes is the ACPI spec defined way for
>> the kernel to wrest control from firmware. BIOS specific menu settings
>> shouldn't be our only recourse when we have a spec authority defining
>> generic OS interfaces to accomplish the same thing.
>>
>> Unless there is a disagreement on the _OSC interpreation, we'd have to
>> accept that platforms breaking from this patch are non-compliant.
>>
> 
> It depends on which spec you look :)
> 
> UEFI HEST table specification also claims that it should be the ultimate
> table for when PCI firmware-first should be disabled/enabled.

IIRC, EFI absorbed ACPI before FFS was a thing. Could you point me to 
the UEFI chapter that says HEST is authoritative?
(not being a smartie, just that my free software PDF readers can't 
search within a file that large)


> I think somebody needs to fix these. I saw an email from Harb Abdulhamid
> sent to aswg this morning.
> 
> That's why I suggested circulating this idea in UEFI forums first.
> Let's see what everybody thinks. We can go from there.

However you look at it, we have a glaring inconsistency in how we handle 
AER control in linux. I'm surprised we didn't see huge issues because of 
mixing HEST/_OSC.

What systems rely on the HEST definition as opposed to _OSC? It doesn't 
make sense to me that you could have a system with mixed FFS and native 
AER on the same root port. The granularity of HEST shouldn't matter here 
because of how AER works.

I'd like see how exactly we break one of those elusive systems with 
_OSC. I suspect _OSC and HEST end up having the same information, and 
that's why we didn't see any real-life issue with mixing the approaches.

Alex


P.S.
(SARCASM ALERT) Isn't UEFI is a pile of stuff that didn't stick to the wall?

P.P.S
I remember someone asking why we don't disable FFS in the BIOS. I think 
it would be next to impossible to get certain platform vendors to 
relinquish FFS control, unless the specs required things to be that way 
-- and had a "standard" way to do so.

Then getting the specs to change in that direction is also a battle.
