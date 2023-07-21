Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB31C04A6A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jul 2023 18:24:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R6yd6426Nz3cZ9
	for <linuxppc-dev@archiver.kernel.org>; Sat, 22 Jul 2023 04:24:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=cmarinas@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R6ycZ2Yp0z3c2y
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jul 2023 04:23:58 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 64AFE61D70;
	Fri, 21 Jul 2023 18:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41432C433C9;
	Fri, 21 Jul 2023 18:23:50 +0000 (UTC)
Date: Fri, 21 Jul 2023 11:23:49 -0700
From: Catalin Marinas <catalin.marinas@arm.com>
To: Yicong Yang <yangyicong@huawei.com>
Subject: Re: [PATCH v11 1/4] mm/tlbbatch: Introduce
 arch_tlbbatch_should_defer()
Message-ID: <ZLrNNcApzNLp9pdj@arm.com>
References: <20230717131004.12662-1-yangyicong@huawei.com>
 <20230717131004.12662-2-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717131004.12662-2-yangyicong@huawei.com>
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
Cc: mark.rutland@arm.com, wangkefeng.wang@huawei.com, prime.zeng@hisilicon.com, realmz6@gmail.com, linux-doc@vger.kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, punit.agrawal@bytedance.com, linux-riscv@lists.infradead.org, will@kernel.org, Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, zhangshiming@oppo.com, lipeifeng@oppo.com, corbet@lwn.net, x86@kernel.org, Barry Song <21cnbao@gmail.com>, ryan.roberts@arm.com, arnd@arndb.de, anshuman.khandual@arm.com, openrisc@lists.librecores.org, darren@os.amperecomputing.com, Jonathan.Cameron@huawei.com, yangyicong@hisilicon.com, linux-arm-kernel@lists.infradead.org, Barry Song <baohua@kernel.org>, guojian@oppo.com, xhao@linux.alibaba.com, linux-mips@vger.kernel.org, huzhanyuan@oppo.com, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Jul 17, 2023 at 09:10:01PM +0800, Yicong Yang wrote:
> From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> 
> The entire scheme of deferred TLB flush in reclaim path rests on the
> fact that the cost to refill TLB entries is less than flushing out
> individual entries by sending IPI to remote CPUs. But architecture
> can have different ways to evaluate that. Hence apart from checking
> TTU_BATCH_FLUSH in the TTU flags, rest of the decision should be
> architecture specific.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> [https://lore.kernel.org/linuxppc-dev/20171101101735.2318-2-khandual@linux.vnet.ibm.com/]
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> [Rebase and fix incorrect return value type]
> Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Reviewed-by: Barry Song <baohua@kernel.org>
> Reviewed-by: Xin Hao <xhao@linux.alibaba.com>
> Tested-by: Punit Agrawal <punit.agrawal@bytedance.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
