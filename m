Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226EAC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 13:52:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A071020851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 13:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A071020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gQVX5lW3zDqwJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 00:52:04 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gQCk2NlxzDqtt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 00:39:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43gQCj3VYrz9sBn;
 Fri, 18 Jan 2019 00:39:13 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>,
 Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Subject: Re: [PATCH] kbuild: mark prepare0 as PHONY to fix external module
 build
In-Reply-To: <CAK7LNAQKuW8f7BgX8q-Eqa480o6Ch_mZsHyY52h96kifnYepHg@mail.gmail.com>
References: <1547536740-1572-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAQKuW8f7BgX8q-Eqa480o6Ch_mZsHyY52h96kifnYepHg@mail.gmail.com>
Date: Fri, 18 Jan 2019 00:39:13 +1100
Message-ID: <87imyn4d4u.fsf@concordia.ellerman.id.au>
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
Cc: Michal Marek <michal.lkml@markovi.net>,
 Samuel Holland <samuel@sholland.org>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-stable # v4 . 20" <stable@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> On Tue, Jan 15, 2019 at 5:07 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> Commit c3ff2a5193fa ("powerpc/32: add stack protector support")
>> caused kernel panic on PowerPC if an external module is used with
>> CONFIG_STACKPROTECTOR because the 'prepare' target was not executed
>> for the external module build.
>>
>> Commit e07db28eea38 ("kbuild: fix single target build for external
>> module") turned it into a build error because the 'prepare' target is
>> now executed but the 'prepare0' target is missing for the external
>> module build.
>>
>> External module on arm/arm64 with CONFIG_STACKPROTECTOR_PER_TASK is
>> also broken in the same way.
>>
>> Move 'PHONY += prepare0' to the common place. Make is fine with missing
>> rule for phony targets.
>>
>> I minimize the change so it can be easily backported to 4.20.x
>>
>> To fix v4.20 for external modules of PowerPC, please backport
>> e07db28eea38 ("kbuild: fix single target build for external module"),
>> and then this commit.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=201891
>> Fixes: e07db28eea38 ("kbuild: fix single target build for external module")
>> Fixes: c3ff2a5193fa ("powerpc/32: add stack protector support")
>> Fixes: 189af4657186 ("ARM: smp: add support for per-task stack canaries")
>> Fixes: 0a1213fa7432 ("arm64: enable per-task stack canaries")
>> Cc: linux-stable <stable@vger.kernel.org> # v4.20
>> Reported-by: Samuel Holland <samuel@sholland.org>
>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>
> Applied to linux-kbuild/fixes.

Thanks.

cheers
