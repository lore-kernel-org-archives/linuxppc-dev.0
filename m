Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF69C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 22:18:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 182CF222C7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 22:18:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 182CF222C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zcW76NBhzDqN6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 09:18:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=46.105.72.36; helo=2.mo4.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
Received: from 2.mo4.mail-out.ovh.net (2.mo4.mail-out.ovh.net [46.105.72.36])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zcTR50wSzDqFH
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 09:17:15 +1100 (AEDT)
Received: from player789.ha.ovh.net (unknown [10.109.159.20])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 72A141CD116
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 23:07:19 +0100 (CET)
Received: from kaod.org (102.221.90.212.static.wline.lns.sme.cust.swisscom.ch
 [212.90.221.102]) (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id DDA4729B69DE;
 Tue, 12 Feb 2019 22:07:11 +0000 (UTC)
Subject: Re: [PATCH 06/19] KVM: PPC: Book3S HV: add a GET_ESB_FD control to
 the XIVE native device
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20190205052822.GE22661@umbus.fritz.box>
 <4d565738-a99b-0333-8533-037677358faa@kaod.org>
 <20190206012308.GP22661@umbus.fritz.box>
 <1745dd9f-2927-cae6-e8da-c350b0bd0a66@kaod.org>
 <20190207024950.GA22661@umbus.fritz.box>
 <d20bbaca-5b49-66e4-9d99-21d991c2c345@kaod.org>
 <20190208051523.GD2688@umbus.fritz.box>
 <9b556f53-fcfb-2ca3-019e-6ced0ec74c2a@kaod.org>
 <20190208215329.GA9529@blackberry>
 <8c915ed7-5aa5-1276-6598-d5dcd115dd56@kaod.org>
 <20190211023842.GE7230@umbus.fritz.box>
 <9dc53c6bccd6fd303481217f768ec173992431e2.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a01fbedc-10db-b99b-9e77-943f413fcca4@kaod.org>
Date: Tue, 12 Feb 2019 23:07:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <9dc53c6bccd6fd303481217f768ec173992431e2.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 4870361526182251399
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrledvgdduheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/11/19 7:42 AM, Benjamin Herrenschmidt wrote:
> On Mon, 2019-02-11 at 13:38 +1100, David Gibson wrote:
>>
>> 1) All in kernel
>>
>> The offset always maps directly to guest irq number and the kernel
>> somehow binds it either to an IPI or a host irq as necessary.
>> Cédric's original code attempts this, but the mechanism of keeping a
>> pointer to the VMA can't work.
> 
> Why do you need a pointer to the VMA anyway ? unmap_mapping_range()
> doesn't need a VMA for the unmap part, and faults/mmaps have the VMA.
> 
>> But.. remapping the irqs should be sufficiently infrequent that it
>> might be ok to consider simply stepping through all the hosting
>> process's VMAs to do this.
> 
> Which unmap_mapping_range() does for you as I explained previously. You
> only need the address space. See how spufs does it (among others).

and the different CAPI drivers. This is much better and it works fine.

On the same topic, the XIVE IC on P10 will use IPI ESB pages for the 
PHB interrupts sources. We will still need this kind of remapping but 
the pages will be from the same controller.

Thanks,

C.
