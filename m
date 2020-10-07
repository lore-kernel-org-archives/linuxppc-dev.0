Return-Path: <SRS0=XBts=DO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AA7C4363C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 03:28:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D5D1208C3
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 03:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D5D1208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C5ft51Mj3zDqJR
	for <linuxppc-dev@archiver.kernel.org>; Wed,  7 Oct 2020 14:27:57 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C5fkK69FYzDqFB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Oct 2020 14:21:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4C5fkK0WkWz9sV0; Wed,  7 Oct 2020 14:21:13 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4C5fkJ2jqQz9sTq; Wed,  7 Oct 2020 14:21:12 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Scott Cheloha <cheloha@linux.ibm.com>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200915194647.3334645-1-cheloha@linux.ibm.com>
References: <20200915194647.3334645-1-cheloha@linux.ibm.com>
Subject: Re: [PATCH v3] pseries/hotplug-memory: hot-add: skip redundant LMB
 lookup
Message-Id: <160204082755.257875.16777136657895196035.b4-ty@ellerman.id.au>
Date: Wed,  7 Oct 2020 14:21:12 +1100 (AEDT)
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
Cc: Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Michal Suchanek <msuchanek@suse.de>,
 Rick Lindsley <ricklind@linux.vnet.ibm.com>,
 Nathan Lynch <nathanl@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 15 Sep 2020 14:46:47 -0500, Scott Cheloha wrote:
> During memory hot-add, dlpar_add_lmb() calls memory_add_physaddr_to_nid()
> to determine which node id (nid) to use when later calling __add_memory().
> 
> This is wasteful.  On pseries, memory_add_physaddr_to_nid() finds an
> appropriate nid for a given address by looking up the LMB containing the
> address and then passing that LMB to of_drconf_to_nid_single() to get the
> nid.  In dlpar_add_lmb() we get this address from the LMB itself.
> 
> [...]

Applied to powerpc/next.

[1/1] pseries/hotplug-memory: hot-add: skip redundant LMB lookup
      https://git.kernel.org/powerpc/c/72cdd117c449896c707fc6cfe5b90978160697d0

cheers
