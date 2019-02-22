Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3953C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:31:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 500632070D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 11:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 500632070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445TgZ6dQXzDqWW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 22:31:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445TcC6CvqzDqWH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 22:28:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 445TcC37gYz9s8m;
 Fri, 22 Feb 2019 22:28:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the powerpc tree
In-Reply-To: <535192d6-2142-05a6-4088-0f71d744c345@c-s.fr>
References: <20190222181403.4ce373bd@canb.auug.org.au>
 <535192d6-2142-05a6-4088-0f71d744c345@c-s.fr>
Date: Fri, 22 Feb 2019 22:28:26 +1100
Message-ID: <87tvgwkqp1.fsf@concordia.ellerman.id.au>
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 22/02/2019 =C3=A0 08:14, Stephen Rothwell a =C3=A9crit=C2=A0:
>> Hi all,
>>=20
>> After merging the powerpc tree, today's linux-next build (powerpc
>> allyesconfig) failed like this:
>>=20
>> make[4]: *** No rule to make target 'arch/powerpc/mm/ptdump/core.o', nee=
ded by 'arch/powerpc/mm/ptdump/built-in.a'.
>>=20
>> Caused by commit
>>=20
>>    5df1cfa43394 ("powerpc: Move page table dump files in a dedicated sub=
directory")
>>=20
>> I have reverted that commit for today.
>
> In the Makefile, replace core.o by ptdump.o (or rename the file ptdump.c=
=20
> to core.c). Michael, what was your intention ?

To not break the build :}

I originally used core.c but then decided ptdump.c was clearer.

My jenkins was unhappy last night due to a distro upgrade so my builds
didn't run and catch the breakage.

I'll just fix it and force push.

cheers
