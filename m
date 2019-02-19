Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7310EC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 04:56:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9648217D7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 04:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9648217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443T3h31ZCzDqGC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 15:56:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443T1q3bz3zDqHF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 15:55:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 443T1q1kZ0z9s1l;
 Tue, 19 Feb 2019 15:55:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Christophe Leroy <christophe.leroy@c-s.fr>, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix 32-bit KVM-PR lockup and panic with MacOS
 guest
In-Reply-To: <46205b6a-7671-5d90-9507-b5b20045b99d@ilande.co.uk>
References: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk>
 <41b02fb0-cdc6-6de0-d8fc-44d3d0a8ad70@c-s.fr>
 <2ed8efb9-5cd4-31bf-6c7b-501b9d1925e6@ilande.co.uk>
 <c2d6938902656f2829be8077c656cee9235c21b1.camel@kernel.crashing.org>
 <46205b6a-7671-5d90-9507-b5b20045b99d@ilande.co.uk>
Date: Tue, 19 Feb 2019 15:55:10 +1100
Message-ID: <87mumsbcnl.fsf@concordia.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> On 11/02/2019 00:30, Benjamin Herrenschmidt wrote:
>
>> On Fri, 2019-02-08 at 14:51 +0000, Mark Cave-Ayland wrote:
>>>
>>> Indeed, but there are still some questions to be asked here:
>>>
>>> 1) Why were these bits removed from the original bitmask in the first place without
>>> it being documented in the commit message?
>>>
>>> 2) Is this the right fix? I'm told that MacOS guests already run without this patch
>>> on a G5 under 64-bit KVM-PR which may suggest that this is a workaround for another
>>> bug elsewhere in the 32-bit powerpc code.
>>>
>>>
>>> If you think that these points don't matter, then I'm happy to resubmit the patch
>>> as-is based upon your comments above.
>> 
>> We should write a test case to verify that FE0/FE1 are properly
>> preserved/context-switched etc... I bet if we accidentally wiped them,
>> we wouldn't notice 99.9% of the time.
>
> Right I guess it's more likely to cause in issue in the KVM PR case because the guest
> can alter the flags in a way that doesn't go through the normal process switch mechanism.
>
> The original patchset at
> https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg98326.html does include
> some tests in the first few patches, but AFAICT they are concerned with the contents
> of the FP registers rather than the related MSRs.

fpu_preempt.c should be able to be adapted to also check the MSR bits.

> Who is the right person to ask about fixing issues related to context switching with
> KVM PR?

KVM PR doesn't really have a maintainer TBH. Feel like volunteering? :)

> I did add the original author's email address to my first few emails but have
> had no response back :/

Cyril who wrote the original FPU patch has moved on to other things.

cheers
