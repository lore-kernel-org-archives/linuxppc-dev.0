Return-Path: <SRS0=Hg4A=QZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848C6C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 12:31:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020C521479
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 12:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hXocnnzE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020C521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4433Bk02MzzDqFv
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 23:31:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="hXocnnzE"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44336B6dyXzDqGT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 23:27:30 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4433623bkkz9v0s0;
 Mon, 18 Feb 2019 13:27:22 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=hXocnnzE; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id xnPoIKiyr2Tz; Mon, 18 Feb 2019 13:27:22 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4433622PkSz9v0ry;
 Mon, 18 Feb 2019 13:27:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550492842; bh=hQT/+PJjJ4uOSzRN3y8sJadEv/S2sqSMsV4Kg6qvXM4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hXocnnzE562Olurqg4SCprpXHPQRR7Cji47bNUikfEGOFBR5XxtjpKxa6aM0dSJO4
 OC+6YLQ3ywhlnhJtNShvi3EjPK4BeFMYyW9LncvK221GyHlmIEOFs+32FongZhdqGA
 oTUFPgIomnCPwTsKCe29V3nmPLdq51PbRcjeJIxc=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F88B8B7BD;
 Mon, 18 Feb 2019 13:27:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id YeDh_994Gmr9; Mon, 18 Feb 2019 13:27:27 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 07AFE8B7B9;
 Mon, 18 Feb 2019 13:27:27 +0100 (CET)
Subject: Re: [RFC PATCH 4/5] powerpc: move KASAN into its own subdirectory
To: Michael Ellerman <mpe@ellerman.id.au>, Daniel Axtens <dja@axtens.net>,
 aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
References: <20190215000441.14323-1-dja@axtens.net>
 <20190215000441.14323-5-dja@axtens.net>
 <252ac94f-1fd6-8df1-9dd3-95ea3d68b67e@c-s.fr>
 <87d0npqwzr.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <ae3b0a61-e11f-5dc1-469b-8cf2daa15201@c-s.fr>
Date: Mon, 18 Feb 2019 13:27:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87d0npqwzr.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 18/02/2019 à 10:14, Michael Ellerman a écrit :
> christophe leroy <christophe.leroy@c-s.fr> writes:
> 
>> Le 15/02/2019 à 01:04, Daniel Axtens a écrit :
>>> In preparation for adding ppc64 implementations, break out the
>>> code into its own subdirectory.
>>
>> That's not a bad idea, arch/powerpc/mm is rather messy with lot of
>> subarch stuff.
> 
> I'm always happy to have more directories with more focused content.
> 

Nice to know how to make you happy :)

I'll send you a patch for moving all page table dumping stuff into a 
subdirectory.

Christophe
