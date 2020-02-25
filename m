Return-Path: <SRS0=ugyh=4N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1499C35DEE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 00:32:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED7921927
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 00:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fVyxcSFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED7921927
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48RKcr4yc3zDqX6
	for <linuxppc-dev@archiver.kernel.org>; Tue, 25 Feb 2020 11:31:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=fVyxcSFf; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48RKZd0cNczDq6l
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2020 11:30:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=JVU4gdBDiIRvc9V2bP234i33D7WlgF36h67W5FUswC8=; b=fVyxcSFfRUcoaq6hF+R6vxlzKy
 YedSkscc6BX4kjz5eD1kKWvrnCmlFfk6nB6lyc5kZss7sZ32tBJXOGFmCMp1vQDouTTFnUAZ4Ea/L
 7gjUS6vT7+2+BugsI3ja5cMQV2GJQ/mbDldWA9WNVmK4yuuMdLi4Bs6ZkfJ9ZV68ny45i6k7Q02bh
 lgnPi4deJ6V5uwM+4qc27c0FaNCpqapbI3AY65u33Db2bAaoBKh5lGi6hhlOkwWq1S8qPq4uZ4S4o
 jx+G6dcBv54eIohv/5avVqvPSWNXXsrGpIOUSSpO2Cg0UvSAlAb/q4t0Xkz8F3HC4wADJPiwT0eH3
 q29y/3Sw==;
Received: from 96-90-213-161-static.hfc.comcastbusiness.net ([96.90.213.161]
 helo=[10.11.45.55])
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6O6o-0005VU-Dn; Tue, 25 Feb 2020 00:29:58 +0000
Subject: Re: [PATCH][next] toshiba: Replace zero-length array with
 flexible-array member
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 "David S. Miller" <davem@davemloft.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
References: <20200224163252.GA28066@embeddedor>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <1989d527-06ad-832b-19c0-d8cabc6509e9@infradead.org>
Date: Mon, 24 Feb 2020 16:29:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224163252.GA28066@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 2/24/20 8:32 AM, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:

Seems fine.

Acked-by: Geoff Levand <geoff@infradead.org>
