Return-Path: <SRS0=5voM=R3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D11CC43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Mar 2019 22:31:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63ED920989
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Mar 2019 22:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63ED920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SBvf6F6qzDqLd
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 09:31:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=nefkom.net
 (client-ip=212.18.0.9; helo=mail-out.m-online.net;
 envelope-from=whitebox@nefkom.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-m68k.org
X-Greylist: delayed 694 seconds by postgrey-1.36 at bilbo;
 Mon, 25 Mar 2019 09:29:55 AEDT
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SBsb6wg5zDqLW
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 09:29:55 +1100 (AEDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 44SBc45SDhz1rWHl;
 Sun, 24 Mar 2019 23:18:12 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 44SBc41jrjz1qr5h;
 Sun, 24 Mar 2019 23:18:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id Hge6yPhwn4SY; Sun, 24 Mar 2019 23:18:10 +0100 (CET)
X-Auth-Info: WnwfXyadmFtGVfs2HSLt01ktDBs54ySjZN1M4qbPaJOM+DyCwEPLJBWdYx2zOTw9
Received: from igel.home (ppp-46-244-160-178.dynamic.mnet-online.de
 [46.244.160.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Sun, 24 Mar 2019 23:18:10 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
 id 1EA9D2C158A; Sun, 24 Mar 2019 23:18:10 +0100 (CET)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM
 configurations
References: <20190317011756.abjylw3nzfnc6gnh@decadent.org.uk>
 <44QjSh4zGhz9sV2__48832.6491251186$1553257542$gmane$org@ozlabs.org>
X-Yow: If this is the DATING GAME I want to know your FAVORITE PLANET!  Do I
 get th' MICROWAVE MOPED?
Date: Sun, 24 Mar 2019 23:18:10 +0100
In-Reply-To: <44QjSh4zGhz9sV2__48832.6491251186$1553257542$gmane$org@ozlabs.org>
 (Michael Ellerman's message of "Fri, 22 Mar 2019 23:21:40 +1100
 (AEDT)")
Message-ID: <87k1gnq5lp.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: Ben Hutchings <ben@decadent.org.uk>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mär 22 2019, Michael Ellerman <patch-notifications@ellerman.id.au> wrote:

> On Sun, 2019-03-17 at 01:17:56 UTC, Ben Hutchings wrote:
>> MAX_PHYSMEM_BITS only needs to be defined if CONFIG_SPARSEMEM is
>> enabled, and that was the case before commit 4ffe713b7587
>> ("powerpc/mm: Increase the max addressable memory to 2PB").
>> 
>> On 32-bit systems, where CONFIG_SPARSEMEM is not enabled, we now
>> define it as 46.  That is larger than the real number of physical
>> address bits, and breaks calculations in zsmalloc:
>> 
>>     mm/zsmalloc.c:130:49: warning: right shift count is negative [-Wshift-count-negative]
>>       MAX(32, (ZS_MAX_PAGES_PER_ZSPAGE << PAGE_SHIFT >> OBJ_INDEX_BITS))
>>                                                      ^~
>>     ...
>>     mm/zsmalloc.c:253:21: error: variably modified 'size_class' at file scope
>>       struct size_class *size_class[ZS_SIZE_CLASSES];
>>                          ^~~~~~~~~~
>> 
>> Fixes: 4ffe713b7587 ("powerpc/mm: Increase the max addressable memory to 2PB")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
>
> Applied to powerpc fixes, thanks.
>
> https://git.kernel.org/powerpc/c/8bc086899816214fbc6047c9c7e15fca

In file included from ./arch/powerpc/include/asm/book3s/64/mmu.h:39:0,
                 from ./arch/powerpc/include/asm/mmu.h:360,
                 from ./arch/powerpc/include/asm/lppaca.h:36,
                 from ./arch/powerpc/include/asm/paca.h:21,
                 from ./arch/powerpc/include/asm/current.h:16,
                 from ./include/linux/thread_info.h:21,
                 from ./include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/mmzone.h:8,
                 from ./include/linux/gfp.h:6,
                 from ./include/linux/slab.h:15,
                 from ./include/linux/crypto.h:24,
                 from ./include/crypto/algapi.h:15,
                 from ./include/crypto/internal/hash.h:16,
                 from arch/powerpc/crypto/md5-glue.c:15:
./arch/powerpc/include/asm/book3s/64/mmu-hash.h:584:6: error: "MAX_PHYSMEM_BITS" is not defined [-Werror=undef]
 #if (MAX_PHYSMEM_BITS > MAX_EA_BITS_PER_CONTEXT)
      ^

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
