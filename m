Return-Path: <SRS0=L8Yn=U2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF95C48BD6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 00:27:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7516C2083B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 00:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7516C2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Z11T1J3fzDqX1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 10:27:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 45Z0zc0xzGzDqKK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2019 10:25:31 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by kvm5.telegraphics.com.au (Postfix) with ESMTP id 453FC29B40;
 Wed, 26 Jun 2019 20:25:21 -0400 (EDT)
Date: Thu, 27 Jun 2019 10:25:19 +1000 (AEST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: Bisected regression in v5.1 on PowerBook G3 (Wallstreet)
In-Reply-To: <03df9f3c-003a-b4ae-6f76-ba8a20742b25@c-s.fr>
Message-ID: <alpine.LNX.2.21.1906271019060.21@nippy.intranet>
References: <alpine.LNX.2.21.1906261134540.121@nippy.intranet>
 <03df9f3c-003a-b4ae-6f76-ba8a20742b25@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linuxppc-dev@lists.ozlabs.org, Stan <userm57@yahoo.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 26 Jun 2019, Christophe Leroy wrote:

> Hi Finn,
> 
> On 06/26/2019 02:06 AM, Finn Thain wrote:
> > Hi Christophe,
> > 
> > I received a report of a regression between v5.0 and v5.1 which causes 
> > the current release to crash during boot with a machine check 
> > exception. Please see console log below.
> > 
> > Stan (whom I've Cc'd) tells me that this happens on every attempt to 
> > boot. I asked him to try 'git bisect'. The results are given below. 
> > Can you see anything in commit 93c4a162b014 that might explain this?
> 
> Might be a false positive. That commit has a problem, but that problem 
> is fixed by 4622a2d43101 ("powerpc/6xx: fix setup and use of 
> SPRN_SPRG_PGDIR for hash32")
> 
> I would bet your problem is related to commit f7354ccac844 ("powerpc/32: 
> Remove CURRENT_THREAD_INFO and rename TI_CPU"). That problem is fixed by 
> commit 397d2300b08c ("powerpc/32s: fix flush_hash_pages() on SMP") 
> upstream, and in linux 5.1.4 by commit fda49aec2515 on 
> stable/linux-5.1.y
> 

I see. I've just discovered that this issue has already been covered on 
this list. I should have done a bit more research.

> Can you test ?
> 

Stan did some more tests and confirmed that the problem has been fixed in 
397d2300b08c and stable/linux-5.1.y.

Thanks.

-- 

> Thanks
> Christophe
> 
