Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E22C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 11:48:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB84220844
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 11:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB84220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wtkC39P6zDqXC
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 22:48:51 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wtgp51khzDqVM
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 22:46:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43wtgn6C2Wz9sN8; Fri,  8 Feb 2019 22:46:45 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43wtgn3LKXz9sML;
 Fri,  8 Feb 2019 22:46:45 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] powerpc/44x: Force PCI on for CURRITUCK
In-Reply-To: <CAMuHMdUzhG4_eXn3xrzrDKHJcvZmhe9QNCue0x+GuE3SauwOqg@mail.gmail.com>
References: <20190207024935.30456-1-mpe@ellerman.id.au>
 <CAMuHMdUzhG4_eXn3xrzrDKHJcvZmhe9QNCue0x+GuE3SauwOqg@mail.gmail.com>
Date: Fri, 08 Feb 2019 22:46:40 +1100
Message-ID: <87womaijtr.fsf@concordia.ellerman.id.au>
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
Cc: Bjorn Helgaas <bhelgaas@google.com>, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Randy Dunlap <rdunlap@infradead.org>, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Geert Uytterhoeven <geert@linux-m68k.org> writes:
> Hi Michael,
>
> On Thu, Feb 7, 2019 at 3:49 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> The recent rework of PCI kconfig symbols exposed an existing bug in
>> the CURRITUCK kconfig logic.
>>
>> It selects PPC4xx_PCI_EXPRESS which depends on PCI, but PCI is user
>> selectable and might be disabled, leading to a warning:
>>
>>   WARNING: unmet direct dependencies detected for PPC4xx_PCI_EXPRESS
>>     Depends on [n]: PCI [=n] && 4xx [=y]
>>     Selected by [y]:
>>     - CURRITUCK [=y] && PPC_47x [=y]
>>
>> Prior to commit eb01d42a7778 ("PCI: consolidate PCI config entry in
>> drivers/pci") PCI was enabled by default for currituck_defconfig so we
>> didn't see the warning. The bad logic was still there, it just
>> required someone disabling PCI in their .config to hit it.
>>
>> Fix it by forcing PCI on for CURRITUCK, which seems was always the
>> expectation anyway.
>>
>> Fixes: eb01d42a7778 ("PCI: consolidate PCI config entry in drivers/pci")
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/platforms/44x/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
>> index 4a9a72d01c3c..35be81fd2dc2 100644
>> --- a/arch/powerpc/platforms/44x/Kconfig
>> +++ b/arch/powerpc/platforms/44x/Kconfig
>> @@ -180,6 +180,7 @@ config CURRITUCK
>>         depends on PPC_47x
>>         select SWIOTLB
>>         select 476FPE
>> +       select FORCE_PCI
>>         select PPC4xx_PCI_EXPRESS
>
> Would "select PPC4xx_PCI_EXPRESS if PCI" be a suitable alternative?

It would work, but I don't really like it because it means the
dependency on PCI is now encoded in two places.

I also doubt it reflects the intention of the original authors, because
at the time PCI was default y I suspect they never intended for PCI to
be disabled for that board.

cheers
