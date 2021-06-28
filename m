Return-Path: <SRS0=PW3U=LW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE4FC2B9F4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 05:56:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54D4B61C34
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 05:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54D4B61C34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GCxh44v04z30Ds
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jun 2021 15:56:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GCxgf5JQRz2yht
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jun 2021 15:56:26 +1000 (AEST)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
 by localhost (Postfix) with ESMTP id 4GCxgV1Yc3zBBlp;
 Mon, 28 Jun 2021 07:56:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDK_m3pCk78b; Mon, 28 Jun 2021 07:56:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4GCxgV0d9PzBBgx;
 Mon, 28 Jun 2021 07:56:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id ECF008B776;
 Mon, 28 Jun 2021 07:56:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id QcdPGwq5KisL; Mon, 28 Jun 2021 07:56:21 +0200 (CEST)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B1C728B763;
 Mon, 28 Jun 2021 07:56:21 +0200 (CEST)
Subject: Re: [PATCH v3] mm: pagewalk: Fix walk for hugepage tables
To: Andrew Morton <akpm@linux-foundation.org>
References: <38d04410700c8d02f28ba37e020b62c55d6f3d2c.1624597695.git.christophe.leroy@csgroup.eu>
 <20210627181226.983d899cc30c02420e1a6af5@linux-foundation.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <ecf71f68-d25e-c0c6-4c2a-b181b836ac43@csgroup.eu>
Date: Mon, 28 Jun 2021 07:56:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210627181226.983d899cc30c02420e1a6af5@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Steven Price <steven.price@arm.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>, Oliver O'Halloran <oohall@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 28/06/2021 à 03:12, Andrew Morton a écrit :
> On Fri, 25 Jun 2021 05:10:12 +0000 (UTC) Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
> 
>> Pagewalk ignores hugepd entries and walk down the tables
>> as if it was traditionnal entries, leading to crazy result.
>>
>> Add walk_hugepd_range() and use it to walk hugepage tables.
> 
> More details, please?  I assume "crazy result" is userspace visible?
> For how long has this bug existed?  Is a -stable backport needed?  Has
> a Fixes: commit been identified?  etcetera!
> 

I discovered the problem while porting powerpc to generic page table dump.
The generic page table dump uses walk_page_range_novma() .

Yes, "crazy result" is that when dumping /sys/kernel/debug/kernel_page_tables, you get random 
entries because at the time being the pagewalk code sees huge page directories as standard page tables.

The bug has always existed as far as I can see, but as no other architectures than powerpc use huge 
page directories, it only pops up now when powerpc is trying to use that generic page walking code.

So I don't think it is worth a backport to -stable, and about a Fixes: tag I don't know.

IIUC, hugepd was introduced for the first time in mm by commit cbd34da7dc9a ("mm: move the powerpc 
hugepd code to mm/gup.c")

Before that, hugepd was internal to powerpc.

I guess you are asking about Fixes: tag and backporting because of the patch subject.
Should I reword the page subject to something like "mm: enable the generic page walk code to walk 
huge page directories" ?
