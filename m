Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B27C46475
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 14:28:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B4A20819
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 14:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rykwNpJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B4A20819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pZlp6xspzDsGJ
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 01:28:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="rykwNpJ5";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="rykwNpJ5"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pZhw5rTkzDrMf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 01:25:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bDIKyuSp9LLH9BqGVqhJP/hbXdOmufd3UQW+85NbV+8=; b=rykwNpJ5nCzznn4Jucrx26gsq
 +JH4MPOXMJ+pyWb4JU6Gj3AHUuigkLWXl9uB/Dn7tVxRF87Ptd16aKHV8RQW0nrfm1DqdeIboPOpJ
 w2ytLOtAu3dVg33KI46V7z703S+T8XnZkGmRqV7gYgNLAL7GqHnE5WapNvgfRsWGdMSJ3gMnO0cyk
 gZVOd/rhM4BbpGP6BT2UJhVvVWmX/HGnTnK8eZWbA8bXiFbqStjSfBDyJ0iWJjwae4/JjrmnjZYSd
 F2LwaakSwVKD/wKt8d3+feCrExhqyR6midZcsGLi3jSKyovhcXMJjIGoqUavssAC/YMHmpKsUr2NC
 QLv2vSwLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gJfoG-0006kE-Li; Mon, 05 Nov 2018 14:24:57 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 3223A2029F9FF; Mon,  5 Nov 2018 15:24:53 +0100 (CET)
Date: Mon, 5 Nov 2018 15:24:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Subject: Re: [RFC PATCH] lib: Introduce generic __cmpxchg_u64() and use it
 where needed
Message-ID: <20181105142453.GA22449@hirez.programming.kicks-ass.net>
References: <1541015538-11382-1-git-send-email-linux@roeck-us.net>
 <20181031213240.zhh7dfcm47ucuyfl@pburton-laptop>
 <20181031220253.GA15505@roeck-us.net>
 <20181031233235.qbedw3pinxcuk7me@pburton-laptop>
 <4e2438a23d2edf03368950a72ec058d1d299c32e.camel@hammerspace.com>
 <20181101131846.biyilr2msonljmij@lakrids.cambridge.arm.com>
 <20181101145926.GE3178@hirez.programming.kicks-ass.net>
 <f38e272f7a96e983549e4281aa9fd02833a4277a.camel@hammerspace.com>
 <20181101163212.GF3159@hirez.programming.kicks-ass.net>
 <5a846924-e642-d9d1-4e0e-810bd4d01c26@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a846924-e642-d9d1-4e0e-810bd4d01c26@virtuozzo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "bfields@fieldses.org" <bfields@fieldses.org>,
 "paulus@samba.org" <paulus@samba.org>, willy@infradead.org,
 Trond Myklebust <trondmy@hammerspace.com>,
 "jhogan@kernel.org" <jhogan@kernel.org>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 "linux@roeck-us.net" <linux@roeck-us.net>, "arnd@arndb.de" <arnd@arndb.de>,
 "boqun.feng@gmail.com" <boqun.feng@gmail.com>, dvyukov@google.com,
 "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jlayton@kernel.org" <jlayton@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "ralf@linux-mips.org" <ralf@linux-mips.org>,
 "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
 "paul.burton@mips.com" <paul.burton@mips.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "davem@davemloft.net" <davem@davemloft.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 02, 2018 at 07:19:15PM +0300, Andrey Ryabinin wrote:
> UBSAN warns about signed overflows despite -fno-strict-overflow if gcc version is < 8.
> I have learned recently that UBSAN in GCC 8 ignores signed overflows if -fno-strict-overflow of fwrapv is used.
> 
> $ cat signed_overflow.c 
> #include <stdio.h>
> 
> __attribute__((noinline))
> int foo(int a, int b)
> {
>         return a+b;

 s/+/<</

> }
> 
> int main(void)
> {
>         int a = 0x7fffffff;
>         int b = 2;
>         printf("%d\n", foo(a,b));
>         return 0;
> }

It also seem to affect 'shift':

peterz@hirez:~/tmp$ gcc -fsanitize=signed-integer-overflow,shift overflow.c ; ./a.out
overflow.c:6:11: runtime error: left shift of 2147483647 by 2 places cannot be represented in type 'int'
-4
peterz@hirez:~/tmp$ gcc -fsanitize=signed-integer-overflow,shift -fwrapv overflow.c ; ./a.out
-4
