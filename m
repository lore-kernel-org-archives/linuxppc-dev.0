Return-Path: <SRS0=fMWd=YF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505A0C4360C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Oct 2019 10:02:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018762089C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Oct 2019 10:02:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 018762089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46r0jp5ZP2zDqNN
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Oct 2019 21:02:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46r0gY2G2zzDqc5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Oct 2019 21:00:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46r0gX5X2dz9sPJ; Sat, 12 Oct 2019 21:00:24 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 612ee81b9461475b5a5612c2e8d71559dd3c7920
In-Reply-To: <20190927062002.3169-1-vaibhav@linux.ibm.com>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/papr_scm: Fix an off-by-one check in
 papr_scm_meta_{get, set}
Message-Id: <46r0gX5X2dz9sPJ@ozlabs.org>
Date: Sat, 12 Oct 2019 21:00:24 +1100 (AEDT)
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
Cc: Vaibhav Jain <vaibhav@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-09-27 at 06:20:02 UTC, Vaibhav Jain wrote:
> A validation check to prevent out of bounds read/write inside
> functions papr_scm_meta_{get,set}() is off-by-one that prevent reads
> and writes to the last byte of the label area.
> 
> This bug manifests as a failure to probe a dimm when libnvdimm is
> unable to read the entire config-area as advertised by
> ND_CMD_GET_CONFIG_SIZE. This usually happens when there are large
> number of namespaces created in the region backed by the dimm and the
> label-index spans max possible config-area. An error of the form below
> usually reported in the kernel logs:
> 
> [  255.293912] nvdimm: probe of nmem0 failed with error -22
> 
> The patch fixes these validation checks there by letting libnvdimm
> access the entire config-area.
> 
> Fixes: 53e80bd042773('powerpc/nvdimm: Add support for multibyte read/write for metadata')
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/612ee81b9461475b5a5612c2e8d71559dd3c7920

cheers
