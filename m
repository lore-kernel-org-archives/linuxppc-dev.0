Return-Path: <SRS0=mX83=NI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1603AC4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 18:12:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5778660F5E
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Aug 2021 18:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5778660F5E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GpzdK5yXsz30J5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 04:12:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=perches.com
 (client-ip=216.40.44.205; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
X-Greylist: delayed 369 seconds by postgrey-1.36 at boromir;
 Wed, 18 Aug 2021 04:11:41 AEST
Received: from smtprelay.hostedemail.com (smtprelay0205.hostedemail.com
 [216.40.44.205])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gpzcs30Ryz30DY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 04:11:39 +1000 (AEST)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 1F6B2807221F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Aug 2021 18:05:33 +0000 (UTC)
Received: from omf04.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 79D5E100A44A9;
 Tue, 17 Aug 2021 18:05:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf04.hostedemail.com (Postfix) with ESMTPA id 67452D1517; 
 Tue, 17 Aug 2021 18:05:26 +0000 (UTC)
Message-ID: <79ad056a8d6b71df0a793f18c5752c2eaf8c836c.camel@perches.com>
Subject: Re: [PATCH] macintosh: no need to initilise statics to 0
From: Joe Perches <joe@perches.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Jason Wang
 <wangborong@cdjrlc.com>, benh@kernel.crashing.org
Date: Tue, 17 Aug 2021 11:05:24 -0700
In-Reply-To: <2105ef52-b736-cc18-def9-02ac174d1922@csgroup.eu>
References: <20210817115104.30057-1-wangborong@cdjrlc.com>
 <2105ef52-b736-cc18-def9-02ac174d1922@csgroup.eu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: r6f78e9dki483a97e8tpk5gf81t9mny4
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 67452D1517
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18NRR3d9r9nOd9Sa3Pmevs4UvdI+JZtr+I=
X-HE-Tag: 1629223526-123757
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
Cc: yukuai3@huawei.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2021-08-17 at 13:59 +0200, Christophe Leroy wrote:
> 
> Le 17/08/2021 à 13:51, Jason Wang a écrit :
> > Global static variables dont need to be initialised to 0. Because
> > the compiler will initilise them.
> 
> It is not the compiler, it is the Kernel. It is done here:
> 
> https://elixir.bootlin.com/linux/v5.14-rc6/source/arch/powerpc/kernel/early_32.c

I don't know why that's done generally.

From memory, it's also required by the c spec unless it's for a union
where the first union member is smaller in size than other members.


