Return-Path: <SRS0=1E/h=NL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3B15C0044C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 05:56:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9620F20657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 05:56:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9620F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42lHfK4wTjzF3Kc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 31 Oct 2018 16:56:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42lHLD3Cg7zF3Jy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Oct 2018 16:43:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42lHLD2GqWz9sNF; Wed, 31 Oct 2018 16:43:00 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8dce6b2215eaa91dbf04463e11098a48748da5ab
In-Reply-To: <1540258332-15520-1-git-send-email-tyreld@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/pseries: add missing cpumask.h include file
Message-Id: <42lHLD2GqWz9sNF@ozlabs.org>
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
Cc: nfont@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-10-23 at 01:32:12 UTC, Tyrel Datwyler wrote:
> Build error is encountered when inlcuding <asm/rtas.h> if no explicit or
> implicit include of cpumask.h exists in the including file.
> 
> In file included from arch/powerpc/platforms/pseries/hotplug-pci.c:3:0:
> ./arch/powerpc/include/asm/rtas.h:360:34: error: unknown type name 'cpumask_var_t'
>  extern int rtas_online_cpus_mask(cpumask_var_t cpus);
>                                   ^
> ./arch/powerpc/include/asm/rtas.h:361:35: error: unknown type name 'cpumask_var_t'
>  extern int rtas_offline_cpus_mask(cpumask_var_t cpus);
> 
> Fixes: 120496ac2d2d ("powerpc: Bring all threads online prior to migration/hibernation")
> Signed-off-by: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8dce6b2215eaa91dbf04463e11098a

cheers
