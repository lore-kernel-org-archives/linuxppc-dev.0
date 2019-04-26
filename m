Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5238BC43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 07:29:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BC41206E0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 07:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="Sguaa3kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC41206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44r5KP0R8QzDqjy
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 17:29:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="Sguaa3kr"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44r5Hh2hWnzDq5t
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 17:27:59 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44r5HZ4PHyz9v1tg;
 Fri, 26 Apr 2019 09:27:54 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=Sguaa3kr; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id asj_y7EPkUFf; Fri, 26 Apr 2019 09:27:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44r5HZ3Bgcz9v1tb;
 Fri, 26 Apr 2019 09:27:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556263674; bh=dbEw4emzmOoXiMom8HoU4olCvRgDJwvoSJXPGdWOd0A=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Sguaa3kr7a0fpWyJkMeIF4P3NTvX1PHJoUtvdW/pCBRgsyjPzHLuae62Xziwehq0y
 bm+Iw1l5MRX0Ad1HVfn0pzE4RvVYM+8CsJnrBBuge496sV5wB/69PQubqORn3cfYUL
 C/P9n1+JJMo71qeBtKt0hfaHyy2JjJM/7Nfht3Gc=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 7179C8B844;
 Fri, 26 Apr 2019 09:27:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id a3tNQ6UVIvG5; Fri, 26 Apr 2019 09:27:55 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A3678B82F;
 Fri, 26 Apr 2019 09:27:55 +0200 (CEST)
Subject: Re: BUG: crash in __tlb_remove_page_size with STRICT_KERNEL_RWX on
 BOOK3S_32
To: Serge Belyshev <belyshev@depni.sinp.msu.ru>
References: <87pnp9mknl.fsf@depni.sinp.msu.ru>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <db886597-8867-93e6-a507-6da4963ce0bd@c-s.fr>
Date: Fri, 26 Apr 2019 09:27:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87pnp9mknl.fsf@depni.sinp.msu.ru>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/04/2019 à 06:54, Serge Belyshev a écrit :
> Hi! Commit 63b2bc61956 aka "powerpc/mm/32s: Use BATs for STRICT_KERNEL_RWX"
> caused my old powerbook to crash under I/O.  After "dd if=/dev/hda of=/null"
> the crash happens in seconds.  Reverting the commit helps, as well as
> disabling STRICT_KERNEL_RWX.  Unfortunately, I was unable to capture the oops
> via the usb serial console, as it stuck right after the first "BUG: Unable to
> handle kernel data access at 0xe0c29000" message. Oops screenshot:
> http://aargh.no-ip.org/oops.jpg
> 

Hi Serge,

Could you please compile your kernel with CONFIG_PPC_PTDUMP, and provide 
the content of:

/sys/kernel/debug/kernel_page_tables
/sys/kernel/debug/powerpc/block_address_translation
/sys/kernel/debug/powerpc/segment_registers

Please also provide the begining of 'dmesg' that shows the memory layout.

Thanks
Christophe
