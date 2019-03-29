Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384AEC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 01:33:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73F1821773
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 01:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73F1821773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44VklZ6wqTzDqRt
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 12:33:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Vkjq0VyZzDqLv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Mar 2019 12:31:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 44Vkjp5PYdz9sSc; Fri, 29 Mar 2019 12:31:58 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44Vkjp3VmZz9sR3;
 Fri, 29 Mar 2019 12:31:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC PATCH 3/3] powenv/mce: print additional information about
 mce error.
In-Reply-To: <155324740037.7819.10748646728863055152.stgit@jupiter.in.ibm.com>
References: <155324738319.7819.17982472592795327790.stgit@jupiter.in.ibm.com>
 <155324740037.7819.10748646728863055152.stgit@jupiter.in.ibm.com>
Date: Fri, 29 Mar 2019 12:31:57 +1100
Message-ID: <875zs2o48i.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> writes:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>
> Print more information about mce error whether it is an hardware or
> software error.
>
> Some of the mce errors can be easily categorized as hardware or software
> errors e.g. UEs are due to hardware error, where as error triggered due to
> invalid usage of tlbie is a pure software bug. But not all the mce errors
> can be easily categorize into either software or hardware. There are errors
> like multihit errors which are usually result of a software bug, but in
> some rare cases a hardware failure can cause a multihit error. In past, we
> have seen case where after replacing faulty chip, multihit errors stopped
> occurring. Same with parity errors, which are usually due to faulty hardware
> but there are chances where multihit can also cause an parity error. Such
> errors are difficult to determine what really caused it. Hence this patch
> classifies mce errors into following four categorize:
> 	1. Hardware error:
> 		UE and Link timeout failure errors.
> 	2. Hardware error, small probability of software cause:
> 		SLB/ERAT/TLB Parity errors.
> 	3. Software error
> 		Invalid tlbie form.
> 	4. Software error, small probability of hardware failure
> 		SLB/ERAT/TLB Multihit errors.

I like the idea, but I think the phrasing is a little confusing.

> Sample o/p:
>
> [ 1259.331319] MCE: CPU40: (Warning) Guest SLB Multihit at 00007fff9a59dc60 DAR: 000001003d740320 [Recovered]
> [ 1259.331324] MCE: CPU40: PID: 24051 Comm: qemu-system-ppc
> [ 1259.331345] MCE: CPU40: Software error, small probability of hardware failure

"Software error, small probability of hardware failure"

That can be read as "there has been a software error, *and now* there is
a small probability of a hardware failure".

I also think "probability" suggests we actually know the mathematical
probability of it being a hardware failure, which is not true.

Instead maybe we use:

	"Hardware error",
	"Probable hardware error (some chance of software cause)",
	"Software error",
	"Probable software error (some chance of hardware cause)",

??

cheers
