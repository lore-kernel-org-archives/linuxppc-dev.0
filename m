Return-Path: <SRS0=IFQS=LJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC3CC48BE5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 13:45:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D99E961439
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 13:45:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D99E961439
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G48hQ2NRvz3cX2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jun 2021 23:45:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RYzFtT3K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=jeyu@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RYzFtT3K; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G48bn46ZJz3gjB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jun 2021 23:41:09 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE7FF61433;
 Tue, 15 Jun 2021 13:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623764466;
 bh=AmuY6XD93X0kTalsW/ktIsUgGaB7gMa/K3RM1ePXtkc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RYzFtT3KnyoPmfW+TmI2uQX9IiuXWK9CcJPOirhiZW9JVyPUSaXlaalpKYKzqYn3/
 Tder3II8QhY1R/j7mXF4Ro0AWES0Ln1RrAZwezoweQSq+HESxVvomJSNh7Pv/sn0Vu
 9DUG46+AUVXI9EFLqva38G6U3m8N6+K25nEeXMYjeshRSqR7agi4iND/sGpiAx87dV
 MI4EAH5cjgkbqqNLXRI+D5/XJcL+mIRuA44aHFX//kejY7qtIZg2OIY7vY8q4H3Uog
 leHERmJ+AEFfxST4ubCCFcfuelZDgvddIxImjSpzYZoMkfXZjZ4h7QyaTMbwChM2AH
 NQcUB4O1Ig0lg==
Date: Tue, 15 Jun 2021 15:41:00 +0200
From: Jessica Yu <jeyu@kernel.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4 1/2] module: add elf_check_module_arch for module
 specific elf arch checks
Message-ID: <YMit7PZwiB87ig2u@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
References: <20210611093959.821525-1-npiggin@gmail.com>
 <20210611093959.821525-2-npiggin@gmail.com>
 <YMdGWjBOmcstBwOl@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <1623722110.amu32mwaqs.astroid@bobo.none>
 <YMiaZOqhHck9iy0n@p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de>
 <20210615125057.GF5077@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210615125057.GF5077@gate.crashing.org>
X-OS: Linux p200300cbcf109700df096d564fe976c3.dip0.t-ipconnect.de
 5.12.9-1-default x86_64
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
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

+++ Segher Boessenkool [15/06/21 07:50 -0500]:
>On Tue, Jun 15, 2021 at 02:17:40PM +0200, Jessica Yu wrote:
>> +int __weak elf_check_module_arch(Elf_Ehdr *hdr)
>> +{
>> +       return 1;
>> +}
>
>But is this a good idea?  It isn't useful to be able to attempt to load
>a module not compiled for your architecture, and it increases the attack
>surface tremendously.  These checks are one of the few things that can
>*not* be weak symbols, imo.

Hm, could you please elaborate a bit more? This patchset is adding
extra Elf header checks specifically for powerpc, and the module
loader usually provides arch-specific hooks via weak symbols. We are
just providing an new hook here, which should act as a no-op if it
isn't used.

So if an architecture wants to provide extra header checks, it can do
so by overriding the new weak symbol. Otherwise, the weak function acts as
a noop. We also already have the existing elf_check_arch() check for each
arch and that is *not* a weak symbol.
