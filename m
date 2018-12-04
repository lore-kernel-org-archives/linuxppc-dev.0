Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DD4C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:57:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18BF208A3
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 08:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18BF208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438G384Rw1zDqFs
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 19:57:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438G0l5HfczDq7X
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 19:55:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 438G0l354Mz9s55;
 Tue,  4 Dec 2018 19:55:35 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, npiggin@gmail.com, rashmicy@gmail.com
Subject: Re: [PATCH] powerpc/mm: dump block address translation on book3s/32
In-Reply-To: <bab9eb25-a6f4-966c-ceaa-00147b50726d@c-s.fr>
References: <26cc609706833f78e3195e3d35c0372b2f40cae3.1542181167.git.christophe.leroy@c-s.fr>
 <878t1uva0q.fsf@concordia.ellerman.id.au>
 <9cb14c1f-02ce-a2a5-94e6-95afb4d3e168@c-s.fr>
 <87o9ap2uif.fsf@concordia.ellerman.id.au>
 <bab9eb25-a6f4-966c-ceaa-00147b50726d@c-s.fr>
Date: Tue, 04 Dec 2018 19:55:34 +1100
Message-ID: <87zhtlhdrt.fsf@concordia.ellerman.id.au>
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

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 16/11/2018 =C3=A0 11:20, Michael Ellerman a =C3=A9crit=C2=A0:
>> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>>=20
>>> Le 15/11/2018 =C3=A0 12:46, Michael Ellerman a =C3=A9crit=C2=A0:
>>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>>
>>>>> This patch adds a debugfs file to dump block address translation:
>>>>>
>>>>> ~# cat /sys/kernel/debug/block_address_translation
>>>>
>>>> My instinct is it should be in /sys/kernel/debug/powerpc. But I guess
>>>> the other page table dump files are not.
>>>
>>> Lol.
>>>
>>> Looks like we have the same instinct ...
>>>
>>> But you rejected my patch https://patchwork.ozlabs.org/patch/750426/ :)
>>=20
>> Haha. My argument was that the kernel page table dump is not powerpc
>> specific, but this file *is* powerpc specific. Though I guess it's in
>> the same are as the page table / hash table dump, so it may as well live
>> next to them.
>
> I see you took the first version in next-test. It doesn't handle the=20
> case of 64bits phys addresses. v3 does.
>
> I just sent v4 which does to v3 the changes you did (__init and powerpc/=
=20
> subdir)

Thanks, have picked up v4.

cheers
