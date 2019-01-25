Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6776C282C3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 00:57:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C173218CD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 00:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C173218CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43m0x25qqxzDqLJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 11:57:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43m0v82cSbzDqGg
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 11:55:48 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0P0tZEt006734;
 Thu, 24 Jan 2019 18:55:36 -0600
Message-ID: <3517bf7d54e9a2c6cdd054cefd75b5e073823042.camel@kernel.crashing.org>
Subject: Re: BUG: memcmp(): Accessing invalid memory location
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chandan Rajendra <chandan@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 25 Jan 2019 11:55:34 +1100
In-Reply-To: <17042269.pB4heZKTbK@localhost.localdomain>
References: <17042269.pB4heZKTbK@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
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
Cc: Anton Blanchard <anton@au1.ibm.com>, Nick Piggin <npiggin@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-01-24 at 19:48 +0530, Chandan Rajendra wrote:
> - Here we execute "LD rB,0,r4". In the case of this bug, r4 has an unaligned
>   value and hence ends up accessing the "next" double word. The "next" double
>   word happens to occur after the last page mapped into the kernel's address
>   space and hence this leads to the previously listed oops.
>   

This is interesting ... should we mark the last page of any piece of
mapped linear mapping as reserved to avoid that sort of issue ?

Nick ? Aneesh ?

Cheers,
Ben.


