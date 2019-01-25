Return-Path: <SRS0=E5N6=QB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95EC282C0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 06:47:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8205B218D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 06:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="pANwzdrY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8205B218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43m8hR2Kw7zDqNN
	for <linuxppc-dev@archiver.kernel.org>; Fri, 25 Jan 2019 17:47:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="pANwzdrY"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43m8fV4PwVzDqLj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Jan 2019 17:45:21 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43m8fL0z5kz9v0C4;
 Fri, 25 Jan 2019 07:45:14 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=pANwzdrY; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id fAGV6CkHRvMl; Fri, 25 Jan 2019 07:45:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43m8fK6qXqz9v0C3;
 Fri, 25 Jan 2019 07:45:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548398713; bh=3Z3jUqBSR31ZK0KzQd7+upRcXSUeFBwDiU9R6hghjwg=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=pANwzdrY6dozs55BhTFSNxINJzg45/DV4zYA/u0cdE3qu4OeaqGkepu6/qz4N5BAN
 KdDwM9dl15PACamUCWUgXyPqEgLyjIlKb3QG2OgdwHT0NA8fQal71BAg54J3UIfDWc
 PlQqzDpwqy35IPGlb6ptfdJtQSU1d0zWvK6mu0CU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id C6C278B850;
 Fri, 25 Jan 2019 07:45:14 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 6IEEizCLUlNp; Fri, 25 Jan 2019 07:45:14 +0100 (CET)
Received: from PO15451 (unknown [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 98EE38B761;
 Fri, 25 Jan 2019 07:45:14 +0100 (CET)
Subject: Re: BUG: memcmp(): Accessing invalid memory location
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Chandan Rajendra <chandan@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <17042269.pB4heZKTbK@localhost.localdomain>
 <3517bf7d54e9a2c6cdd054cefd75b5e073823042.camel@kernel.crashing.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <c6395c70-cac3-649e-c96b-4b109069265b@c-s.fr>
Date: Fri, 25 Jan 2019 07:45:14 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <3517bf7d54e9a2c6cdd054cefd75b5e073823042.camel@kernel.crashing.org>
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
Cc: Anton Blanchard <anton@au1.ibm.com>, Nick Piggin <npiggin@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/01/2019 à 01:55, Benjamin Herrenschmidt a écrit :
> On Thu, 2019-01-24 at 19:48 +0530, Chandan Rajendra wrote:
>> - Here we execute "LD rB,0,r4". In the case of this bug, r4 has an unaligned
>>    value and hence ends up accessing the "next" double word. The "next" double
>>    word happens to occur after the last page mapped into the kernel's address
>>    space and hence this leads to the previously listed oops.
>>    
> 
> This is interesting ... should we mark the last page of any piece of
> mapped linear mapping as reserved to avoid that sort of issue ?

Or revert to a normal comparison once remaining length is < 8 and r4 in 
unaligned ?

Christophe

> 
> Nick ? Aneesh ?
> 
> Cheers,
> Ben.
> 
