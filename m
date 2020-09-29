Return-Path: <SRS0=xLud=DG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5AAC4727C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2020 15:12:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51B8F20773
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2020 15:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51B8F20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4C12tN5MY3zDqYq
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Sep 2020 01:12:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=iogearbox.net (client-ip=213.133.104.62;
 helo=www62.your-server.de; envelope-from=daniel@iogearbox.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=iogearbox.net
X-Greylist: delayed 1423 seconds by postgrey-1.36 at bilbo;
 Wed, 30 Sep 2020 01:05:57 AEST
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C12lB1TH1zDqBy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2020 01:05:56 +1000 (AEST)
Received: from sslproxy01.your-server.de ([78.46.139.224])
 by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.89_1) (envelope-from <daniel@iogearbox.net>)
 id 1kNGpB-0001qy-WE; Tue, 29 Sep 2020 16:41:50 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
 by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1kNGpB-000Res-QS; Tue, 29 Sep 2020 16:41:49 +0200
Subject: Re: [PATCH] powerpc: net: bpf_jit_comp: Fix misuse of fallthrough
To: zhe.he@windriver.com, gustavo@embeddedor.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20200928090023.38117-1-zhe.he@windriver.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d73d30b7-6405-3b42-693f-5e16c7a4c6a3@iogearbox.net>
Date: Tue, 29 Sep 2020 16:41:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200928090023.38117-1-zhe.he@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25942/Tue Sep 29 15:56:33 2020)
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 9/28/20 11:00 AM, zhe.he@windriver.com wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> The user defined label following "fallthrough" is not considered by GCC
> and causes build failure.
> 
> kernel-source/include/linux/compiler_attributes.h:208:41: error: attribute
> 'fallthrough' not preceding a case label or default label [-Werror]
>   208   define fallthrough _attribute((fallthrough_))
>                            ^~~~~~~~~~~~~
> 
> Signed-off-by: He Zhe <zhe.he@windriver.com>

Applied, thanks! I've also added Fixes tag with df561f6688fe ("treewide: Use fallthrough pseudo-keyword")
which added the bug.
