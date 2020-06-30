Return-Path: <SRS0=gM2d=AL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C037EC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 12:27:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7966020672
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 12:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7966020672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49x3Wy6QS4zDqWZ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jun 2020 22:27:10 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49x3Sg56VjzDqCq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jun 2020 22:24:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49x3Sg4D78z9sRN; Tue, 30 Jun 2020 22:24:19 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200627070147.297535-1-aneesh.kumar@linux.ibm.com>
References: <20200627070147.297535-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/mm/book3s54/pkeys: make pkey access check
 work on execute_only_key
Message-Id: <159351994150.275830.15225538211713464921.b4-ty@ellerman.id.au>
Date: Tue, 30 Jun 2020 22:24:19 +1000 (AEST)
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
Cc: Jan Stancek <jstancek@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 27 Jun 2020 12:31:46 +0530, Aneesh Kumar K.V wrote:
> pkey_access_permitted() should not check for pkey is available in UAMOR or not.
> The kernel needs to do that check only while allocating keys. This also makes
> sure execute_only_key which is marked as non-manageable via UAMOR gives the
> right access check return w.r.t pkey_access_permitted().
> 
> This fix the page fault loop when using PROT_EXEC as below
> 
> [...]

Patch 1 applied to powerpc/fixes.

[1/2] powerpc/mm/pkeys: Make pkey access check work on execute_only_key
      https://git.kernel.org/powerpc/c/19ab500edb5d6020010caba48ce3b4ce4182ab63

cheers
