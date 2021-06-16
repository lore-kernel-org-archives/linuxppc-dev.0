Return-Path: <SRS0=sb+l=LK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB394C48BE5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 02:39:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F317761246
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 02:39:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F317761246
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G4TtM1Zvqz3bwb
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jun 2021 12:39:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=HFV/sTAX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=HFV/sTAX; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G4Tsw19k6z2y0G
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jun 2021 12:39:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4G4Tst5V3Xz9sTD;
 Wed, 16 Jun 2021 12:39:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1623811170;
 bh=imTZXZdnzJHPt2ZWyWGHRNA6wmOp1nSPOi8QzrlkB4s=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=HFV/sTAX53bf9R+6Dm3zy428RVTv2CttzChX6iY6NYOIzRmlgXF3OFoBjB7BPE8BG
 /bChHWVQOR7cC6khg4yoGgO9VJEYXjaY3vS/juv5fngCzofmfZmCTXmr6xxRbLRS5i
 BBqUlr6sHCaShQ9THEmts03bqT12lnuLlbc3Apc3yKA17MVqMDfQ6I8meOnV7WLNoQ
 KbhipHpWWsqqO51dm4r7NuHN5d2KWpjUa1xAzSryYSFUH2NHTUuvf0rv3+QRsX2QXy
 YGTFkMFMukem+2xGONbdMGSgSFo54KmV0IAN6Jn5gQJOf1pV/cwqEEZV7AEdNmxr5Y
 +Wfp2MshMxLRw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>, Jessica Yu
 <jeyu@kernel.org>
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module
 specific elf arch checks
In-Reply-To: <20210615143038.GH5077@gate.crashing.org>
References: <20210611093959.821525-1-npiggin@gmail.com>
 <20210611093959.821525-2-npiggin@gmail.com>
 <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <1623722110.amu32mwaqs.astroid@bobo.none>
 <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <20210615125057.GF5077@gate.crashing.org>
 <YMit7PZwiB87ig2u@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <20210615143038.GH5077@gate.crashing.org>
Date: Wed, 16 Jun 2021 12:39:30 +1000
Message-ID: <87sg1isfbx.fsf@mpe.ellerman.id.au>
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
Cc: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Tue, Jun 15, 2021 at 03:41:00PM +0200, Jessica Yu wrote:
>> +++ Segher Boessenkool [15/06/21 07:50 -0500]:
>> >On Tue, Jun 15, 2021 at 02:17:40PM +0200, Jessica Yu wrote:
>> >>+int __weak elf_check_module_arch(Elf_Ehdr *hdr)
>> >>+{
>> >>+       return 1;
>> >>+}
>> >
>> >But is this a good idea?  It isn't useful to be able to attempt to load
>> >a module not compiled for your architecture, and it increases the attack
>> >surface tremendously.  These checks are one of the few things that can
>> >*not* be weak symbols, imo.
>> 
>> Hm, could you please elaborate a bit more? This patchset is adding
>> extra Elf header checks specifically for powerpc, and the module
>> loader usually provides arch-specific hooks via weak symbols. We are
>> just providing an new hook here, which should act as a no-op if it
>> isn't used.
>> 
>> So if an architecture wants to provide extra header checks, it can do
>> so by overriding the new weak symbol. Otherwise, the weak function acts as
>> a noop. We also already have the existing elf_check_arch() check for each
>> arch and that is *not* a weak symbol.
>
> The way I read your patch the default elf_check_module_arch does not
> call elf_check_arch?  Is that clearly called elsewhere and I'm just
> dumb again?  Sorry for the distraction in that case :-/

Yeah elf_check_arch() is already called from elf_validity_check(), and
that call would remain.

cheers
