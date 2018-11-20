Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE88C46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 22:32:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B74E62080F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 22:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gc7gNaqj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B74E62080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4300mN4JWRzF3S4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 09:31:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gc7gNaqj";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=okaya@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Gc7gNaqj"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4300jf6MVXzF3M3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 09:28:54 +1100 (AEDT)
Received: from [10.80.45.159] (unknown [71.69.156.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A9BF52147A;
 Tue, 20 Nov 2018 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1542752932;
 bh=amiAQZivvLb+0E+qyHlyj7WCS/LfqxES6RuASc64Ck8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Gc7gNaqjdr1jq9VQyC9TxfnZ5sh9BF2XHE4/DyL1I5SWXvyuordTu+vC9kvHIsX0z
 weO795ZUmkOqG7w3y8yHonZprPjrFc5Kk55HPZb7VeE5WWiekyZOUKVPAHl5WcpPEm
 ghpkvrqWo+yKkSii6t02aSXmCqu/3XJuLvgbp/Xw=
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
To: Keith Busch <keith.busch@intel.com>
References: <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
 <20181120214243.GG26707@localhost.localdomain>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <bace940c-70d9-6631-9818-43338d194327@kernel.org>
Date: Tue, 20 Nov 2018 17:28:49 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181120214243.GG26707@localhost.localdomain>
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
Cc: Alex_Gagniuc@Dellteam.com, baicar.tyler@gmail.com, sbobroff@linux.ibm.com,
 linux-pci@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
 Shyam.Iyer@dell.com, linux-acpi@vger.kernel.org, lukas@wunner.de,
 oohall@gmail.com, mr.nuke.me@gmail.com, Austin.Bolen@dell.com,
 bhelgaas@google.com, linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/20/2018 4:42 PM, Keith Busch wrote:
> How does that work? If the OS takes control, it sets up MSIs that FW don't
> react to, and disables system errors through PCIe Root Control. Aren't
> those sys errs the mechanism FW knows it has something to do, which
> means the OS can effectively fence it off?

I think this is all implementation detail and doesn't necessarily apply
to all firmware-first implementation flavors.

Assumptions are:
1. both FW and OS are listening to MSI interrupts
2. FW monitors the system errors

Some FF implementation could route the AER interrupt to a higher privilege
level. Some other implementation could use INTx or a side-band channel interrupt
for firmware-interrupt too.

I have seen all 3 except MSI :) and also firmware never monitored the system
error bits. I was curious if anybody ever used those legacy bits. Now, I know
someone is using it.


