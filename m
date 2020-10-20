Return-Path: <SRS0=mlYb=D3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B208FC433E7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 12:39:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98F4822240
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 12:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F4822240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CFtVt4ClDzDqMG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 23:39:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CFt8Y2g9tzDqRG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2020 23:23:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CFt8T0NzBz9sSn; Tue, 20 Oct 2020 23:23:52 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>, mpe@ellerman.id.au
In-Reply-To: <20201013043741.743413-1-mikey@neuling.org>
References: <20201013043741.743413-1-mikey@neuling.org>
Subject: Re: [PATCH 1/2] powerpc: Fix user data corruption with P9N DD2.1 VSX
 CI load workaround emulation
Message-Id: <160319651092.2348169.1397044759676064722.b4-ty@ellerman.id.au>
Date: Tue, 20 Oct 2020 23:23:52 +1100 (AEDT)
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 13 Oct 2020 15:37:40 +1100, Michael Neuling wrote:
> __get_user_atomic_128_aligned() stores to kaddr using stvx which is a
> VMX store instruction, hence kaddr must be 16 byte aligned otherwise
> the store won't occur as expected.
> 
> Unfortunately when we call __get_user_atomic_128_aligned() in
> p9_hmi_special_emu(), the buffer we pass as kaddr (ie. vbuf) isn't
> guaranteed to be 16B aligned. This means that the write to vbuf in
> __get_user_atomic_128_aligned() has the bottom bits of the address
> truncated. This results in other local variables being
> overwritten. Also vbuf will not contain the correct data which results
> in the userspace emulation being wrong and hence user data corruption.
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc: Fix undetected data corruption with P9N DD2.1 VSX CI load emulation
      https://git.kernel.org/powerpc/c/1da4a0272c5469169f78cd76cf175ff984f52f06
[2/2] selftests/powerpc: Make alignment handler test P9N DD2.1 vector CI load workaround
      https://git.kernel.org/powerpc/c/d1781f23704707d350b8c9006e2bdf5394bf91b2

cheers
