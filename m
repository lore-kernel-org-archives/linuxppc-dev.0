Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B1C432BE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 14:27:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D713D60F91
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 14:27:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D713D60F91
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GwQCb2xG3z2yZd
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Aug 2021 00:27:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=kNmPLfrB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=kNmPLfrB; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GwQBv65ZFz2xrZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Aug 2021 00:26:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4GwQBt1DP4z9sWS;
 Fri, 27 Aug 2021 00:26:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1629987991;
 bh=8REjizoyXa6lG5/G29mltG5ReN+I4Z6Qc6NDe7l49QM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kNmPLfrBKi04ZkPkGpmV7+/oJadisLEfK1+pFTyhStOvkRxkseTXEN8PdArVzP5Cm
 kRFq1EOMrB1WoWaQM79CrgGuwALLpz0MEZ80j82uHAeJM7KH14mHCJe8RKd5QD59pD
 UwSTK0ac1IZh5fpEewtwXUQqfRCiMgd+3yS5aId8VihS4/jPW17sOR1u+PvmKSd71C
 zDJ82ruv1AKxXlOA9+KYj9lYzK16CK1h6NaLa2QRw9bBx+5ov8BwzUSXR2Xb+fiR6p
 g2Jp0Qbd3DsZAR4wswp/IsCbTULnB48hNjOEMRrnrZolEFW68ftEX+vJ6/Tdpb9SWa
 w/P035zUTKlnQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Shuah Khan
 <skhan@linuxfoundation.org>, cgel.zte@gmail.com
Subject: Re: [PATCH linux-next] powerpc/tm: remove duplicate include in
 tm-poison.c
In-Reply-To: <4bc97c33-7fc0-ff9d-041b-e773f682c5d2@csgroup.eu>
References: <20210805065255.628170-1-yong.yiran@zte.com.cn>
 <c5e9900b-1c2d-8e72-ad83-a6024b876fd2@linuxfoundation.org>
 <4bc97c33-7fc0-ff9d-041b-e773f682c5d2@csgroup.eu>
Date: Fri, 27 Aug 2021 00:26:29 +1000
Message-ID: <87wno89t9m.fsf@mpe.ellerman.id.au>
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
Cc: yong.yiran@zte.com.cn, shuah@kernel.org, Zeal Robot <zealci@zte.com.cn>,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 24/08/2021 =C3=A0 16:40, Shuah Khan a =C3=A9crit=C2=A0:
>> On 8/5/21 12:52 AM, cgel.zte@gmail.com wrote:
>>> From: yong yiran <yong.yiran@zte.com.cn>
>>>
>>> 'inttypes.h' included in 'tm-poison.c' is duplicated.
>>> Remove all but the first include of inttypes.h from tm-poison.c.
>>>
>>> Reported-by: Zeal Robot <zealci@zte.com.cn>
>>> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>
>>> ---
>>> =C2=A0 tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
>>> =C2=A0 1 file changed, 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c=20
>>> b/tools/testing/selftests/powerpc/tm/tm-poison.c
>>> index 29e5f26af7b9..27c083a03d1f 100644
>>> --- a/tools/testing/selftests/powerpc/tm/tm-poison.c
>>> +++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
>>> @@ -20,7 +20,6 @@
>>> =C2=A0 #include <sched.h>
>>> =C2=A0 #include <sys/types.h>
>>> =C2=A0 #include <signal.h>
>>> -#include <inttypes.h>
>>> =C2=A0 #include "tm.h"
>>>
>>=20
>> We can't accept this patch. The from and Signed-off-by don't match.
>>=20
>
> As far as I can see they match. You have:
>
> From: yong yiran <yong.yiran@zte.com.cn>
> Signed-off-by: yong yiran <yong.yiran@zte.com.cn>

Regardless I already have a patch queued to fix this, from a different
CI bot.

cheers
