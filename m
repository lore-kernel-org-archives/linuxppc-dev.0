Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2012FC43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 17:45:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7CD2145D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 17:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBgyraNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7CD2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zGSg72qszF3Ff
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 04:45:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sBgyraNy";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=okaya@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="sBgyraNy"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zGPc0472zF3P5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 04:42:28 +1100 (AEDT)
Received: from [10.80.45.159] (unknown [71.69.156.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2F9DA2145D;
 Mon, 19 Nov 2018 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542649346;
 bh=pTK755v01/dT2muoZN3qHYXL1n/03ylIcKFKrHyrMh4=;
 h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
 b=sBgyraNydUrFJhNaTBjDtbyMXXaBoBb/9Z4A4gTEVrzU5HTLMxDSkINKRzzN+oAWs
 9eVMdxR3H5iu8tKjCrbWn/acIwDbqzWNffAjqbW4pQ03UNRdAXhcSLrVCHfSiaozPC
 gnPm4KylS8opnYuOJeSCDiBSOE1AkvRCVlgsmQTY=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
From: Sinan Kaya <okaya@kernel.org>
To: Keith Busch <keith.busch@intel.com>, Tyler Baicar <baicar.tyler@gmail.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <b9a739c8-80bd-e04c-ac19-97bc54f20eff@kernel.org>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
Message-ID: <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
Date: Mon, 19 Nov 2018 12:42:25 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: alex_gagniuc@dellteam.com, helgaas@google.com, sbobroff@linux.ibm.com,
 linux-pci@vger.kernel.org, Shyam_Iyer@dell.com, rjw@rjwysocki.net,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-acpi@vger.kernel.org, lukas@wunner.de, oohall@gmail.com,
 mr.nuke.me@gmail.com, bhelgaas@google.com, austin_bolen@dell.com,
 linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/19/2018 12:32 PM, Sinan Kaya wrote:
>>
>> But we're not using HEST as a fine grain control. We disable native AER
>> handling if *any* device has FF set in HEST, and that just forces people
>> to use pcie_ports=native to get around that.
>>
> 
> I don't see *any* in the code.  aer_hest_parse() does the HEST table parsing.
> It switches to firmware first mode if global flag in HEST is set. Otherwise
> for each BDF in device, hest_match_pci() is used to do a cross-matching against
> HEST table contents.
> 
> Am I missing something?

I see. I think you are talking about aer_firmware_first, right?

aer_set_firmware_first() and  pcie_aer_get_firmware_first() seem to do the right
thing.

aer_firmware_first is probably getting set because events are all routed to a
single root port and aer_acpi_firmware_first() is used to decide whether AER
should be initialized or not.

I think I understand what is going on now.

Still, breaking existing systems that rely on HEST table is not cool.
I'd rather have users specify "pcie_ports=native" to skip FF rather than
having broken systems by default to be honest.
