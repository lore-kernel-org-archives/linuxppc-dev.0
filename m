Return-Path: <SRS0=Zm8d=AH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF13C433E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 02:57:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66AD207D8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 02:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="SZ6civfF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66AD207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49tM4P3pT3zDqlW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 12:57:25 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49tM0j0ktpzDqQW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2020 12:54:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=SZ6civfF; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49tM0g1HDYz9sRR;
 Fri, 26 Jun 2020 12:54:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1593140051;
 bh=sVH2LhmE0qtYuPEkOwuEc2S1p0IexUYzqYBEM9FkjZU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=SZ6civfFktlk0BpZpCH/Xt2znRv3Os6pO+zGQjNcR1b+rdAwQb9f/6Hwt7mb1C64p
 wzjGnZXPufms3i8jSRidBzHkPYEfS/3qKZN2mBsIN12MbxhqZPcyCN8tySgve/M2au
 Qk9QlZeBc6lvg/zI6ywlc2fXmhSyJhqvRmT/730jkINf2hGdjaZHC91RBE+h5KktcI
 P/ArErCouyUzxOH7UkGPknMEvLmxw4L2SaGqcYfCPG2juw4ekCkKF2fPfuJ7bdGtBN
 EydHF0LuV2diE/bc4Jxm/E5cAvCqH3QTh6PCR5B8M9oLDLGLrbcBsM92Q1rxxj4kaM
 33NMKeaYvrtKg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Harish <harish@linux.ibm.com>
Subject: Re: [PATCH] selftests/powerpc: Fix build issue with output directory
In-Reply-To: <20200625165721.264904-1-harish@linux.ibm.com>
References: <20200625165721.264904-1-harish@linux.ibm.com>
Date: Fri, 26 Jun 2020 12:54:42 +1000
Message-ID: <87o8p6bkp9.fsf@mpe.ellerman.id.au>
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
Cc: Harish <harish@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Harish <harish@linux.ibm.com> writes:
> We use OUTPUT directory as TMPOUT for checking no-pie option. When
> building powerpc/ from selftests directory, the OUTPUT directory
> eventually points to powerpc/pmu/ebb/ and gets removed when
> checking for -no-pie option in try-run routine, subsequently build
> fails with the following

It worked fine until:
  f2f02ebd8f38 ("kbuild: improve cc-option to clean up all temporary files") when building powerpc/ from selftests directory, the

I updated the change log to mention that.

cheers


> $ make -C powerpc
> ...
> ...
> TARGET=ebb; BUILD_TARGET=$OUTPUT/$TARGET; mkdir -p $BUILD_TARGET; make OUTPUT=$BUILD_TARGET -k -C $TARGET all
> make[2]: Entering directory '/home/linux-master/tools/testing/selftests/powerpc/pmu/ebb'
> make[2]: *** No rule to make target 'Makefile'.
> make[2]: Failed to remake makefile 'Makefile'.
> make[2]: *** No rule to make target 'ebb.c', needed by '/home/linux-master/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test'.
> make[2]: *** No rule to make target 'ebb_handler.S', needed by '/home/linux-master/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test'.
> make[2]: *** No rule to make target 'trace.c', needed by '/home/linux-master/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test'.
> make[2]: *** No rule to make target 'busy_loop.S', needed by '/home/linux-master/tools/testing/selftests/powerpc/pmu/ebb/reg_access_test'.
> make[2]: Target 'all' not remade because of errors.
>
> Fix this by adding a suffix to the OUTPUT directory so that the
> failure is avoided
>
> Fixes: 9686813f6e9d ("selftests/powerpc: Fix try-run when source tree is not writable")
> Signed-off-by: Harish <harish@linux.ibm.com>
