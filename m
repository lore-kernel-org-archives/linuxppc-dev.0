Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9169FC282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 13:37:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 429CF20989
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 13:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 429CF20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qPYY74KyzDqTJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 31 Jan 2019 00:37:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qPWP104yzDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2019 00:35:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qPWN2NS2z9sBZ;
 Thu, 31 Jan 2019 00:35:28 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Reza Arbab <arbab@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/mm: Add _PAGE_SAO to _PAGE_CACHE_CTL mask
In-Reply-To: <20190129170347.igcb4yufilshjgri@arbab-laptop.localdomain>
References: <1548696702-20686-1-git-send-email-arbab@linux.ibm.com>
 <cd1b7bf3-3c35-09bb-e979-d779b9cf7a18@linux.ibm.com>
 <20190129170347.igcb4yufilshjgri@arbab-laptop.localdomain>
Date: Thu, 31 Jan 2019 00:35:27 +1100
Message-ID: <87fttap8tc.fsf@concordia.ellerman.id.au>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Charles Johns <crjohns@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Reza Arbab <arbab@linux.ibm.com> writes:

> On Tue, Jan 29, 2019 at 08:37:28PM +0530, Aneesh Kumar K.V wrote:
>>Not sure what the fix is about. We set the related hash pte flags via
>>
>>	if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_TOLERANT)
>>		rflags |= HPTE_R_I;
>>	else if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_NON_IDEMPOTENT)
>>		rflags |= (HPTE_R_I | HPTE_R_G);
>>	else if ((pteflags & _PAGE_CACHE_CTL) == _PAGE_SAO)
>>		rflags |= (HPTE_R_W | HPTE_R_I | HPTE_R_M);
>
> Again, nothing broken here, just a code readability thing. As Alexey 
> (and Charlie) noted, given the above it is a little confusing to define 
> _PAGE_CACHE_CTL this way:
>
>   #define _PAGE_CACHE_CTL      (_PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT)

Yeah that's confusing I agree.

It's not really a maintainability thing, because those bits are in the
architecture, so they can't change.

> I like Alexey's idea, maybe just use a literal?
>
>   #define _PAGE_CACHE_CTL 0x30

I prefer your original patch. It serves as documentation on what values
we expect to see in that field.

cheers
