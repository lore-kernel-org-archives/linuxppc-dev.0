Return-Path: <SRS0=any3=BQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644AFC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 02:20:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1731120823
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 02:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="b9vZ105T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1731120823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BMXJp5fqxzDqg9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 12:20:26 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BMXGr6L8PzDqcW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2020 12:18:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=b9vZ105T; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BMXGr3hqyz9sTM; Thu,  6 Aug 2020 12:18:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BMXGr2Ylsz9sPC;
 Thu,  6 Aug 2020 12:18:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1596680324;
 bh=1RUaF9tw2UTRv8DSk29zVGzJyXOl0nVehwqC6A6hhwQ=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=b9vZ105T71HacHPQjR/COSG4kksneAo0BnsQvwxA2afrOtzLvISduDzCbXKbqopT/
 5xkQNs2HJmHlzE4OQkx7w029yaLiA1+MXhrI6xWtR1uHcdspS0QFtFbIbqMHTlQnyd
 8Qqn4u3ZB06FDawdMKiDKnKRIIpEGDlc4dRYAWQGGDWeJeMHUZIXt70XLT6LjPAXq2
 zliupHWTLfN8s+r5IBGQ/148B6Q54WPc1skgSR0gpHH9Q8GX1gVwSBmKuRKfTots2O
 jJ2bcyzWrnrpPh4x9CbrBYd7hF+H6agOxcnttAMAcBQ0+ZWLkRJTqm6qMdnm5VYitD
 DiLlgjZZQWTCg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/40x: Fix assembler warning about r0
In-Reply-To: <bc70ddd8-d48d-d939-dce0-5aa8b8cf87d8@csgroup.eu>
References: <20200722022422.825197-1-mpe@ellerman.id.au>
 <bc70ddd8-d48d-d939-dce0-5aa8b8cf87d8@csgroup.eu>
Date: Thu, 06 Aug 2020 12:18:43 +1000
Message-ID: <87o8noy0sc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 22/07/2020 =C3=A0 04:24, Michael Ellerman a =C3=A9crit=C2=A0:
>> The assembler says:
>>    arch/powerpc/kernel/head_40x.S:623: Warning: invalid register express=
ion
>
> I get exactly the same with head_32.S, for the exact same reason.

Ah yep, I see it. I mostly build pmac32_defconfig which doesn't have
BDI_SWITCH enabled.

Send a patch? :)

Do we still need the BDI_SWITCH code? Is it likely anyone still has one,
that works?

cheers
