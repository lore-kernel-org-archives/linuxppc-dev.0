Return-Path: <SRS0=lgwO=Q2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E0CC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 04:22:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F81217D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 04:22:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F81217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 443SHh4VntzDqKW
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Feb 2019 15:22:08 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 443SFh5szBzDqH3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2019 15:20:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 443SFh3vWsz9s5c;
 Tue, 19 Feb 2019 15:20:23 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christophe Leroy <christophe.leroy@c-s.fr>, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] powerpc: fix 32-bit KVM-PR lockup and panic with MacOS
 guest
In-Reply-To: <2ed8efb9-5cd4-31bf-6c7b-501b9d1925e6@ilande.co.uk>
References: <20190208143319.11980-1-mark.cave-ayland@ilande.co.uk>
 <41b02fb0-cdc6-6de0-d8fc-44d3d0a8ad70@c-s.fr>
 <2ed8efb9-5cd4-31bf-6c7b-501b9d1925e6@ilande.co.uk>
Date: Tue, 19 Feb 2019 15:20:21 +1100
Message-ID: <87pnrobe9m.fsf@concordia.ellerman.id.au>
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

Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> writes:
> On 08/02/2019 14:45, Christophe Leroy wrote:
>
>> Le 08/02/2019 =C3=A0 15:33, Mark Cave-Ayland a =C3=A9crit=C2=A0:
>>> Commit 8792468da5e1 "powerpc: Add the ability to save FPU without givin=
g it up"
>>=20
>> Expected format for the above is:
>>=20
>> Commit 123456789abc ("text")
>
> Hi Christophe,
>
> Apologies - I'm fairly new at submitting kernel patches, but I can re-sen=
d it in the
> correct format later if required.
>
>>> unexpectedly removed the MSR_FE0 and MSR_FE1 bits from the bitmask used=
 to
>>> update the MSR of the previous thread in __giveup_fpu() causing a KVM-P=
R MacOS
>>> guest to lockup and panic the kernel.

Which kernel is panicking? The guest or the host?

>>> Reinstate these bits to the MSR bitmask to enable MacOS guests to run u=
nder
>>> 32-bit KVM-PR once again without issue.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>=20
>> Should include a Fixes: and a Cc to stable ?
>>=20
>> Fixes: 8792468da5e1 ("powerpc: Add the ability to save FPU without givin=
g it up")
>> Cc: stable@vger.kernel.org
>
> Indeed, but there are still some questions to be asked here:
>
> 1) Why were these bits removed from the original bitmask in the first pla=
ce without
> it being documented in the commit message?

It was almost certainly an accident.

> 2) Is this the right fix? I'm told that MacOS guests already run without =
this patch
> on a G5 under 64-bit KVM-PR which may suggest that this is a workaround f=
or another
> bug elsewhere in the 32-bit powerpc code.

That's slightly worrying. It's hard to say without more detail on why
the guest is crashing.

I think your patch looks OK based just on the fact that it restores the
previous behaviour, so I'll pick it up and pass it through my usual
testing. If nothing breaks I'll merge it.

cheers
