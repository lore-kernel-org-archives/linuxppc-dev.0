Return-Path: <SRS0=CiaY=UX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6D0C43613
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Jun 2019 11:41:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D557120674
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Jun 2019 11:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D557120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45XS6g30B4zDqV4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Jun 2019 21:41:15 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45XS4Q72KBzDqFm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2019 21:39:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45XS4Q1yBzz9s6w;
 Mon, 24 Jun 2019 21:39:18 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/64s: Rename PPC_INVALIDATE_ERAT to
 PPC_ARCH_300_INVALIDATE_ERAT
In-Reply-To: <1561297021.pyb7y0yjt7.astroid@bobo.none>
References: <20190623104152.13173-1-npiggin@gmail.com>
 <20190623120332.GA7313@gate.crashing.org>
 <1561297021.pyb7y0yjt7.astroid@bobo.none>
Date: Mon, 24 Jun 2019 21:39:17 +1000
Message-ID: <87wohb8b6i.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> Segher Boessenkool's on June 23, 2019 10:03 pm:
>> On Sun, Jun 23, 2019 at 08:41:51PM +1000, Nicholas Piggin wrote:
>>> This makes it clear to the caller that it can only be used on POWER9
>>> and later CPUs.
>> 
>>> -#define PPC_INVALIDATE_ERAT	PPC_SLBIA(7)
>>> +#define PPC_ARCH_300_INVALIDATE_ERAT	PPC_SLBIA(7)
>> 
>> The architecture version is 3.0 (or 3.0B), not "300".  This will work on
>> implementations of later architecture versions as well, so maybe the name
>> isn't so great anyway?
>
> Yeah... this is kernel convention for better or worse. ISA v3.0B
> feature support is called CPU_FTR_ARCH_300, and later architectures
> will advertise that support. For the most part we can use architected
> features (incompatible changes would require additional code).

I'd rather we used 3_0B or something inside the kernel, but I'm not sure
it's worth the churn to rename the existing feature everywhere. And we
can't rename the user visible feature.

But if you're adding a new usage then I'd prefer: PPC_ISA_3_0B_INVALIDATE_ERAT

I dislike "300" because it implies we support ISA v3.0 but we actually
don't, we only support v3.0B.

cheers
