Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814D3ECAAD1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Sep 2022 19:26:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MJWHk05ghz2yYL
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Sep 2022 05:26:26 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=TfFSurf2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=TfFSurf2;
	dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MJWH40Kjdz2x9G
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Sep 2022 05:25:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bOMIr6g0AdsIjeMY/p/MhqGzXLprGWVwMTwh9NVS/a8=; b=TfFSurf2JxBz34xirgQRXpYcaI
	f6AWqYBFavVSO43blQn6NSrHVRe0qWCAI1vVAiv3sOK/woi0N/gxsPJFEPFQ1Zwzp5tzX6Ld1ONHW
	Djt3YDYZzFDPlMRNK+oS1z0ra2bhPmFGxrQYRAt9icAZQk56sjO75Zr3WMyNl1F3qE4vfx5n0Xf/M
	hBzaUVJS2JCmXXcbiPgP8oNkriP9Q4E686vRiNtMg786UFZAtxF/m8PYeh5t+OEgii0q3Ln4SL+BN
	vUUISkTuqm6b+cTOCUuOs14/3Y4vSCG6+HzSHiozpOSOkes1Mficfj7hHPZLne6nJ7ecJ1u1mKxWv
	5atPp+8g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTpor-006Iaw-6k; Thu, 01 Sep 2022 19:25:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(Client did not present a certificate)
	by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9931F300230;
	Thu,  1 Sep 2022 21:25:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
	id 819872B8D5A28; Thu,  1 Sep 2022 21:25:39 +0200 (CEST)
Date: Thu, 1 Sep 2022 21:25:39 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sathvika Vasireddy <sv@linux.ibm.com>
Subject: Re: [PATCH v2 11/16] objtool: Add --mnop as an option to --mcount
Message-ID: <YxEHM8ZL1XAFsj4H@hirez.programming.kicks-ass.net>
References: <20220829055223.24767-1-sv@linux.ibm.com>
 <20220829055223.24767-12-sv@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829055223.24767-12-sv@linux.ibm.com>
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
Cc: aik@ozlabs.ru, chenzhongjin@huawei.com, npiggin@gmail.com, linux-kernel@vger.kernel.org, mingo@redhat.com, rostedt@goodmis.org, jpoimboe@redhat.com, naveen.n.rao@linux.vnet.ibm.com, mbenes@suse.cz, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Aug 29, 2022 at 11:22:18AM +0530, Sathvika Vasireddy wrote:
> Architectures can select HAVE_NOP_MCOUNT if they choose
> to nop out mcount call sites. If that config option is
> selected, then --mnop is passed as an option to objtool,
> along with --mcount.
> 
> Also, make sure that --mnop can be passed as an option
> to objtool only when --mcount is passed.
> 
> Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>

IIRC you want to nop the things yourself because PLT entries or
something?

Anyway, patch looks fine, even though the Changelog doesn't relaly
justify the change.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
