Return-Path: <SRS0=AwiL=AS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6498C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 19:19:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F341206E9
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jul 2020 19:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="KV/GJ2CP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F341206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4B1XKy39VXzDr45
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2020 05:19:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=efficios.com (client-ip=167.114.26.124; helo=mail.efficios.com;
 envelope-from=compudj@efficios.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256
 header.s=default header.b=KV/GJ2CP; dkim-atps=neutral
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B1XHv58cJzDqq7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jul 2020 05:17:14 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 955A561D6;
 Tue,  7 Jul 2020 15:17:10 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id cdk_0QS2rz0c; Tue,  7 Jul 2020 15:17:10 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.efficios.com (Postfix) with ESMTP id 56DF1614B;
 Tue,  7 Jul 2020 15:17:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 56DF1614B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=default; t=1594149430;
 bh=WfZ0lE32n2ObUxwjbhI3Kbe4Y2S4SdTEdmI4itQ4ca8=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=KV/GJ2CPnIWH5+xpk+aqCsCqc2rYbyESnQkY6xTVwmsuy47R8BOiP4WO1qMS0/Ipy
 POvcYEQve+c9pfV4X0zfHakOgOtTVOE5OgLFTpw6vPYguHny1C8GR0nglHZxi1Hogd
 mGr/ecESw34144j3XHflAeRnCrzJmgmZFpvf4UD9JgSl/eRIp3oYT+qRmNVQnLfUp8
 e1m0Cr8CuYLpxaqig/bZZkzoC7w5ssXNQAN/RHv/GiQ0ICF7HS37du/SZo0Vn0YLFZ
 rGif7qt0QI0LBqgYS7rHrY4bvtIzUAi979/IxnBTYxgRf8Kb/Cy/txMmYql1PkwMss
 Z+RJTbpVYpoJw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
 by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id mc9RDTvYruCF; Tue,  7 Jul 2020 15:17:10 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
 by mail.efficios.com (Postfix) with ESMTP id 4E5C96065;
 Tue,  7 Jul 2020 15:17:10 -0400 (EDT)
Date: Tue, 7 Jul 2020 15:17:10 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Boqun Feng <boqun.feng@gmail.com>
Message-ID: <972420887.755.1594149430308.JavaMail.zimbra@efficios.com>
Subject: Failure to build librseq on ppc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3955 (ZimbraWebClient - FF78 (Linux)/8.8.15_GA_3953)
Thread-Index: apEQ3SUvB0iNZa1h7/Py+UNEChBzxQ==
Thread-Topic: Failure to build librseq on ppc
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
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Michael Jeanson <mjeanson@efficios.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Boqun,

I'm trying to build librseq at:

https://git.kernel.org/pub/scm/libs/librseq/librseq.git

on powerpc, and I get these errors when building the rseq basic
test mirrored from the kernel selftests code:

/tmp/ccieEWxU.s: Assembler messages:
/tmp/ccieEWxU.s:118: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:118: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:121: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:121: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:626: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:626: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:629: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:629: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:735: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:735: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:738: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:738: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:741: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:741: Error: junk at end of line: `,8'
Makefile:581: recipe for target 'basic_percpu_ops_test.o' failed

I am using this compiler:

gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12)
Target: powerpc-linux-gnu

So far, I got things to build by changing "m" operands to "Q" operands.
Based on https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints
it seems that "Q" means "A memory operand addressed by just a base register."
I suspect that lwz and stw don't expect some kind of immediate offset which
can be kept with "m", and "Q" fixes this. Is that the right fix ?

And should we change all operands passed to lwz and stw to a "Q" operand ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
