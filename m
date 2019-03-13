Return-Path: <SRS0=wHv8=RQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CE4C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:06:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA032173C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 04:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA032173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Jyvh0Qk8zDq6y
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Mar 2019 15:06:40 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Jysv5WGDzDq6y
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Mar 2019 15:05:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44Jysv14rJz9s4V;
 Wed, 13 Mar 2019 15:05:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH] powerpc/64s: Mark 'dummy_copy_buffer' as used
In-Reply-To: <38359442-e219-18ad-926b-42a6e5ab4e7d@c-s.fr>
References: <20190312202921.31331-1-malat@debian.org>
 <38359442-e219-18ad-926b-42a6e5ab4e7d@c-s.fr>
Date: Wed, 13 Mar 2019 15:05:04 +1100
Message-ID: <8736nr5si7.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> On 03/12/2019 08:29 PM, Mathieu Malaterre wrote:
>> In commit 07d2a628bc00 ("powerpc/64s: Avoid cpabort in context switch
>> when possible") a buffer 'dummy_copy_buffer' was introduced. gcc does
>> not see this buffer being used in the inline assembly within function
>> '__switch_to', explicitly marked this variable as being used.
>> 
>> Prefer using '__aligned' to get passed line over 80 characters warning
>> in checkpatch.
>
> Powerpc accepts 90 characters, use arch/powerpc/tools/checkpatch.sh
>
>> 
>> This remove the following warning:
>> 
>>    arch/powerpc/kernel/process.c:1156:17: error: 'dummy_copy_buffer' defined but not used [-Werror=unused-const-variable=]
>
> commit 2bf1071a8d50 ("powerpc/64s: Remove POWER9 DD1 support") has 
> removed the fonction using 'dummy_copy_buffer' so you should remove it 
> completely.

Yes that would be better, thanks.

cheers
