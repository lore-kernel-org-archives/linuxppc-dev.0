Return-Path: <SRS0=any3=BQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C93C433F4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68B5822D02
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68B5822D02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BMkSM15D1zDqF1
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 19:57:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BMkPK3CD0zDq9R
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2020 19:54:58 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4BMkP82qsWz9v0SZ;
 Thu,  6 Aug 2020 11:54:52 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id EGAhQQuTYzTh; Thu,  6 Aug 2020 11:54:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4BMkP82110z9v0SX;
 Thu,  6 Aug 2020 11:54:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9CEDD8B7FE;
 Thu,  6 Aug 2020 11:54:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dGZqyIVZZVmv; Thu,  6 Aug 2020 11:54:53 +0200 (CEST)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 85FAB8B7F9;
 Thu,  6 Aug 2020 11:54:51 +0200 (CEST)
Subject: Re: [PATCH v3 3/3] powerpc/uaccess: simplify the get_fs() set_fs()
 logic
To: Christoph Hellwig <hch@infradead.org>
References: <a6e62627d25fb7ae9b91d8bf553e707689e37498.1596702117.git.christophe.leroy@csgroup.eu>
 <cf39cb8e42cffe323393b8cecdc59a7230298eab.1596702117.git.christophe.leroy@csgroup.eu>
 <20200806091758.GA653@infradead.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <d9111162-220a-c1a8-4251-5815030cb32e@csgroup.eu>
Date: Thu, 6 Aug 2020 11:54:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806091758.GA653@infradead.org>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 06/08/2020 à 11:17, Christoph Hellwig a écrit :
> Do you urgently need this?  My plan for 5.10 is to rebased and submit
> the remaining bits of this branch:
> 
>      http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/set_fs-removal
> 
> which will kill off set_fs/get_fs entirely.
> 

No this isn't needed urgently at all I think.

It was sleeping in Patchwork since January, and I received comments from 
Michael a few days ago asking me to re-submit, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/dd2876b808ea38eb7b7f760ecd6ce06096c61fb5.1580295551.git.christophe.leroy@c-s.fr/

But if you are killing set_fs/get_fs entirely, that's even better I 
guess. Thanks for the hands up.

Christophe
