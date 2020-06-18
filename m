Return-Path: <SRS0=k+Co=77=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AEEC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 12:47:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC59D2070A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 12:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC59D2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nhY92XL2zDqLt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jun 2020 22:47:41 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nhK76QQQzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2020 22:37:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 49nhK64BLQz9sTL; Thu, 18 Jun 2020 22:37:14 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49nhK55kyHz9sSF; Thu, 18 Jun 2020 22:37:13 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200616135617.2937252-1-mpe@ellerman.id.au>
References: <20200616135617.2937252-1-mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/syscalls: Use the number when building SPU
 syscall table
Message-Id: <159248379723.3471720.7761730589256580141.b4-ty@ellerman.id.au>
Date: Thu, 18 Jun 2020 22:37:13 +1000 (AEST)
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
Cc: linux-arch@ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 16 Jun 2020 23:56:16 +1000, Michael Ellerman wrote:
> Currently the macro that inserts entries into the SPU syscall table
> doesn't actually use the "nr" (syscall number) parameter.
> 
> This does work, but it relies on the exact right number of syscall
> entries being emitted in order for the syscal numbers to line up with
> the array entries. If for example we had two entries with the same
> syscall number we wouldn't get an error, it would just cause all
> subsequent syscalls to be off by one in the spu_syscall_table.
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/syscalls: Use the number when building SPU syscall table
      https://git.kernel.org/powerpc/c/1497eea68624f6076bf3eaf66baec3771ea04045
[2/2] powerpc/syscalls: Split SPU-ness out of ABI
      https://git.kernel.org/powerpc/c/35e32a6cb5f694fda54a5f391917e4ceefa0fece

cheers
