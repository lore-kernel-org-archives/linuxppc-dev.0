Return-Path: <SRS0=vJY5=AC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB6CC433DF
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2020 10:14:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48545248C4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2020 10:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WhFX2fQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48545248C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49qT0k0MMjzDqfd
	for <linuxppc-dev@archiver.kernel.org>; Sun, 21 Jun 2020 20:14:14 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49qSz36t1bzDqc7
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2020 20:12:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=WhFX2fQg; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 49qSz35SBDz9sT6; Sun, 21 Jun 2020 20:12:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49qSz26L3Vz9sSf;
 Sun, 21 Jun 2020 20:12:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1592734367;
 bh=73EbSfvdEUAjZq8zN7sj/qvkEAt7r5fJFhwHZNeTzu0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WhFX2fQgf6uDTODIOOxw/m/EruopCUcZCSs/OEXJ0WOd0qMcPw6MiLC7IpFFjXlAc
 8A2ldVoheZHjDS97QRZaJ4ww7+ZLkwQIBzpj5/JKyDp+khBOoh1illuoGXyLazZhYZ
 0+rWo8qRleqFLcNsCgLK+glSwrwtCsGj06469NEkONPvfKuALmKUeqQ0gKPGZbBAPc
 B1y3xPef5+MWWbkDRx4RkljHxsZdEquDiS+K2X+QWZFEpEhlZyDyMueAGNCPVnaE+1
 BYLXJSeZ08/wzor7UBVa746JWY3FieFXDuHagS02YEdPkF0RxLhzlImphatw2h95sr
 MPBHNE2kSr2PA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Ellerman <patch-notifications@ellerman.id.au>,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/syscalls: Use the number when building SPU
 syscall table
In-Reply-To: <159248379723.3471720.7761730589256580141.b4-ty@ellerman.id.au>
References: <20200616135617.2937252-1-mpe@ellerman.id.au>
 <159248379723.3471720.7761730589256580141.b4-ty@ellerman.id.au>
Date: Sun, 21 Jun 2020 20:13:17 +1000
Message-ID: <875zbkd8w2.fsf@mpe.ellerman.id.au>
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
Cc: linux-arch@ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <patch-notifications@ellerman.id.au> writes:
> On Tue, 16 Jun 2020 23:56:16 +1000, Michael Ellerman wrote:
>> Currently the macro that inserts entries into the SPU syscall table
>> doesn't actually use the "nr" (syscall number) parameter.
>> 
>> This does work, but it relies on the exact right number of syscall
>> entries being emitted in order for the syscal numbers to line up with
>> the array entries. If for example we had two entries with the same
>> syscall number we wouldn't get an error, it would just cause all
>> subsequent syscalls to be off by one in the spu_syscall_table.
>> 
>> [...]
>
> Applied to powerpc/fixes.
>
> [1/2] powerpc/syscalls: Use the number when building SPU syscall table
>       https://git.kernel.org/powerpc/c/1497eea68624f6076bf3eaf66baec3771ea04045
> [2/2] powerpc/syscalls: Split SPU-ness out of ABI
>       https://git.kernel.org/powerpc/c/35e32a6cb5f694fda54a5f391917e4ceefa0fece

Patch 2 dropped.

cheers
