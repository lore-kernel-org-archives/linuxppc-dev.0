Return-Path: <SRS0=mkti=OU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBA5C5CFFE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 13:48:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2744D2054F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 13:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2744D2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Dh956cDhzDr0f
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Dec 2018 00:48:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Dh6S73MMzDqgM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2018 00:45:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43Dh6S55N5z9s3q; Wed, 12 Dec 2018 00:45:52 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a225f1567405558fb5410e9b2b90805819df1c67
X-Patchwork-Hint: ignore
In-Reply-To: <20181207155605.GB28964@altlinux.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v5] powerpc/ptrace: replace ptrace_report_syscall() with a
 tracehook call
Message-Id: <43Dh6S55N5z9s3q@ozlabs.org>
Date: Wed, 12 Dec 2018 00:45:52 +1100 (AEDT)
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
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 Eugene Syromyatnikov <esyr@redhat.com>,
 Elvira Khabirova <lineprinter@altlinux.org>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, Breno Leitao <leitao@debian.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2018-12-07 at 15:56:05 UTC, "Dmitry V. Levin" wrote:
> From: Elvira Khabirova <lineprinter@altlinux.org>
> 
> Arch code should use tracehook_*() helpers, as documented
> in include/linux/tracehook.h,
> ptrace_report_syscall() is not expected to be used outside that file.
> 
> The patch does not look very nice, but at least it is correct
> and opens the way for PTRACE_GET_SYSCALL_INFO API.
> 
> Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
> Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Eugene Syromyatnikov <esyr@redhat.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/a225f1567405558fb5410e9b2b9080

cheers
