Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAB2C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 01:56:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB772080C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 01:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBK1FpuK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB772080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zTN00Qr6zF3P7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 12:56:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bBK1FpuK";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=okaya@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="bBK1FpuK"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zTKJ3vtZzF378
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 12:54:27 +1100 (AEDT)
Received: from [192.168.0.109] (cpe-174-109-247-98.nc.res.rr.com
 [174.109.247.98])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A5CA22080C;
 Tue, 20 Nov 2018 01:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542678865;
 bh=SKyjJA+9q/5M5jSNQgYSS65jciomRDOHucw5o12BtcQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=bBK1FpuKT6phXZvtPCDoi+Gl7M6r44TxJA73vBXa1h4NYBI2uMGB1s+q6QOox3IFS
 0IBMJG4GiyVN0lXvFxK+OImrLYaNsaBX7GNzevBL4PPcT/CGtdM8+topoM6hWTa8db
 gAojzIXBhYa/8ZDZ4xh9cYiVatjt2TJI4Uc8UPN0=
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
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
Date: Mon, 19 Nov 2018 20:54:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
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

On 11/19/2018 6:49 PM, Alex_Gagniuc@Dellteam.com wrote:
> On 11/19/2018 02:33 PM, Sinan Kaya wrote:
>> However; table assumes governance about for which entities firmware first
>> should be enabled. There is no cross reference to _OSC or permission
>> negotiation like _OST.
> 
> Well, from an OSPM perspective, is FFS something that can be enabled or
> disabled? FFS seems to be static to OSPM, which would change the sort of
> assumptions we can reasonably make here.

IMO, it can be enabled/disabled in BIOS. I have seen this implementation before.
If the trigger is the presence of a statically compiled ACPI HEST table (as the
current code does); presence of FFS would be static from OSPM perspective.
BIOS could patch this table or hide it during boot.

If FFS were to be negotiated via _OSC as indirectly implied in this series, then
same BIOS could patch the ACPI table to return different values for the _OSC
return.

> 
> 
>>>> As I said in my previous email, the right place to talk about this is UEFI
>>>> forum.
>>>
>>> The way I would present the problem to he spec writers is that, although
>>> the spec appears to be consistent, we've seen firmware vendors that made
>>> the wrong assumptions about HEST/_OSC. Instead of describing AER
>>> ownership with _OSC, they attempted to do it with HEST. So we should add
>>> an implementation note, or clarification about this.
>>
>> I agree.
> 
> Cool. While the UEFI Secret Society debates, can we figure out if/how
> [patch 1/2] breaks those systems, or is it only [patch 2/2] of this
> series that we suspect?

I went back and looked at both patches. Both of them are removing references to
HEST table. I think both patches are impacted by this discussion.

> 
> Alex
> 

