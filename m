Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21188C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 12:59:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96F3E2146E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 12:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F3E2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PVPX5GWpzDqQD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 23:59:44 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PVLt3jlxzDqPg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 23:57:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44PVLt2KCpz9sPH; Wed, 20 Mar 2019 23:57:26 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44PVLt0RZBz9sP3;
 Wed, 20 Mar 2019 23:57:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v5 05/10] powerpc: Add a framework for Kernel Userspace
 Access Protection
In-Reply-To: <b1d292b5-5844-34c6-c388-2ad2045e1904@c-s.fr>
References: <20190308011619.22402-1-mpe@ellerman.id.au>
 <20190308011619.22402-5-mpe@ellerman.id.au>
 <b1d292b5-5844-34c6-c388-2ad2045e1904@c-s.fr>
Date: Wed, 20 Mar 2019 23:57:24 +1100
Message-ID: <87r2b1ya8b.fsf@concordia.ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 08/03/2019 =C3=A0 02:16, Michael Ellerman a =C3=A9crit=C2=A0:
>> From: Christophe Leroy <christophe.leroy@c-s.fr>
>>=20
>> This patch implements a framework for Kernel Userspace Access
>> Protection.
>>=20
>> Then subarches will have the possibility to provide their own
>> implementation by providing setup_kuap() and
>> allow/prevent_user_access().
>>=20
>> Some platforms will need to know the area accessed and whether it is
>> accessed from read, write or both. Therefore source, destination and
>> size and handed over to the two functions.
>>=20
>> mpe: Rename to allow/prevent rather than unlock/lock, and add
>> read/write wrappers. Drop the 32-bit code for now until we have an
>> implementation for it. Add kuap to pt_regs for 64-bit as well as
>> 32-bit. Don't split strings, use pr_crit_ratelimited().
>>=20
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>> v5: Futex ops need read/write so use allow_user_acccess() there.
>>      Use #ifdef CONFIG_PPC64 in kup.h to fix build errors.
>>      Allow subarch to override allow_read/write_from/to_user().
>
> Those little helpers that will just call allow_user_access() when=20
> distinct read/write handling is not performed looks overkill to me.
>
> Can't the subarch do it by itself based on the nullity of from/to ?
>
> static inline void allow_user_access(void __user *to, const void __user=20
> *from,
> 				     unsigned long size)
> {
> 	if (to & from)
> 		set_kuap(0);
> 	else if (to)
> 		set_kuap(AMR_KUAP_BLOCK_READ);
> 	else if (from)
> 		set_kuap(AMR_KUAP_BLOCK_WRITE);
> }

You could implement it that way, but it reads better at the call sites
if we have:

	allow_write_to_user(uaddr, sizeof(*uaddr));
vs:
	allow_user_access(uaddr, NULL, sizeof(*uaddr));

So I'm inclined to keep them. It should all end up inlined and generate
the same code at the end of the day.

cheers
