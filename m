Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE60CECDE32
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 16:38:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DF121480
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 16:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DF121480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZyXz5mNbzF3Zf
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 03:38:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZyW01SqCzF3Xk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 03:36:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42ZyVw0mqcz9ttS9;
 Wed, 17 Oct 2018 18:36:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id RG9_6AFcoMF9; Wed, 17 Oct 2018 18:36:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42ZyVw03kkz9ttRn;
 Wed, 17 Oct 2018 18:36:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A64168B883;
 Wed, 17 Oct 2018 18:36:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id 0Yam8D7_NtAj; Wed, 17 Oct 2018 18:36:40 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 430088B850;
 Wed, 17 Oct 2018 18:36:40 +0200 (CEST)
Subject: Re: MPC8321 boot failure
To: David Gounaris <David.Gounaris@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <CY1PR10MB020424967E404E0B1BBE1E82EFFF0@CY1PR10MB0204.namprd10.prod.outlook.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <0cbfec90-0e58-e267-71ae-c5fc8a8e0640@c-s.fr>
Date: Wed, 17 Oct 2018 18:36:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CY1PR10MB020424967E404E0B1BBE1E82EFFF0@CY1PR10MB0204.namprd10.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
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
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Mathias Thore <Mathias.Thore@infinera.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi,

Yes I discovered the same issue today on MPC8321E, I plan to look at it 
more closely tomorrow morning (Paris Time).

I think we are missing commit 8183d99f4a22c2abbc543847a588df3666ef0c0c , 
I didn't realise it when we applied the serie to 4.14, 
patch_instruction() is called too early without that patch.

If you have opportunity to test now, you are welcome, otherwise I'll 
test it tomorrow.

Christophe

Le 17/10/2018 à 17:18, David Gounaris a écrit :
> Hello, I got into troubles when I upgraded to Linux kernel 4.14.76 on 
> boards with MPC8321.
> 
> 
> The symptom that I see is that the boot process gets cyclic, and no 
> printouts are seen from the Linux kernel. It seems like it resets.
> 
> 
> When I revert the following commits it works again.
> 
> af1a8101794dfea897290e057f61086dabfe6c91, powerpc/lib: fix book3s/32 
> boot failure due to code patching
> 609fbeddb24c4035d24fc32d82dc08b30ae3dfc0, powerpc: Avoid code patching 
> freed init sections
> 
> Any ideas of how to continue?
> 
> BR / David Gounaris
> 
> 
> 
