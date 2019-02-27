Return-Path: <SRS0=o5MI=RC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B7CC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 06:43:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BC3B218D9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 06:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="V08x5vsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BC3B218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 448R2Z2ZdDzDqN6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Feb 2019 17:43:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="V08x5vsK"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 448R0k5f95zDqGN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Feb 2019 17:41:25 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 448R0c47Gjz9v6bH;
 Wed, 27 Feb 2019 07:41:20 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=V08x5vsK; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id tyaE1m7GSJ-T; Wed, 27 Feb 2019 07:41:20 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 448R0c2x09z9v6b2;
 Wed, 27 Feb 2019 07:41:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1551249680; bh=/WTpEvhn535iolJQ2rHEGqokb0fZGVjpmqYASuaDIPo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=V08x5vsK9e5+heXIXdmVYZsFMDmtKxvSdrhJt1281r8TEkWtVwdYMJkrGW4SadYrj
 /TL5zYVrl8TCM5H9lPIPMFMnPzWPtninnbhrQS69OnKtQ46OCb3i18cpQiNtgvknSP
 YlI5XSIKwBn0qrZbYa1dmfauUalHSpYe1pdZXI30=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 441288B888;
 Wed, 27 Feb 2019 07:41:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id IuJkyR-KQW9n; Wed, 27 Feb 2019 07:41:21 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 24D408B754;
 Wed, 27 Feb 2019 07:41:21 +0100 (CET)
Subject: Re: build failure of current mmotm with skiroot_defconfig
To: Paul Mackerras <paulus@ozlabs.org>, Mike Rapoport <rppt@linux.ibm.com>
References: <20190226081224.GA11981@rapoport-lnx>
 <3844e8ab-ed20-c202-2e65-6179631b7d91@c-s.fr>
 <20190226095908.GD11981@rapoport-lnx> <20190226222408.GE28015@blackberry>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <fea8a5ef-2c90-8222-fc80-3ae77a2fd473@c-s.fr>
Date: Wed, 27 Feb 2019 07:41:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190226222408.GE28015@blackberry>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/02/2019 à 23:24, Paul Mackerras a écrit :
> On Tue, Feb 26, 2019 at 11:59:08AM +0200, Mike Rapoport wrote:
>> On Tue, Feb 26, 2019 at 10:39:54AM +0100, Christophe Leroy wrote:
>>>
>>>
>>> Le 26/02/2019 à 09:12, Mike Rapoport a écrit :
>>>> Hi,
>>>>
>>>> I've encountered the following error when building skyroot_defconfig with
>>>> current mmotm tree:
>>>>
>>>> make CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y CROSS_COMPILE=/opt/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux- ARCH=powerpc vmlinux
>>>>    ...
>>>>    CC      arch/powerpc/kernel/dbell.o
>>>> In file included from arch/powerpc/kernel/dbell.c:20:
>>>> arch/powerpc/include/asm/kvm_ppc.h: In function 'xics_on_xive':
>>>> arch/powerpc/include/asm/kvm_ppc.h:625:9: error: implicit declaration of function 'xive_enabled'; did you mean 'eeh_enabled'? [-Werror=implicit-function-declaration]
>>>>    return xive_enabled() && cpu_has_feature(CPU_FTR_HVMODE);
>>>>           ^~~~~~~~~~~~
>>>>           eeh_enabled
>>>
>>> I can neither find the above in arch/powerpc/include/asm/kvm_ppc.h in the
>>> powerpc tree, nor a patch removing it.
>>>
>>> Where does that comes from ?
>>
>> It's from current mmotm, probably some merge conflict...
> 
> It's not a merge conflict; see http://patchwork.ozlabs.org/patch/1048584/
> for the fix.
> 

Why not include asm/xive.h all the time, as it defines xive_enabled() 
for when CONFIG_PPC_XIVE is set and for when it is not set ?

Christophe
