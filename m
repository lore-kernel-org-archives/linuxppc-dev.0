Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FA6C282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 09:33:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 219AF2086C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 09:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 219AF2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qJ8Y15pGzDqTn
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 20:33:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kaod.org
 (client-ip=178.33.111.247; helo=4.mo5.mail-out.ovh.net;
 envelope-from=clg@kaod.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=kaod.org
X-Greylist: delayed 70786 seconds by postgrey-1.36 at bilbo;
 Wed, 30 Jan 2019 20:32:15 AEDT
Received: from 4.mo5.mail-out.ovh.net (4.mo5.mail-out.ovh.net [178.33.111.247])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qJ6l5GQCzDqTM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 20:32:13 +1100 (AEDT)
Received: from player695.ha.ovh.net (unknown [10.109.160.5])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 497C721331A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 08:06:47 +0100 (CET)
Received: from kaod.org (lfbn-1-10603-25.w90-89.abo.wanadoo.fr [90.89.194.25])
 (Authenticated sender: clg@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id 8FB7F20D7C19;
 Wed, 30 Jan 2019 07:06:38 +0000 (UTC)
Subject: Re: [PATCH 18/19] KVM: PPC: Book3S HV: add passthrough support
To: Paul Mackerras <paulus@ozlabs.org>
References: <20190107191006.10648-1-clg@kaod.org>
 <20190107191006.10648-2-clg@kaod.org> <20190122052657.GG15124@blackberry>
 <b3788899d86b1d3bb8d141f1126592e3593ac8ef.camel@kernel.crashing.org>
 <20190123103009.GB29826@blackberry>
 <75762dbe-0f08-5b06-e376-744ff87ff4cb@kaod.org>
 <20190128061353.GD3237@blackberry>
 <38b0244d-beb6-3aee-c638-279ca570633c@kaod.org>
 <20190129041241.GA17660@blackberry>
 <2fd9b526-347d-a1d5-925b-bc633231de64@kaod.org>
 <20190130055546.GC27109@blackberry>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6afc7238-4c92-d14c-686c-63ebac4ace40@kaod.org>
Date: Wed, 30 Jan 2019 08:06:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190130055546.GC27109@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5550405066820914055
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrjeefgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
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
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 1/30/19 6:55 AM, Paul Mackerras wrote:
> On Tue, Jan 29, 2019 at 06:44:50PM +0100, Cédric Le Goater wrote:
>> On 1/29/19 5:12 AM, Paul Mackerras wrote:
>>> On Mon, Jan 28, 2019 at 07:26:00PM +0100, Cédric Le Goater wrote:
>>>>
>>>> Is clearing the PTEs and repopulating the VMA unsafe ? 
>>>
>>> Actually, now that I come to think of it, there could be any number of
>>> VMAs (well, up to almost 64k of them), since once you have a file
>>> descriptor you can call mmap on it multiple times.
>>>
>>> The more I think about it, the more I think that getting userspace to
>>> manage the mappings with mmap() and munmap() is the right idea if it
>>> can be made to work.
>>
>> We might be able to mmap() and munmap() regions of ESB pages in the RTAS 
>> call "ibm,change-msi".  I think that's the right spot for it. 
> 
> I was thinking that the ESB pages should be mmapped for device
> interrupts at VM startup or when a device is hot-plugged in, and
> munmapped when the device is hot-removed.  Maybe the mmap could be
> done in conjunction with the KVM_IRQFD call?
> 
> What is the reasoning behind doing it in the ibm,change-msi call?

Because when the device is plugged in, it has no interrupts. These are 
allocated on demand only when the driver is loaded in the guest. 

C.

