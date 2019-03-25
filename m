Return-Path: <SRS0=tR2X=R4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF96C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 12:06:42 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AA8D20850
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 12:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="TibWfMpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AA8D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44SXzy45MyzDq7k
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Mar 2019 23:06:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="TibWfMpU"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44SXwJ5K3DzDq9H
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Mar 2019 23:03:27 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44SXw63yflz9tygD;
 Mon, 25 Mar 2019 13:03:18 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=TibWfMpU; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id p1czizD-kox4; Mon, 25 Mar 2019 13:03:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44SXw62hFHz9tyg4;
 Mon, 25 Mar 2019 13:03:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553515398; bh=T4NbrCH6aXU4ltzqU0CxcjPesaPxsgHnsd6blOpo31M=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=TibWfMpULs7gO5/Kz43cQ+60YJxuDDDE9mrDaDk5Y/Z85xPK05uaq0cCGr5X9Jtxy
 bkIvcG+HUkQMSfhLmZuEKG0AF6lKDFY9jLzgox6q3HySaQ/be15v4ickmY0RS+Srj/
 DLqt2zw4saaJ+W1qwzSLT310A00hf5afzY8zPeB4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 398FC8B8A5;
 Mon, 25 Mar 2019 13:03:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id DOkPr66wOGGh; Mon, 25 Mar 2019 13:03:23 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 19D828B74F;
 Mon, 25 Mar 2019 13:03:23 +0100 (CET)
Subject: Re: powerpc/mm: Only define MAX_PHYSMEM_BITS in SPARSEMEM
 configurations
To: Michael Ellerman <mpe@ellerman.id.au>, Ben Hutchings
 <ben@decadent.org.uk>, Andreas Schwab <schwab@linux-m68k.org>
References: <20190317011756.abjylw3nzfnc6gnh@decadent.org.uk>
 <44QjSh4zGhz9sV2__48832.6491251186$1553257542$gmane$org@ozlabs.org>
 <87k1gnq5lp.fsf@igel.home>
 <eb21be1ac183dd206da3a389b426707c535c463c.camel@decadent.org.uk>
 <87ftrbq0qe.fsf@igel.home>
 <cf9154f1812e0e9a328a1e21ef13d80a46e5feb6.camel@decadent.org.uk>
 <87a7hjp4oi.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <b99811d4-da03-4dfe-4574-f7f77320cf1c@c-s.fr>
Date: Mon, 25 Mar 2019 13:03:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <87a7hjp4oi.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 25/03/2019 à 12:35, Michael Ellerman a écrit :
> Ben Hutchings <ben@decadent.org.uk> writes:
>> On Mon, 2019-03-25 at 01:03 +0100, Andreas Schwab wrote:
>>> On Mär 24 2019, Ben Hutchings <ben@decadent.org.uk> wrote:
>>>
>>>> Presumably you have CONFIG_PPC_BOOK3S_64 enabled and
>>>> CONFIG_SPARSEMEM
>>>> disabled?  Was this configuration actually usable?
>>>
>>> Why not?
>>
>> I assume that CONFIG_SPARSEMEM is the default for a good reason.
>> What I don't know is how strong that reason is (I am not a Power expert
>> at all).  Looking a bit further, it seems to be related to CONFIG_NUMA
>> in that you can enable CONFIG_FLATMEM if and only if that's disabled.
>> So I suppose the configuration you used works for non-NUMA systems.
> 
> Aneesh pointed out this fix would break FLATMEM after I'd merged it, but
> it didn't break any of our defconfigs so I wondered if anyone would
> notice.
> 
> I checked today and a G5 will boot with FLATMEM, which I assume is what
> Andreas is using.
> 
> I guess we should fix this build break for now.
> 
> Even some G5's have discontiguous memory, so FLATMEM is not clearly a
> good choice even for all G5's, and actually a fresh g5_defconfig uses
> SPARSEMEM.
> 
> So I'm inclined to just switch to always using SPARSEMEM on 64-bit
> Book3S, because that's what's well tested and we hardly need more code
> paths to test. Unless anyone has a strong objection, I haven't actually
> benchmarked FLATMEM vs SPARSEMEM on a G5.
> 

Christian Zigotzky reported a build failure with this patch.

Christophe
