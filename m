Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289D5C04EBD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:33:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9197D20869
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9197D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42ZGVX3z0wzF3WS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 00:33:56 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42ZG7h56yKzF3Vn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 00:17:36 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 42ZG7N2D3qz9ttBk;
 Tue, 16 Oct 2018 15:17:20 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 9SYzrkQLiBgC; Tue, 16 Oct 2018 15:17:20 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 42ZG7N1cs3z9ttBd;
 Tue, 16 Oct 2018 15:17:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 36D6E8B7D2;
 Tue, 16 Oct 2018 15:17:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id pruGa4nnkW4q; Tue, 16 Oct 2018 15:17:31 +0200 (CEST)
Received: from PO15451 (unknown [192.168.232.3])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A8C9A8B7D0;
 Tue, 16 Oct 2018 15:17:30 +0200 (CEST)
Subject: Re: [PATCH] powerpc/io: remove old GCC version implementation
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "paulus@samba.org" <paulus@samba.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
References: <199ae2a28f14f944ee9ae2770a3f1dd030e762bc.1539693039.git.christophe.leroy@c-s.fr>
 <8eb877e31130aee531409d18e19894d64690163d.camel@infinera.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <627da6fc-a9f2-9028-7a37-6e31427cab28@c-s.fr>
Date: Tue, 16 Oct 2018 15:17:30 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8eb877e31130aee531409d18e19894d64690163d.camel@infinera.com>
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 16/10/2018 à 14:49, Joakim Tjernlund a écrit :
> On Tue, 2018-10-16 at 12:33 +0000, Christophe Leroy wrote:
>>
>>
>> GCC 4.6 is the minimum supported now.
> 
> Ouch, from kernel 4.19 or earlier even ?
> 

Don't know, see 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cafa0010

Christophe
