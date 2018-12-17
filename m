Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DD8C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 12:50:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26EBC20874
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 12:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26EBC20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JLbT5dZdzDqbp
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 23:50:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JLYC6bbhzDqHW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 23:48:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43JLYB6DSnz9sCh;
 Mon, 17 Dec 2018 23:48:14 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Darren Stevens <darren@stevens-zone.net>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH NEXT v2 1/4] powerpc/pasemi: Add PCI initialisation for
 Nemo board.
In-Reply-To: <4d015c642f3.12487343@auth.smtp.1and1.co.uk>
References: <4c6da03cac4.3957dfc0@auth.smtp.1and1.co.uk>
 <4d015c642f3.12487343@auth.smtp.1and1.co.uk>
Date: Mon, 17 Dec 2018 23:48:09 +1100
Message-ID: <87k1k8tj3q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: chzigotzky@xenosoft.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Darren Stevens <darren@stevens-zone.net> writes:

> Michael,
>
> Any comments on these?

Hi Darren,

I guess in general we'd like more of this to come from the device tree.

But I'll merge this series as-is, because I don't think it helps anyone
to have this code out-of-tree. We can always clean things up further in
future if anyone has the time & motivation.

cheers

> On 19/08/2018, Darren Stevens wrote:
>> The A-Eon Amigaone X1000's Nemo motherboard has an AMD SB600
>> connected to one of the PCI-e root ports on its PaSemi
>> Pwrficient 1628M SoC. Normally the SB600 southbridge would be
>> connected to a hidden PCI-e port on the system's northbridge,
>> and as a result doesn't fully comply with the PCI-e spec.
>>     
>> Add code to relax the PCI-e detection in both the root port
>> and the Linux kernel allowing on board devices to be detected.
>>     
>> Signed-off-by: Darren Stevens <Darren@stevens-zone.net>
>>
>> ---
>>
>> Changes made:
>>
>> v2: Replaced sb600_bus with a define, moved iob_mapbase into 
>>     sb600_set_flag()
>>     Created some register/Flag names (as I don't have the docs
>>     for the PA6T-1682M)
