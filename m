Return-Path: <SRS0=BgZL=ZL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D08C432C3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 17:52:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CB972231A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 19 Nov 2019 17:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CB972231A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47HYL84jRvzDqh3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Nov 2019 04:52:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47HYHh3sKqzDqd9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2019 04:49:52 +1100 (AEDT)
Received: from localhost (mailhub1-ext [192.168.12.233])
 by localhost (Postfix) with ESMTP id 47HYHb6zBXz9tyMG;
 Tue, 19 Nov 2019 18:49:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id XqvRI0tj-P3k; Tue, 19 Nov 2019 18:49:47 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 47HYHb5ktBz9tyM0;
 Tue, 19 Nov 2019 18:49:47 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id AD0F387D; Tue, 19 Nov 2019 18:49:48 +0100 (CET)
Received: from 37-173-93-145.coucou-networks.fr
 (37-173-93-145.coucou-networks.fr [37.173.93.145]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Tue, 19 Nov 2019 18:49:48 +0100
Date: Tue, 19 Nov 2019 18:49:48 +0100
Message-ID: <20191119184948.Horde.Roz3CrP_eBhY_YnNAgMQ7w1@messagerie.si.c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/8xx: Fix permanently mapped IMMR region.
References: <ad9d45119a48a92bf122781d0c79c9407baa12d7.1566554026.git.christophe.leroy@c-s.fr>
 <87sgmlcu1x.fsf@mpe.ellerman.id.au>
In-Reply-To: <87sgmlcu1x.fsf@mpe.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> a =C3=A9crit=C2=A0:

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> When not using large TLBs, the IMMR region is still
>> mapped as a whole block in the FIXMAP area.
>>
>> Do not remove pages mapped in the FIXMAP region when
>> initialising paging.
>>
>> Properly report that the IMMR region is block-mapped even
>> when not using large TLBs.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/mm/mem.c        |  8 --------
>>  arch/powerpc/mm/nohash/8xx.c | 13 +++++++------
>>  2 files changed, 7 insertions(+), 14 deletions(-)
>
> This blows up pmac32_defconfig + qemu mac99 for me with:

Ok, then there is still something I have not understood about fixmap.=20=20
I'll=20look at it next week

Christophe

