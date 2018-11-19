Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED01CC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 20:36:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3271520851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 20:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kvf8Z2I0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3271520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zLG85T0lzF3Lj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 07:36:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kvf8Z2I0";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=okaya@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kvf8Z2I0"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zLCV0HbDzF3Pb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 07:33:57 +1100 (AEDT)
Received: from [10.80.45.159] (unknown [71.69.156.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 00FD120851;
 Mon, 19 Nov 2018 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542659635;
 bh=3uKhecW8K14uBnBMOtnnZLwY/FmqbriVrVCRteZ99aE=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Kvf8Z2I02HiExO7+Lci5/WYHgwa/6oGk3SsuNK93xAzRxdm47m8OS5ecrnIeU+ve7
 qEZFRRrODATU1m1iLbt7yW4QAgJw+znhcP+yVn5Emb5hnYB0jBPfJe0JuYfFhJjS9K
 G75nldkt9mtUyhq1m5dNmFOG/KifGdqV56GpIup0=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To: Alex_Gagniuc@Dellteam.com, mr.nuke.me@gmail.com, keith.busch@intel.com
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
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
Date: Mon, 19 Nov 2018 15:33:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
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
Cc: baicar.tyler@gmail.com, sbobroff@linux.ibm.com, linux-pci@vger.kernel.org,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org, Shyam.Iyer@dell.com,
 linux-acpi@vger.kernel.org, lukas@wunner.de, oohall@gmail.com,
 Austin.Bolen@dell.com, bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org,
 lenb@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/19/2018 3:16 PM, Alex_Gagniuc@Dellteam.com wrote:
> On 11/19/2018 01:32 PM, Sinan Kaya wrote:
>> ACPI 6.2:
>>
>> 18.3.2.4 PCI Express Root Port AER Structure
>>
>> Flags:
>>
>> Bit [0] - FIRMWARE_FIRST: If set, this bit indicates to the OSPM that system
>> firmware will handle errors from this source first.
>> Bit [1] - GLOBAL: If set, indicates that the settings contained in this
>> structure apply globally to all PCI Express Devices.
>> All other bits must be set to zero.
>>
>> It doesn't say shall, may or might. It says will.
> 
> It says "system firmware will handle errors". It does not say "system
> firmware owns AER registers". In absence on any descriptor text on the
> meaning of these tables, this really looks to me like it should be
> interpreted as a descriptor of APEI error sources, not a mutex on who
> writes to certain bits-- AER in this case.

True. I was trying to get it out in a rush. I omitted words.

However; table assumes governance about for which entities firmware first
should be enabled. There is no cross reference to _OSC or permission
negotiation like _OST.

> 
> I don't think that is contradictory or inconsistent.
> I also wasn't able to find any reference to HEST in UEFI 2.7, only in
> ACPI spec.

You are right. It was a confusion on my side. The right place to look is
ACPI specification. I was involved in this a couple of years ago. Some pieces
were in UEFI spec. Other pieces were in ACPI. I guess they got unified
now.

> 
>> I think It depends on your PCI topology.
>>
>> For other topologies with multiple PCI root complexes, I can see this being
>> used per root complex flag to indicate which root complex needs firmware first
>> and which one doesn't.
> 
> _OSC is per root bus, so it's already granular enough, right? Why would
> it depend on PCI topology?
> 

I was speculating. I don't have the full background on this. Need to consult
the spec developers.

>> As I said in my previous email, the right place to talk about this is UEFI
>> forum.
> 
> The way I would present the problem to he spec writers is that, although
> the spec appears to be consistent, we've seen firmware vendors that made
> the wrong assumptions about HEST/_OSC. Instead of describing AER
> ownership with _OSC, they attempted to do it with HEST. So we should add
> an implementation note, or clarification about this.

I agree.

> 
> Alex
> 

