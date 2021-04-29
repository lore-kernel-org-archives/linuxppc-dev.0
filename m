Return-Path: <SRS0=zlGz=J2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4B3C433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 14:08:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5072C61420
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Apr 2021 14:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5072C61420
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWHR86dykz3fvM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Apr 2021 00:08:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWHJZ32W3z3bpm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Apr 2021 00:02:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FWHJZ0GBWz9tk3; Fri, 30 Apr 2021 00:02:49 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210329113103.476760-1-vaibhav@linux.ibm.com>
References: <20210329113103.476760-1-vaibhav@linux.ibm.com>
Subject: Re: [PATCH] powerpc/papr_scm: Mark nvdimm as unarmed if needed during
 probe
Message-Id: <161970488717.4033873.11862743130806736936.b4-ty@ellerman.id.au>
Date: Fri, 30 Apr 2021 00:01:27 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 29 Mar 2021 17:01:03 +0530, Vaibhav Jain wrote:
> In case an nvdimm is found to be unarmed during probe then set its
> NDD_UNARMED flag before nvdimm_create(). This would enforce a
> read-only access to the ndimm region. Presently even if an nvdimm is
> unarmed its not marked as read-only on ppc64 guests.
> 
> The patch updates papr_scm_nvdimm_init() to force query of nvdimm
> health via __drc_pmem_query_health() and if nvdimm is found to be
> unarmed then set the nvdimm flag ND_UNARMED for nvdimm_create().

Applied to powerpc/next.

[1/1] powerpc/papr_scm: Mark nvdimm as unarmed if needed during probe
      https://git.kernel.org/powerpc/c/adb68c38d8d49a3d60805479c558649bb2182473

cheers
