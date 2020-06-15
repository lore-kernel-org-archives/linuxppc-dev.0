Return-Path: <SRS0=bXCp=74=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8CCC433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 07:40:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A63AE2067B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 07:40:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63AE2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49ljsX71sWzDqSJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Jun 2020 17:40:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49lh216FFszDqPS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2020 16:17:12 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 49lh1m3ggJzB09ZG;
 Mon, 15 Jun 2020 08:17:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id us_QWEWQjgUN; Mon, 15 Jun 2020 08:17:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 49lh1m2qF8zB09ZD;
 Mon, 15 Jun 2020 08:17:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 767258B782;
 Mon, 15 Jun 2020 08:17:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Js7BPOCxpUQT; Mon, 15 Jun 2020 08:17:06 +0200 (CEST)
Received: from [172.25.230.104] (unknown [172.25.230.104])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3BB0B8B77C;
 Mon, 15 Jun 2020 08:17:06 +0200 (CEST)
Subject: Re: [PATCH] SUNRPC: Add missing asm/cacheflush.h
To: Chuck Lever <chuck.lever@oracle.com>
References: <a356625c9aa1b5d711e320c39779e0c713f204cb.1592154127.git.christophe.leroy@csgroup.eu>
 <854D2842-6940-42BA-A48C-AE9DB48E6071@oracle.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <35ca33b7-4b9d-d70f-efcc-c1eb72483b2b@csgroup.eu>
Date: Mon, 15 Jun 2020 08:16:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <854D2842-6940-42BA-A48C-AE9DB48E6071@oracle.com>
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
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>, netdev@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Bruce Fields <bfields@fieldses.org>,
 Anna Schumaker <anna.schumaker@netapp.com>, Jakub Kicinski <kuba@kernel.org>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 14/06/2020 à 20:57, Chuck Lever a écrit :
> Hi Christophe -
> 
>> On Jun 14, 2020, at 1:07 PM, Christophe Leroy <christophe.leroy@csgroup.eu> wrote:
>>
>> Even if that's only a warning, not including asm/cacheflush.h
>> leads to svc_flush_bvec() being empty allthough powerpc defines
>> ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE.
>>
>>   CC      net/sunrpc/svcsock.o
>> net/sunrpc/svcsock.c:227:5: warning: "ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE" is not defined [-Wundef]
>> #if ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE
>>      ^
>>
>> Fixes: ca07eda33e01 ("SUNRPC: Refactor svc_recvfrom()")
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>> I detected this on linux-next on June 4th and warned Chuck. Seems like it went into mainline anyway.
> 
> Thanks for your patch. I've searched my mailbox. It appears I never
> received your June 4th e-mail.

It is there: 
https://lore.kernel.org/linuxppc-dev/868915eb-8fed-0600-ea5d-31ae874457b1@csgroup.eu/

> 
> Does your patch also address:
> 
>     https://marc.info/?l=linux-kernel&m=159194369128024&w=2 ?

I guess it does, yes.

> 
> If so, then
> 
>     Reported-by: kernel test robot <lkp@intel.com>
> 
> should be added to the patch description.
> 
> Ideally, compilation on x86_64 should have thrown the same warning,
> but it didn't. Why would the x86_64 build behave differently than
> ppc64 or i386?

I think it depends whether you have selected CONFIG_BLOCK or not.
In my embedded config, CONFIG_BLOCK isn't selected.

When CONFIG_BLOCK is selected, there is the following inclusion chain:

   CC      net/sunrpc/svcsock.o
In file included from ./include/linux/highmem.h:12:0,
                  from ./include/linux/pagemap.h:11,
                  from ./include/linux/blkdev.h:16,
                  from ./include/linux/blk-cgroup.h:23,
                  from ./include/linux/writeback.h:14,
                  from ./include/linux/memcontrol.h:22,
                  from ./include/net/sock.h:53,
                  from ./include/net/inet_sock.h:22,
                  from ./include/linux/udp.h:16,
                  from net/sunrpc/svcsock.c:31:
./arch/powerpc/include/asm/cacheflush.h:26:2: warning: #warning Coucous 
[-Wcpp]
  #warning test

But linux/blkdev.h includes linux/pagemap.h only when CONFIG_BLOCK is 
defined.

> 
> 
>> net/sunrpc/svcsock.c | 1 +
>> 1 file changed, 1 insertion(+)
>>
>> diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
>> index 5c4ec9386f81..d9e99cb09aab 100644
>> --- a/net/sunrpc/svcsock.c
>> +++ b/net/sunrpc/svcsock.c
>> @@ -45,6 +45,7 @@
>> #include <net/tcp_states.h>
>> #include <linux/uaccess.h>
>> #include <asm/ioctls.h>
>> +#include <asm/cacheflush.h>
> 
> Nit: Let's include <linux/highmem.h> in net/sunrpc/svcsock.h instead
> of <asm/cacheflush.h> directly.

Ok, I'll post v2.

> 
> 
>> #include <linux/sunrpc/types.h>
>> #include <linux/sunrpc/clnt.h>
>> -- 
>> 2.25.0
>>
> 
> --
> Chuck Lever
> 
> 
> 

Christophe
