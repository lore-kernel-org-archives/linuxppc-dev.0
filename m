Return-Path: <SRS0=8kzy=XS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210F4C00304
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Sep 2019 21:05:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39AD721655
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Sep 2019 20:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JjodXofw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39AD721655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46cc8W5mxxzDqKK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Sep 2019 06:57:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nvidia.com
 (client-ip=216.228.121.64; helo=hqemgate15.nvidia.com;
 envelope-from=jhubbard@nvidia.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=nvidia.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=nvidia.com header.i=@nvidia.com header.b="JjodXofw"; 
 dkim-atps=neutral
Received: from hqemgate15.nvidia.com (hqemgate15.nvidia.com [216.228.121.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46cc153c5hzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2019 06:51:05 +1000 (AEST)
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5d89303b0000>; Mon, 23 Sep 2019 13:51:07 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate101.nvidia.com (PGP Universal service);
 Mon, 23 Sep 2019 13:51:01 -0700
X-PGP-Universal: processed;
 by hqpgpgate101.nvidia.com on Mon, 23 Sep 2019 13:51:01 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Sep
 2019 20:51:00 +0000
Received: from [10.110.48.28] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Sep
 2019 20:51:00 +0000
Subject: Re: [PATCH v2 00/11] Introduces new count-based method for monitoring
 lockless pagetable wakls
To: Leonardo Bras <leonardo@linux.ibm.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20190920195047.7703-1-leonardo@linux.ibm.com>
 <1f5d9380418ad8bb90c6bbdac34716c650b917a0.camel@linux.ibm.com>
From: John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <b2d47f4b-2bf2-20a8-2438-4fd3f9b08a63@nvidia.com>
Date: Mon, 23 Sep 2019 13:51:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1f5d9380418ad8bb90c6bbdac34716c650b917a0.camel@linux.ibm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1569271867; bh=NGWrVElZnjap7E3UfmytYq7pLzJamjPrbFLlzjkTg/A=;
 h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
 Content-Transfer-Encoding;
 b=JjodXofwYPiH57fRGXXlzFAhrJDQfAztVo2L2bRjpZkkknwgBX5qVDAf2XFL08nSG
 6YHzLI0EfBf6Nfnb78AqVJuIErjtH9SAHtnxoqMGI0xC7ckW98qDE7bHo920PGnl99
 y3gEzAlWdh0hsK3MrFxXjDeaRG/bkwpfKb+zJm+qhWcm9SQwfn18sFSYbSZ2HYQwQV
 dTaAmSkxTUpo3gH6GMqSe5AZQTLdH+2F/yNYH6T8VA7KAcLYNJ+qyQ8ROby5QGdrK4
 Ci8AnNf1zgstbWWZZ2vIpcWv0+AkUvPlzyPFfdmL0/N2QLcdvxhJC3R7GLRArIaHcl
 M1L+ES3oqnUIw==
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
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Thomas Gleixner <tglx@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, YueHaibing <yuehaibing@huawei.com>,
 Keith Busch <keith.busch@intel.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mike Rapoport <rppt@linux.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Richard Fontana <rfontana@redhat.com>, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Allison Randal <allison@lohutok.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 9/20/19 1:12 PM, Leonardo Bras wrote:
...
>>  arch/powerpc/include/asm/book3s/64/mmu.h     |  3 +++
>>  arch/powerpc/include/asm/book3s/64/pgtable.h |  5 +++++
>>  arch/powerpc/kernel/mce_power.c              | 13 ++++++++++---
>>  arch/powerpc/kvm/book3s_64_mmu_hv.c          |  2 ++
>>  arch/powerpc/kvm/book3s_64_mmu_radix.c       | 20 ++++++++++++++++++--
>>  arch/powerpc/kvm/book3s_64_vio_hv.c          |  4 ++++
>>  arch/powerpc/kvm/book3s_hv_nested.c          |  8 ++++++++
>>  arch/powerpc/kvm/book3s_hv_rm_mmu.c          |  9 ++++++++-
>>  arch/powerpc/kvm/e500_mmu_host.c             |  4 ++++
>>  arch/powerpc/mm/book3s64/hash_tlb.c          |  2 ++
>>  arch/powerpc/mm/book3s64/hash_utils.c        |  7 +++++++
>>  arch/powerpc/mm/book3s64/mmu_context.c       |  1 +
>>  arch/powerpc/mm/book3s64/pgtable.c           | 20 +++++++++++++++++++-
>>  arch/powerpc/perf/callchain.c                |  5 ++++-
>>  include/asm-generic/pgtable.h                |  9 +++++++++
>>  mm/gup.c                                     |  4 ++++
>>  16 files changed, 108 insertions(+), 8 deletions(-)
>>

Also, which tree do these patches apply to, please? 

thanks,
-- 
John Hubbard
NVIDIA
