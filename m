Return-Path: <SRS0=IFvE=LU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75997C49EA6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 10:45:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E91226191E
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 10:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91226191E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GBr9z4JW3z3fpv
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Jun 2021 20:45:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GBr2h40xJz3c0k
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jun 2021 20:39:08 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GBr2g376Rz9srZ; Sat, 26 Jun 2021 20:39:07 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org,
 linuxppc-dev@lists.ozlabs.org, nvdimm@lists.linux.dev
In-Reply-To: <20210624080621.252038-1-vaibhav@linux.ibm.com>
References: <20210624080621.252038-1-vaibhav@linux.ibm.com>
Subject: Re: [RESEND-PATCH v2] powerpc/papr_scm: Add support for reporting
 dirty-shutdown-count
Message-Id: <162470384292.3589875.8300920085497091770.b4-ty@ellerman.id.au>
Date: Sat, 26 Jun 2021 20:37:22 +1000
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Santosh Sivaraj <santosh@fossix.org>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 24 Jun 2021 13:36:21 +0530, Vaibhav Jain wrote:
> Persistent memory devices like NVDIMMs can loose cached writes in case
> something prevents flush on power-fail. Such situations are termed as
> dirty shutdown and are exposed to applications as
> last-shutdown-state (LSS) flag and a dirty-shutdown-counter(DSC) as
> described at [1]. The latter being useful in conditions where multiple
> applications want to detect a dirty shutdown event without racing with
> one another.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/papr_scm: Add support for reporting dirty-shutdown-count
      https://git.kernel.org/powerpc/c/de21e1377c4fe65bfd8d31e446482c1bc2232997

cheers
