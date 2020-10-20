Return-Path: <SRS0=mlYb=D3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5BDC433DF
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 12:34:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5D8922265
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 12:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D8922265
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CFtN61RQKzDqjj
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Oct 2020 23:33:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CFt8W1KYyzDqhK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2020 23:23:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4CFt8R2XZqz9sRK; Tue, 20 Oct 2020 23:23:51 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4CFt8Q752Pz9sRR; Tue, 20 Oct 2020 23:23:50 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@ozlabs.org, Vasant Hegde <hegdevasant@linux.vnet.ibm.com>
In-Reply-To: <20201017164236.264713-1-hegdevasant@linux.vnet.ibm.com>
References: <20201017164236.264713-1-hegdevasant@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv/dump: Handle multiple writes to ack
 attribute
Message-Id: <160319651032.2348169.7593409271532136155.b4-ty@ellerman.id.au>
Date: Tue, 20 Oct 2020 23:23:50 +1100 (AEDT)
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
 Mahesh Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 17 Oct 2020 22:12:36 +0530, Vasant Hegde wrote:
> Even though we use self removing sysfs helper, we still need
> to make sure we do the final kobject delete conditionally.
> sysfs_remove_file_self() will handle parallel calls to remove
> the sysfs attribute file and returns true only in the caller
> that removed the attribute file. The other parallel callers
> are returned false. Do the final kobject delete checking
> the return value of sysfs_remove_file_self().

Applied to powerpc/fixes.

[1/1] powerpc/powernv/dump: Handle multiple writes to ack attribute
      https://git.kernel.org/powerpc/c/358ab796ce78ba271a6ff82834183ffb2cb68c4c

cheers
