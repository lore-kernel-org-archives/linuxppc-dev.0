Return-Path: <SRS0=Lr1k=PM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAF7C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 12:59:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBCB2070C
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 12:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBCB2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43WPxw3bKlzDqNS
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Jan 2019 23:59:32 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43WPw6119qzDqLq
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jan 2019 23:57:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43WPw55cvZz9s7T; Fri,  4 Jan 2019 23:57:57 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 074400a7be61250d9f0ccec07d5c35ffec4d8d22
X-Patchwork-Hint: ignore
In-Reply-To: <20190104092758.4378-1-malat@debian.org>
To: Mathieu Malaterre <malat@debian.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: Remove 'type' argument from access_ok() function
Message-Id: <43WPw55cvZz9s7T@ozlabs.org>
Date: Fri,  4 Jan 2019 23:57:57 +1100 (AEDT)
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
Cc: Mathieu Malaterre <malat@debian.org>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-01-04 at 09:27:58 UTC, Mathieu Malaterre wrote:
> In commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") an attempt was made to remove a warning by referencing the
> variable `type`, however in commit 96d4f267e40f ("Remove 'type' argument
> from access_ok() function") the variable `type` has been removed.
> 
> Revert commit 05a4ab823983 ("powerpc/uaccess: fix warning/error with
> access_ok()") to fix the following compilation error:
> 
>   arch/powerpc/include/asm/uaccess.h:66:32: error: âtypeâ undeclared (first use in this function)
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/074400a7be61250d9f0ccec07d5c35

cheers
