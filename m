Return-Path: <SRS0=HlSn=IJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5ACC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Mar 2021 23:26:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE1064F92
	for <linuxppc-dev@archiver.kernel.org>; Thu, 11 Mar 2021 23:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE1064F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DxQ7X0X90z30Gc
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Mar 2021 10:26:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=Mp9KtA2w;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Mp9KtA2w; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DxQ752mvNz2xyD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Mar 2021 10:26:07 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4DxQ711CXQz9sVt;
 Fri, 12 Mar 2021 10:26:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1615505165;
 bh=E/wjRfTwLwTeZtdF+8K681lQgpnJDWERQYIyr2pWj1A=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=Mp9KtA2wbabfGNEAG4yTlb3/fMM0Tv1eaZo6pwYit0dnQQf2ydQGk3IHRd5RQTCwl
 /0wzOYdhQ1nqZRO9YxSYrX81QsYksW6q1EG4QBAhaWsfbW9L/56v32LBvwbpE0fkjb
 acBf9fVvF3ss2/CCA+jka/ZahwElg+HaUEEhbWAHcIGj/sep5vlj1x3RJ8dXIKD1XU
 l2tcL3b+FufTlHB77twz4EiPRYz8rAOUM6MhHhnfjLaNseZiQB/xG4BlaOjo9PazuR
 0k/JMy6SguGvK9L/Yct1RltMbwMp+5U0cSR8eiRGl9Gfwsbr9AHG38SzGUF6HOQuK2
 FwybpQUleqVVg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 npiggin@gmail.com
Subject: Re: [PATCH v2 25/43] powerpc/32: Replace ASM exception exit by C
 exception exit from ppc64
In-Reply-To: <0296d1bc-b37e-43c8-06cf-00ec458fb74e@csgroup.eu>
References: <cover.1615291471.git.christophe.leroy@csgroup.eu>
 <a9a50f475db97fc53795dd778bc14f58029fdd55.1615291473.git.christophe.leroy@csgroup.eu>
 <87tuphkdkz.fsf@mpe.ellerman.id.au>
 <0296d1bc-b37e-43c8-06cf-00ec458fb74e@csgroup.eu>
Date: Fri, 12 Mar 2021 10:26:02 +1100
Message-ID: <87r1kljmr9.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 11/03/2021 =C3=A0 14:46, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> This patch replaces the PPC32 ASM exception exit by C exception exit.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   arch/powerpc/kernel/entry_32.S  | 481 +++++++++-----------------------
>>>   arch/powerpc/kernel/interrupt.c |   4 +
>>>   2 files changed, 132 insertions(+), 353 deletions(-)
>>=20
>> Bisect points to this breaking qemu mac99 for me, with pmac32_defconfig.
>>=20
>> I haven't had time to dig any deeper sorry.
>
> Embarrasing ...

Nah, these things happen.

> I don't get this problem on the 8xx (nohash/32) or the 83xx (book3s/32).
> I don't get this problem with qemu mac99 when using my klibc-based initra=
mfs.
>
> I managed to reproduce it with the rootfs.cpio that I got some time ago f=
rom linuxppc github Wiki.

OK.

I'm using the ppc-rootfs.cpio.gz from here:

  https://github.com/linuxppc/ci-scripts/blob/master/root-disks/Makefile

And the boot script is:

  https://github.com/linuxppc/ci-scripts/blob/master/scripts/boot/qemu-mac99

I've been meaning to write docs on how to use those scripts, but haven't
got around to it.

There's nothing really special though it's just a wrapper around qemu -M ma=
c99.

> I'll investigate it tomorrow.

Thanks.

cheers
