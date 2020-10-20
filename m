Return-Path: <SRS0=mlYb=D3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C980C433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 12:37:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844EA22282
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 12:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844EA22282
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CFtRX71pXzDqSm
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 23:36:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CFt8X6Lb9zDqJ1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2020 23:23:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4CFt8S1scvz9sRk; Tue, 20 Oct 2020 23:23:52 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CFt8S09QXz9sS8; Tue, 20 Oct 2020 23:23:51 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
In-Reply-To: <20201017164210.264619-1-hegdevasant@linux.vnet.ibm.com>
References: <20201017164210.264619-1-hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/powernv/dump: Fix race while processing OPAL
 dump
Message-Id: <160319651001.2348169.3800545779707198489.b4-ty@ellerman.id.au>
Date: Tue, 20 Oct 2020 23:23:51 +1100 (AEDT)
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
Cc: Mahesh Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 17 Oct 2020 22:12:10 +0530, Vasant Hegde wrote:
> Every dump reported by OPAL is exported to userspace through a sysfs
> interface and notified using kobject_uevent(). The userspace daemon
> (opal_errd) then reads the dump and acknowledges that the dump is
> saved safely to disk. Once acknowledged the kernel removes the
> respective sysfs file entry causing respective resources to be
> released including kobject.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/powernv/dump: Fix race while processing OPAL dump
      https://git.kernel.org/powerpc/c/0a43ae3e2beb77e3481d812834d33abe270768ab

cheers
