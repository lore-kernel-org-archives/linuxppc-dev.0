Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F06C433F5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Mar 2022 10:43:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFzsZ5hdjz3bbd
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Mar 2022 21:42:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=EBDS7mPx;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFzrw0cNgz2xBq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Mar 2022 21:42:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=EBDS7mPx; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFzrv6f44z4xLR;
 Sat, 12 Mar 2022 21:42:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1647081744;
 bh=TH9KXrjYebp4kThLGs3MQkt1HKA6pqOi8X0JggNKWGM=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=EBDS7mPxppu2kRk37ZKE5kSfTL7rgoTBTRut/ddjoV+C2KD4NFFRgk9s2DxhtJrUM
 EC4CPns5tImsTTrtdTgNgyva+01iAd/oCf9UlAGWPNK8d0mbrQn8Ugy2F1jGdnS9sR
 l4wTc45B/psTFM6M6Al2uCXrgY3N2TouMEZT1TapxdGdrA+aJ4vpmlNIWJk3NIBotp
 Pr8IZrih92RUUs/x6ZwDKdOU6u6oR9o2zEseyR0goNAnH4jdDt2D1+uuWKWnxijmdk
 Nb6s7mlIyRJCc/S9H4be/JBwGNWph80evkkO68m7fC3XbZBtkI3cyWl8Wft5uHMwtg
 sE6W6VGIOFGfg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 kvm-ppc@vger.kernel.org, Fabiano Rosas <farosas@linux.ibm.com>
Subject: Re: [PATCH 0/3] KVM: PPC: KVM module exit fixes
In-Reply-To: <164515018870.908917.9938379332717463951.b4-ty@ellerman.id.au>
References: <20211223211931.3560887-1-farosas@linux.ibm.com>
 <164515018870.908917.9938379332717463951.b4-ty@ellerman.id.au>
Date: Sat, 12 Mar 2022 21:42:23 +1100
Message-ID: <871qz7moz4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Thu, 23 Dec 2021 18:19:28 -0300, Fabiano Rosas wrote:
>> This is a resend the module cleanup fixes but this time without the
>> HV/PR merge.
>> 
>> Fabiano Rosas (1):
>>   KVM: PPC: Book3S HV: Check return value of kvmppc_radix_init
>>   KVM: PPC: Book3S HV: Delay setting of kvm ops
>>   KVM: PPC: Book3S HV: Free allocated memory if module init fails
>> 
>> [...]
>
> Applied to powerpc/topic/ppc-kvm.
>
> [1/3] KVM: PPC: Book3S HV: Check return value of kvmppc_radix_init
>       https://git.kernel.org/powerpc/c/69ab6ac380a00244575de02c406dcb9491bf3368
> [2/3] KVM: PPC: Book3S HV: Delay setting of kvm ops
>       https://git.kernel.org/powerpc/c/c5d0d77b45265905bba2ce6e63c9a02bbd11c43c
> [3/3] KVM: PPC: Book3S HV: Free allocated memory if module init fails
>       https://git.kernel.org/powerpc/c/175be7e5800e2782a7e38ee9e1b64633494c4b44

These commits are actually of the v4 patches, the thanks email script
got confused.

See: https://lore.kernel.org/all/164708144610.832402.1913966629226492244.b4-ty@ellerman.id.au/

cheers
