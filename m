Return-Path: <SRS0=iwfG=PW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80140C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 10:44:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA3E20578
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 10:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA3E20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dVTZ1W9dzDqQt
	for <linuxppc-dev@archiver.kernel.org>; Mon, 14 Jan 2019 21:44:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43dVRY5hHpzDqQQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Jan 2019 21:42:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43dVRY21Ynz9s9G;
 Mon, 14 Jan 2019 21:42:49 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Kconfig label updates
In-Reply-To: <20190111112024.GD14180@gate.crashing.org>
References: <20190108223024.GA147017@google.com>
 <87tviiroqy.fsf@concordia.ellerman.id.au>
 <83241c8b-8f44-162b-b42a-0f4f9bb858e7@linux.vnet.ibm.com>
 <874lafg23v.fsf@concordia.ellerman.id.au>
 <20190111112024.GD14180@gate.crashing.org>
Date: Mon, 14 Jan 2019 21:42:48 +1100
Message-ID: <87muo3zfiv.fsf@concordia.ellerman.id.au>
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
Cc: linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
 Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Bjorn Helgaas <helgaas@kernel.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:

> On Fri, Jan 11, 2019 at 05:06:12PM +1100, Michael Ellerman wrote:
>> Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:
>> > It is basically the predecessor to PAPR "Power Architecture Platform Reference".
>> > Which the LoPAPR document is available through power.org. Not sure if there is
>> > any desire to adopt PAPR in place of RPA. It is the platform reference doc that
>> > outlines how we do DLPAR and PCI Hotplug.
>> 
>> True. But a user is unlikely to know "PAPR" either, and it googles badly.
>
> Googling for "powerpc papr" works fine afais?  With a working link to a
> pdf on the first page and all!

True if you know to add "powerpc".

I only get a link to LoPAPR, which is similar but not identical. If
there's a link to PAPR then someone is in trouble :)

cheers
