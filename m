Return-Path: <SRS0=N2pq=UR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F38AC31E51
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 12:36:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10D72084D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 12:36:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10D72084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45SndQ4pQYzDqdW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Jun 2019 22:36:42 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45SnWV5tXDzDqbc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2019 22:31:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45SnWN5bq5z9s9y;
 Tue, 18 Jun 2019 22:31:28 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, erhard_f@mailbox.org
Subject: Re: [PATCH] powerpc/32s: fix initial setup of segment registers on
 secondary CPU
In-Reply-To: <b60946f5-dc70-61ce-e266-af91890cb702@c-s.fr>
References: <be07403806abc56ec027f6d47468411876e18bb5.1560267983.git.christophe.leroy@c-s.fr>
 <b60946f5-dc70-61ce-e266-af91890cb702@c-s.fr>
Date: Tue, 18 Jun 2019 22:31:26 +1000
Message-ID: <87h88noz1d.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> Le 11/06/2019 =C3=A0 17:47, Christophe Leroy a =C3=A9crit=C2=A0:
>> The patch referenced below moved the loading of segment registers
>> out of load_up_mmu() in order to do it earlier in the boot sequence.
>> However, the secondary CPU still needs it to be done when loading up
>> the MMU.
>>=20
>> Reported-by: Erhard F. <erhard_f@mailbox.org>
>> Fixes: 215b823707ce ("powerpc/32s: set up an early static hash table for=
 KASAN")
>
> Cc: stable@vger.kernel.org

Sorry patchwork didn't pick that up and I missed it. The AUTOSEL bot
will probably pick it up anyway though.

cheers

>> diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32=
.S
>> index 1d5f1bd0dacd..f255e22184b4 100644
>> --- a/arch/powerpc/kernel/head_32.S
>> +++ b/arch/powerpc/kernel/head_32.S
>> @@ -752,6 +752,7 @@ __secondary_start:
>>   	stw	r0,0(r3)
>>=20=20=20
>>   	/* load up the MMU */
>> +	bl	load_segment_registers
>>   	bl	load_up_mmu
>>=20=20=20
>>   	/* ptr to phys current thread */
>>=20
