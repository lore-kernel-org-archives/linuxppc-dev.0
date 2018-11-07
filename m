Return-Path: <SRS0=kkFw=NS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A3FC0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 21:33:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE54E2089F
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Nov 2018 21:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE54E2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42r05q55zhzF3Cb
	for <linuxppc-dev@archiver.kernel.org>; Thu,  8 Nov 2018 08:33:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42qzz7682jzF37W
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Nov 2018 08:27:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42qzz75NZpz9sCs; Thu,  8 Nov 2018 08:27:47 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 28c5bcf74fa07c25d5bd118d1271920f51ce2a98
In-Reply-To: <20181107014934.26428-1-oss@buserror.net>
To: Scott Wood <oss@buserror.net>, Alexander Graf <agraf@suse.de>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: KVM: PPC: Move and undef TRACE_INCLUDE_PATH/FILE
Message-Id: <42qzz75NZpz9sCs@ozlabs.org>
Date: Thu,  8 Nov 2018 08:27:47 +1100 (AEDT)
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
Cc: Scott Wood <oss@buserror.net>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-11-07 at 01:49:34 UTC, Scott Wood wrote:
> TRACE_INCLUDE_PATH and TRACE_INCLUDE_FILE are used by
> <trace/define_trace.h>, so like that #include, they should
> be outside #ifdef protection.
> 
> They also need to be #undefed before defining, in case multiple trace
> headers are included by the same C file.  This became the case on
> book3e after commit cf4a6085151a ("powerpc/mm: Add missing tracepoint for
> tlbie"), leading to the following build error:
> 
>    CC      arch/powerpc/kvm/powerpc.o
> In file included from arch/powerpc/kvm/powerpc.c:51:0:
> arch/powerpc/kvm/trace.h:9:0: error: "TRACE_INCLUDE_PATH" redefined
> [-Werror]
>   #define TRACE_INCLUDE_PATH .
>   ^
> In file included from arch/powerpc/kvm/../mm/mmu_decl.h:25:0,
>                   from arch/powerpc/kvm/powerpc.c:48:
> ./arch/powerpc/include/asm/trace.h:224:0: note: this is the location of
> the previous definition
>   #define TRACE_INCLUDE_PATH asm
>   ^
> cc1: all warnings being treated as errors
> 
> Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
> Signed-off-by: Scott Wood <oss@buserror.net>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/28c5bcf74fa07c25d5bd118d127192

cheers
