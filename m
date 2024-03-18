Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24E3C54E58
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2024 11:52:57 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=bFMdFscK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TytX82F7vz3dnN
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2024 22:52:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=bFMdFscK;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TytWM4Z6cz3byl
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2024 22:52:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1710762733;
	bh=i9CRW+oTEXP2RX7aLfZKKATP+J/BIcxQbk4aW/9GfOg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bFMdFscKQ2QCxC92JgF/Zg79/cxyFcsfp24B6DrhnTNMFC2/Tzo+bMwUBVJVjhY+7
	 Olbnp1jZOS0zZ1U7lUC8/IBUt8lF/oxBCs/WrHKFDLJeLq3RIOz7/SYPTJnhZzglW5
	 RW4mAtNvgvH5JvsSPiKHq/LmYZUom4GwxUegdAVtV+Isaorp9yHWrU9mmpuyGkEiMK
	 LTx/LUSyWEA/Z/3+bvoLsTKUFwIIdeTI+XzFZk0MBxqKnLwHVXTmTqxXNRUw+GKZ7t
	 cLTl7W/72ATt7xOU+tj4BCpOH9sHCvaSyaUHCJw+0FNlSNt196JdqEX/g94NnEgK/u
	 LNGIlswB0H5WA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TytWK0ZL0z4wcF;
	Mon, 18 Mar 2024 22:52:12 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Stephen Rothwell
 <sfr@canb.auug.org.au>, PowerPC <linuxppc-dev@lists.ozlabs.org>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the mm-stable
 tree
In-Reply-To: <61110d70-7b18-40a2-b3d2-6c267ab18096@csgroup.eu>
References: <20240229101721.58569685@canb.auug.org.au>
 <87ttlrg4hm.fsf@mail.lhotse>
 <61110d70-7b18-40a2-b3d2-6c267ab18096@csgroup.eu>
Date: Mon, 18 Mar 2024 22:52:12 +1100
Message-ID: <87o7bbzrir.fsf@mail.lhotse>
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 29/02/2024 =C3=A0 07:37, Michael Ellerman a =C3=A9crit=C2=A0:
>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
>>> Hi all,
>>>
>>> Today's linux-next merge of the powerpc tree got a conflict in:
>>>
>>>    arch/powerpc/mm/pgtable_32.c
>>>
>>> between commit:
>>>
>>>    a5e8131a0329 ("arm64, powerpc, riscv, s390, x86: ptdump: refactor CO=
NFIG_DEBUG_WX")
>>>
>>> from the mm-stable tree and commit:
>>>
>>>    8f17bd2f4196 ("powerpc: Handle error in mark_rodata_ro() and mark_in=
itmem_nx()")
>>>
>>> from the powerpc tree.
>>=20
>> Thanks. That's a fairly ugly conflict.
>>=20
>> Maybe I'll drop that patch until the generic change has gone in.
>>=20
>
> The change is now in linus tree.

Thanks. I have moved my next up and applied your v2 on top of the
upstream changes.

cheers
