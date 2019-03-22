Return-Path: <SRS0=ildu=RZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24DDC10F03
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A5D2196F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 12:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A5D2196F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44QjdN2c7czDqV8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Mar 2019 23:29:12 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44QjSk2X7jzDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Mar 2019 23:21:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44QjSj6x16z9sTd; Fri, 22 Mar 2019 23:21:41 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 44QjSj4qcjz9sV3; Fri, 22 Mar 2019 23:21:41 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 92edf8df0ff2ae86cc632eeca0e651fd8431d40d
X-Patchwork-Hint: ignore
In-Reply-To: <20190321042433.20454-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/security: Fix spectre_v2 reporting
Message-Id: <44QjSj4qcjz9sV3@ozlabs.org>
Date: Fri, 22 Mar 2019 23:21:41 +1100 (AEDT)
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
Cc: diana.craciun@nxp.com, mikey@neuling.org, msuchanek@suse.de,
 andrew.donnellan@au1.ibm.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-03-21 at 04:24:33 UTC, Michael Ellerman wrote:
> When I updated the spectre_v2 reporting to handle software count cache
> flush I got the logic wrong when there's no software count cache
> enabled at all.
> 
> The result is that on systems with the software count cache flush
> disabled we print:
> 
>   Mitigation: Indirect branch cache disabled, Software count cache flush
> 
> Which correctly indicates that the count cache is disabled, but
> incorrectly says the software count cache flush is enabled.
> 
> The root of the problem is that we are trying to handle all
> combinations of options. But we know now that we only expect to see
> the software count cache flush enabled if the other options are false.
> 
> So split the two cases, which simplifies the logic and fixes the bug.
> We were also missing a space before "(hardware accelerated)".
> 
> The result is we see one of:
> 
>   Mitigation: Indirect branch serialisation (kernel only)
>   Mitigation: Indirect branch cache disabled
>   Mitigation: Software count cache flush
>   Mitigation: Software count cache flush (hardware accelerated)
> 
> Fixes: ee13cb249fab ("powerpc/64s: Add support for software count cache flush")
> Cc: stable@vger.kernel.org # v4.19+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Michael Neuling <mikey@neuling.org>
> Reviewed-by: Diana Craciun <diana.craciun@nxp.com>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/92edf8df0ff2ae86cc632eeca0e651fd

cheers
