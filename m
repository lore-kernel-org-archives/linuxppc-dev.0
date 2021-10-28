Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF89C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Oct 2021 11:34:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B666610FF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Oct 2021 11:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B666610FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hg3P85Xvbz3c7q
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Oct 2021 22:34:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=QKN5eSRV;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hg3NV4n0Zz2y7V
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Oct 2021 22:33:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=QKN5eSRV; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hg3NT1vVDz4xcC;
 Thu, 28 Oct 2021 22:33:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1635420825;
 bh=dNBPnTjY2RMV8vvPnvLBDtkCIfy9AbEEaneixRpTWmc=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=QKN5eSRVBHfkEVM+nW8dztlahss6nugvVcm+BHbwJvsfUP1RrZks+nKGq+w9SVCXi
 IBGf3YlJVUxZ7Z/7voMkve5GpvRlSTAWUfzHAaBepeCYuxM0FJM8YQKR9CDGUR8VXA
 Kvvc4E0MrkkSjimdujKUvxAuuYaqdrxDeUstDKVuPNZqscEWsLDmCcxtqhKqYUTch2
 ZE0nJ+ITYzmjyCOmWUJB2vfZyN49u8NstOABAeO6A9HBiYK+NyOtQ0IwA+ogfUa8SX
 yG2dVSt46VCKd801nWUzc9s8e2Cc6ZOv7N5Cfrma634+jaQQepiWAwTt3hRIV7PIGj
 VI25QXhJZKZbA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Nicholas Piggin
 <npiggin@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/3] powerpc/book3e: Fix set_memory_x() and set_memory_nx()
In-Reply-To: <063e72e1-fc05-7783-9f42-f681dd08a4b2@csgroup.eu>
References: <922bdab3a220781bae2360ff3dd5adb7fe4d34f1.1635226743.git.christophe.leroy@csgroup.eu>
 <c41100f9c144dc5b62e5a751b810190c6b5d42fd.1635226743.git.christophe.leroy@csgroup.eu>
 <1635309296.3vv9pb80wz.astroid@bobo.none>
 <063e72e1-fc05-7783-9f42-f681dd08a4b2@csgroup.eu>
Date: Thu, 28 Oct 2021 22:33:40 +1100
Message-ID: <871r459yej.fsf@mpe.ellerman.id.au>
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
> Le 27/10/2021 =C3=A0 06:44, Nicholas Piggin a =C3=A9crit=C2=A0:
>> Excerpts from Christophe Leroy's message of October 26, 2021 3:39 pm:
>>> set_memory_x() calls pte_mkexec() which sets _PAGE_EXEC.
>>> set_memory_nx() calls pte_exprotec() which clears _PAGE_EXEC.
>>>
>>> Book3e has 2 bits, UX and SX, which defines the exec rights
>>> resp. for user (PR=3D1) and for kernel (PR=3D0).
>>>
>>> _PAGE_EXEC is defined as UX only.
>>>
>>> An executable kernel page is set with either _PAGE_KERNEL_RWX
>>> or _PAGE_KERNEL_ROX, which both have SX set and UX cleared.
>>>
>>> So set_memory_nx() call for an executable kernel page does
>>> nothing because UX is already cleared.
>>>
>>> And set_memory_x() on a non-executable kernel page makes it
>>> executable for the user and keeps it non-executable for kernel.
>>>
>>> Also, pte_exec() always returns 'false' on kernel pages, because
>>> it checks _PAGE_EXEC which doesn't include SX, so for instance
>>> the W+X check doesn't work.
>>>
>>> To fix this:
>>> - change tlb_low_64e.S to use _PAGE_BAP_UX instead of _PAGE_USER
>>> - sets both UX and SX in _PAGE_EXEC so that pte_user() returns
>>> true whenever one of the two bits is set
>>=20
>> I don't understand this change. Which pte_user() returns true after
>> this change? Or do you mean pte_exec()?
>
> Oops, yes, I mean pte_exec()
>
> Unless I have to re-spin, can Michael eventually fix that typo while=20
> applying ?

I did.

cheers
