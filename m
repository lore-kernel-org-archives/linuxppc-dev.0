Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6AEC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:23:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 382D62087E
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 09:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 382D62087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ymy9721hzDqRp
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 20:22:57 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Ymvw3tZDzDqQQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jan 2019 20:21:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43Ymvw1zWCz9sMp;
 Tue,  8 Jan 2019 20:21:00 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Breno Leitao <leitao@debian.org>,
 LEROY Christophe <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3 1/2] selftests/powerpc: Add MSR bits
In-Reply-To: <5af4e47a-f444-e259-1e09-1edf95d6595a@debian.org>
References: <20190103181947.Horde.sGoDsMMUO3-VuetfCM1WTw7@messagerie.si.c-s.fr>
 <5af4e47a-f444-e259-1e09-1edf95d6595a@debian.org>
Date: Tue, 08 Jan 2019 20:20:58 +1100
Message-ID: <87k1jftshx.fsf@concordia.ellerman.id.au>
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
Cc: mikey@neuling.org, linuxppc-dev@lists.ozlabs.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Breno Leitao <leitao@debian.org> writes:

> hi Christophe,
>
> On 1/3/19 3:19 PM, LEROY Christophe wrote:
>> Breno Leitao <leitao@debian.org> a =C3=A9crit=C2=A0:
>>=20
>>> This patch simply adds definitions for the MSR bits and some macros to
>>> test for MSR TM bits.
>>>
>>> This was copied from arch/powerpc/include/asm/reg.h generic MSR part.
>>=20
>> Can't we find a way to avoid duplicating such defines ?
>
> I think there are three possible ways, but none of them respect the premi=
ses
> we are used too. These are the possible ways I can think of:
>
> 1) Including arch/powerpc/include/asm as part of the selftest compilation
> process.
>    Problem: This might break the selftest independence of the kbuild syst=
em.
>
> 2) Generate a temporary header file inside selftests/include which contai=
ns
> these macros at compilation time.
>    Problem: The problem as above.
>
> 3) Define MSR fields at userspace headers (/usr/include).
>    Problem: I am not sure userspace should have MSR bits information.
>
> Do you suggest me to investigate any other way?

In this case I think we can probably just copy the few #defines we need.

If we decide in future we need all or most of the MSR defines then I
would suggest we:
 - split *only* the MSR defines into arch/powerpc/include/asm/msr.h
 - include that file from reg.h
 - symlink that into the selftest code


cheers
