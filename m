Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79629C6FA81
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Sep 2022 19:39:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJWb30VVRz30L6
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Sep 2022 05:39:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=KvmI+7mu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=KvmI+7mu;
	dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJWZN74fbz2xGf
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2022 05:39:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7PMktsvCeflqHXpmx1pY0BaMo+yb9eJasUdA0eZTbwU=; b=KvmI+7mukKhHzNfPM57th60Ylm
	aggKXxgw2lh3nJzK4r+PSS3jQHAhAQ9DNT0+H7GT5jRIZN/J/gpExo3Dwi1sZP3KhBigQ7D/qoKA+
	ZC94DLwMLjw2KFbT2g7VknZPCRLJimzESg854oPAvyQwAPZT0lroxc0HhKnveo56gkLawS920ec6z
	i5hqjDrlyzue2Rs8Eir0IDyzD6iYxCJK/+Jow/BXuDfqxtWYnbxhHEJ9x66wMduOmf8U/jxgOFo9V
	3rHL6A/7lnHXqzsFjVANbZht+CbgV4XJ4IzQUa2LKS37ibN5sZxaydcsR10j63gvb+dvReEhpc70P
	eP+fXgGw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTq19-008TS4-U8; Thu, 01 Sep 2022 19:38:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E77BA300230;
	Thu,  1 Sep 2022 21:38:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id C968E2B8D59A4; Thu,  1 Sep 2022 21:38:21 +0200 (CEST)
Date: Thu, 1 Sep 2022 21:38:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 2/6] objtool: Add architecture specific R_REL32 macro
Message-ID: <YxEKLSpNlUTvj4yt@hirez.programming.kicks-ass.net>
References: <cover.1662032631.git.christophe.leroy@csgroup.eu>
 <1cfa46b215a2f39c7f8040ca5447113ff9eb7dd6.1662032631.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cfa46b215a2f39c7f8040ca5447113ff9eb7dd6.1662032631.git.christophe.leroy@csgroup.eu>
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
Cc: x86@kernel.org, hpa@zytor.com, chenzhongjin@huawei.com, dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, ardb@kernel.org, jbaron@akamai.com, mingo@redhat.com, sv@linux.ibm.com, rostedt@goodmis.org, bgray@linux.ibm.com, bp@alien8.de, tglx@linutronix.de, agust@denx.de, linuxppc-dev@lists.ozlabs.org, jpoimboe@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 01, 2022 at 01:48:21PM +0200, Christophe Leroy wrote:
> In order to allow other architectures than x86 to use 32 bits
> PC relative relocations (S+A-P), define a R_REL32 macro that each
> architecture will define, in the same way as already done for
> R_NONE, R_ABS32 and R_ABS64.
> 
> For x86 that corresponds to R_X86_64_PC32.
> For powerpc it is R_PPC_REL32/R_PPC64_REL32.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
