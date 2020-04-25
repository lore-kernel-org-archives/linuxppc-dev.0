Return-Path: <SRS0=123t=6J=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDACC54FCB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 23:59:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564A6206CD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Apr 2020 23:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564A6206CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 498p0m4g5pzDqkR
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2020 09:59:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 498nrg1TlYzDqcm
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2020 09:52:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 498nrg046wz9sSJ; Sun, 26 Apr 2020 09:52:02 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 45591da765885f7320a111d290b3a28a23eed359
In-Reply-To: <20200422154129.11f988fd@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: linux-next: build failure after merge of the powerpc tree
Message-Id: <498nrg046wz9sSJ@ozlabs.org>
Date: Sun, 26 Apr 2020 09:52:02 +1000 (AEST)
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Haren Myneni <haren@linux.ibm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2020-04-22 at 05:41:29 UTC, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the powerpc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> In file included from <command-line>:32:
> ./usr/include/asm/vas-api.h:15:2: error: unknown type name '__u32'
>    15 |  __u32 version;
>       |  ^~~~~
> ./usr/include/asm/vas-api.h:16:2: error: unknown type name '__s16'
>    16 |  __s16 vas_id; /* specific instance of vas or -1 for default */
>       |  ^~~~~
> ./usr/include/asm/vas-api.h:17:2: error: unknown type name '__u16'
>    17 |  __u16 reserved1;
>       |  ^~~~~
> ./usr/include/asm/vas-api.h:18:2: error: unknown type name '__u64'
>    18 |  __u64 flags; /* Future use */
>       |  ^~~~~
> ./usr/include/asm/vas-api.h:19:2: error: unknown type name '__u64'
>    19 |  __u64 reserved2[6];
>       |  ^~~~~
> 
> Caused by commit
> 
>   45f25a79fe50 ("powerpc/vas: Define VAS_TX_WIN_OPEN ioctl API")
> 
> uapi headers should be self contained.  I have added the following patch
> for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Wed, 22 Apr 2020 15:28:26 +1000
> Subject: [PATCH] powerpc/vas: uapi headers should be self contained
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/45591da765885f7320a111d290b3a28a23eed359

cheers
