Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1ABC67838
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 02:49:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42ED20831
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 02:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42ED20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Cnbq63xXzDqdm
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 13:49:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43CnTf30hfzDqnT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 13:44:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43CnTf25MBz9s2P; Mon, 10 Dec 2018 13:44:22 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43CnTf1bqGz9s5c; Mon, 10 Dec 2018 13:44:22 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e41b93a6be57e26a4a123345f826a6ac3a213551
X-Patchwork-Hint: ignore
In-Reply-To: <20181206051028.8974-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/boot: Fix build failures with -j 1
Message-Id: <43CnTf1bqGz9s5c@ozlabs.org>
Date: Mon, 10 Dec 2018 13:44:22 +1100 (AEDT)
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
Cc: joel@jms.id.au, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-12-06 at 05:10:28 UTC, Michael Ellerman wrote:
> In commit 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols to
> wrapper") we added a dependency to serial.c on autoconf.h:
> 
>   $(obj)/serial.c: $(obj)/autoconf.h
> 
> This works when building in-tree (ie. with KBUILD_OUTPUT unset)
> because the obj tree is the src tree.
> 
> But when building with eg. O=build and -j 1 the build fails:
> 
>   gcc ... -I../arch/powerpc/boot -c -o arch/powerpc/boot/serial.o arch/powerpc/boot/serial.c
>   gcc: error: arch/powerpc/boot/serial.c: No such file or directory
> 
> Why this is only happening with -j 1 is not clear, when building with
> -j greater than 1 somehow we decide to look for serial.c in the src
> tree (../), eg:
> 
>   gcc -I../arch/powerpc/boot -c -o arch/powerpc/boot/serial.o ../arch/powerpc/boot/serial.c
> 
> Regardless we shouldn't be specifying a dependency on serial.c in the
> build tree, we want to add a dependency to the version in $(srctree)
> so fix the rule to say that.
> 
> Fixes: 5e9dcb6188a4 ("powerpc/boot: Expose Kconfig symbols to wrapper")
> Tested-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/e41b93a6be57e26a4a123345f826a6

cheers
