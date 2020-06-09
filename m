Return-Path: <SRS0=Er2m=7W=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4318CC433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:28:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED6CB20760
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 06:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED6CB20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49h0YK1zj7zDqdw
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Jun 2020 16:28:05 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49gzFn3kWJzDqRr
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Jun 2020 15:29:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49gzFf057Gz9sTl; Tue,  9 Jun 2020 15:29:22 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nathan Chancellor <natechancellor@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20200518181043.3363953-1-natechancellor@gmail.com>
References: <87a7254bxd.fsf@mpe.ellerman.id.au>
 <20200518181043.3363953-1-natechancellor@gmail.com>
Subject: Re: [PATCH] input: i8042: Remove special PowerPC handling
Message-Id: <159168032784.1381411.6982899186952383628.b4-ty@ellerman.id.au>
Date: Tue,  9 Jun 2020 15:29:22 +1000 (AEST)
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
Cc: clang-built-linux@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
 kbuild test robot <lkp@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 18 May 2020 11:10:43 -0700, Nathan Chancellor wrote:
> This causes a build error with CONFIG_WALNUT because kb_cs and kb_data
> were removed in commit 917f0af9e5a9 ("powerpc: Remove arch/ppc and
> include/asm-ppc").
> 
> ld.lld: error: undefined symbol: kb_cs
> > referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> > input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> > referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> > input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> > referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> > input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> 
> [...]

Applied to powerpc/next.

[1/1] input: i8042 - Remove special PowerPC handling
      https://git.kernel.org/powerpc/c/e4f4ffa8a98c24a4ab482669b1e2b4cfce3f52f4

cheers
