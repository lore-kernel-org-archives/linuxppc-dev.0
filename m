Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C839ECDE44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 05:58:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E2120657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 05:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E2120657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lHhD1Dd8zF3KZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 16:58:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lHLF14rfzF3Jy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 16:43:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42lHLD5qp5z9sNH; Wed, 31 Oct 2018 16:43:00 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e901378578c62202594cba0f6c076f3df365ec91
In-Reply-To: <344813002.4841437.1540469274858.JavaMail.zimbra@datacom.com.br>
To: "DATACOM - Felipe.Rechia" <felipe.rechia@datacom.com.br>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/process: Fix flush_all_to_thread for SPE
Message-Id: <42lHLD5qp5z9sNH@ozlabs.org>
Date: Wed, 31 Oct 2018 16:43:00 +1100 (AEDT)
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
Cc: Zaneti <paulo.zaneti@datacom.com.br>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-10-25 at 12:07:54 UTC, "DATACOM - Felipe.Rechia" wrote:
> From: "Felipe Rechia" <felipe.rechia@datacom.com.br>
> Date: Wed, 24 Oct 2018 10:57:22 -0300
> Subject: [PATCH] powerpc/process: Fix flush_all_to_thread for SPE
> 
> Fix a bug introduced by the creation of flush_all_to_thread() for
> processors that have SPE (Signal Processing Engine) and use it to
> compute floating-point operations.
> 
> >From userspace perspective, the problem was seen in attempts of
> computing floating-point operations which should generate exceptions.
> For example:
> 
>   fork();
>   float x = 0.0 / 0.0;
>   isnan(x);           // forked process returns False (should be True)
> 
> The operation above also should always cause the SPEFSCR FINV bit to
> be set. However, the SPE floating-point exceptions were turned off
> after a fork().
> 
> Kernel versions prior to the bug used flush_spe_to_thread(), which
> first saves SPEFSCR register values in tsk->thread and then calls
> giveup_spe(tsk).
> 
> After commit 579e633e764e, the save_all() function was called first
> to giveup_spe(), and then the SPEFSCR register values were saved in
> tsk->thread. This would save the SPEFSCR register values after
> disabling SPE for that thread, causing the bug described above.
> 
> Fixes 579e633e764e ("powerpc: create flush_all_to_thread()")
> Signed-off-by: felipe.rechia <felipe.rechia@datacom.com.br>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e901378578c62202594cba0f6c076f

cheers
