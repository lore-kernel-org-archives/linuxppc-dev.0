Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE75C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 09:26:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EE512086B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 09:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EE512086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433z223Wq3zDqRt
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 20:26:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433ywp09M3zDqd2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 20:22:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 433ywn5DdVz9s4s; Tue, 27 Nov 2018 20:22:17 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 42e2acde1237878462b028f5a27d9cc5bea7502c
In-Reply-To: <1540220060-30162-1-git-send-email-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [1/9] powerpc/64s: Include cpu header
Message-Id: <433ywn5DdVz9s4s@ozlabs.org>
Date: Tue, 27 Nov 2018 20:22:17 +1100 (AEDT)
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
Cc: Breno Leitao <leitao@debian.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-10-22 at 14:54:12 UTC, Breno Leitao wrote:
> Current powerpc security.c file is defining functions, as
> cpu_show_meltdown(), cpu_show_spectre_v{1,2} and others, that are being
> declared at linux/cpu.h header without including the header file that
> contains these declarations.
> 
> This is being reported by sparse, which thinks that these functions are
> static, due to the lack of declaration:
> 
> 	arch/powerpc/kernel/security.c:105:9: warning: symbol 'cpu_show_meltdown' was not declared. Should it be static?
> 	arch/powerpc/kernel/security.c:139:9: warning: symbol 'cpu_show_spectre_v1' was not declared. Should it be static?
> 	arch/powerpc/kernel/security.c:161:9: warning: symbol 'cpu_show_spectre_v2' was not declared. Should it be static?
> 	arch/powerpc/kernel/security.c:209:6: warning: symbol 'stf_barrier' was not declared. Should it be static?
> 	arch/powerpc/kernel/security.c:289:9: warning: symbol 'cpu_show_spec_store_bypass' was not declared. Should it be static?
> 
> This patch simply includes the proper header (linux/cpu.h) to match
> function definition and declaration.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/42e2acde1237878462b028f5a27d9c

cheers
