Return-Path: <SRS0=USLf=AU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B879AC433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 17:44:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E6A82078B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2020 17:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="dycVlnFo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E6A82078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B2k8B43YTzDrCP
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Jul 2020 03:44:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=efficios.com (client-ip=167.114.26.124; helo=mail.efficios.com;
 envelope-from=compudj@efficios.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256
 header.s=default header.b=dycVlnFo; dkim-atps=neutral
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B2k6F19r7zDr1D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2020 03:43:00 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id AA6F7291512;
 Thu,  9 Jul 2020 13:42:56 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id iVMBj9_Roujf; Thu,  9 Jul 2020 13:42:56 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 6DE0C291510;
 Thu,  9 Jul 2020 13:42:56 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 6DE0C291510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=default; t=1594316576;
 bh=WeprbFQKdP9C2xcCza+ACMMYDoEisr3bOWzyNtx7AgI=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=dycVlnFoGL7cp0w6UdyVqoVjoZhsaWMdV2CE7XEeVmzr4tWPQzMAT56oUYwre1za0
 fpDBwwJsgOlQRhbeNNsyPEmNGqnBo4IOy2PVYmOuFYOrwK19hHbajhxI9g/NMwb1ge
 9qZKqAIXwnqp6rWDfXDuIRwSJ8XHYI/a+dkw4sjAKcBFMbGTs2vXQANKHlb9g4tHD0
 kx0ZNpoQW0uBdCk6aleSwhZvVzVrmoM4oN3WfokStirZu6cI44Jraf0m4WJCAN2jXf
 +ogIEY3KVvNlIUmq/DmsHw1xmrHNwB8bQqLavuzJ7WCuZbHzq87hAfOm96lnfRwwFK
 jwQ21tdCSdrIw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id nGS2xT8mBmIZ; Thu,  9 Jul 2020 13:42:56 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 61C5229105B;
 Thu,  9 Jul 2020 13:42:56 -0400 (EDT)
Date: Thu, 9 Jul 2020 13:42:56 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Message-ID: <1584179170.7410.1594316576293.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200709173712.GL3598@gate.crashing.org>
References: <972420887.755.1594149430308.JavaMail.zimbra@efficios.com>
 <20200708005922.GW3598@gate.crashing.org> <87k0ze2nv4.fsf@mpe.ellerman.id.au>
 <20200708235331.GA3598@gate.crashing.org>
 <1968953502.5815.1594252883512.JavaMail.zimbra@efficios.com>
 <20200709001837.GD3598@gate.crashing.org>
 <1769596686.6365.1594302227962.JavaMail.zimbra@efficios.com>
 <20200709173712.GL3598@gate.crashing.org>
Subject: Re: Failure to build librseq on ppc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Topic: Failure to build librseq on ppc
Thread-Index: q69V8GVx/SoKpVhL7JIT4yP2NgYiwA==
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
Cc: Boqun Feng <boqun.feng@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Jeanson <mjeanson@efficios.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

----- On Jul 9, 2020, at 1:37 PM, Segher Boessenkool segher@kernel.crashing.org wrote:

> On Thu, Jul 09, 2020 at 09:43:47AM -0400, Mathieu Desnoyers wrote:
>> > What protects r17 *after* this asm statement?
>> 
>> As discussed in the other leg of the thread (with the code example),
>> r17 is in the clobber list of all asm statements using this macro, and
>> is used as a temporary register within each inline asm.
> 
> That works fine then, for a testcase.  Using r17 is not a great idea for
> performance (it increases the active register footprint, and causes more
> registers to be saved in the prologue of the functions, esp. on older
> compilers), and it is easier to just let the compiler choose a good
> register to use.  But maybe you want to see r17 in the generated
> testcases, as eyecatcher or something, dunno :-)

Just to make sure I understand your recommendation. So rather than
hard coding r17 as the temporary registers, we could explicitly
declare the temporary register as a C variable, pass it as an
input operand to the inline asm, and then refer to it by operand
name in the macros using it. This way the compiler would be free
to perform its own register allocation.

If that is what you have in mind, then yes, I think it makes a
lot of sense.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
