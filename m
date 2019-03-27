Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB54C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 06:46:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F1502075D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 06:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="MK3aMLu/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1502075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Tdp20tvBzDqHl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 17:46:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="MK3aMLu/"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Tdft6zDfzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 17:40:37 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Tdfl5c2Yz9v0Nh;
 Wed, 27 Mar 2019 07:40:31 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=MK3aMLu/; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id XKRB41mz8Tdh; Wed, 27 Mar 2019 07:40:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Tdfl3sSDz9v0Ng;
 Wed, 27 Mar 2019 07:40:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553668831; bh=68pWzEv70z43yk4VZu+kZRUnSZAh+gQ1Ne1IYOEASDA=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=MK3aMLu/Pbuylr7pBi9xVdEg6aV8NY+2Vmh5hig8l1+Pr/L2MK1puweVRh5f7bjGS
 f0Yu01VKnR0LYDHS0CPDsq0d0/04mZMtkzonMDczibD8pBTji9/+eAfuEAKbf0I/cI
 pzcEYS8Uz4cqOJI1/ggWgIc+bQzuE2Q715kBZAm4=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 61FF88B82C;
 Wed, 27 Mar 2019 07:40:32 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZxZ8Y4A6BAPa; Wed, 27 Mar 2019 07:40:32 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 3FD318B817;
 Wed, 27 Mar 2019 07:40:32 +0100 (CET)
Subject: Re: [PATCH] powerpc: vmlinux.lds: Drop Binutils 2.18 workarounds
To: Segher Boessenkool <segher@kernel.crashing.org>
References: <20190321003253.22100-1-joel@jms.id.au>
 <874l7qpi7l.fsf@concordia.ellerman.id.au>
 <d340ae4b-a009-0ef3-9621-da3e0a7684f5@c-s.fr>
 <20190326181914.GS3969@gate.crashing.org>
 <5f4aa4b2-1c44-70b9-c383-5d40aecd695c@c-s.fr>
 <20190326201231.GV3969@gate.crashing.org>
 <20190326222941.GW3969@gate.crashing.org>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8aa0290a-908c-38d8-e040-c8c0cc226eb9@c-s.fr>
Date: Wed, 27 Mar 2019 07:40:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190326222941.GW3969@gate.crashing.org>
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
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 26/03/2019 à 23:29, Segher Boessenkool a écrit :
> On Tue, Mar 26, 2019 at 03:12:31PM -0500, Segher Boessenkool wrote:
>> On Tue, Mar 26, 2019 at 08:28:58PM +0100, Christophe Leroy wrote:
>>>
>>>
>>> Le 26/03/2019 à 19:19, Segher Boessenkool a écrit :
>>>> On Tue, Mar 26, 2019 at 07:55:33AM +0000, Christophe Leroy wrote:
>>>>>     STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**4
>>>>>           filesz 0x00000000 memsz 0x00000000 flags rwx
>>>>
>>>> You need to prevent this one somehow.  What object file forces this?
>>>
>>> mpc885_ads_defconfig
>>
>> No, which object file, ".o file".  Not defconfig :-)
> 
> I tried to reproduce this.  It does not fail with a ppc6xx_defconfig
> build, and mpc885_ads_defconfig fails with

So far, the only defconfig which fails for me is ppc64_defconfig, like 
Michael.

885_ads is ok, I just noticed the STACK header in vmlinux that is not 
there when the patch is not applies.

> 
> INFO: Uncompressed kernel (size 0x435178) overlaps the address of the wrapper(0x400000)
> INFO: Fixing the link_address of wrapper to (0x500000)
> ln: failed to access 'arch/powerpc/boot/cuImage.mpc885ads': No such file or directory
> 
> What is your GCC?

[root@localhost linux-powerpc]# powerpc64-linux-gcc -v
Using built-in specs.
COLLECT_GCC=powerpc64-linux-gcc
COLLECT_LTO_WRAPPER=/opt/gcc-8.1.0-nolibc/powerpc64-linux/bin/../libexec/gcc/powerpc64-linux/8.1.0/lto-wrapper
Target: powerpc64-linux
Configured with: /home/arnd/git/gcc/configure --target=powerpc64-linux 
--enable-targets=all 
--prefix=/home/arnd/cross/x86_64/gcc-8.1.0-nolibc/powerpc64-linux 
--enable-languages=c --without-headers --disable-bootstrap --disable-nls 
--disable-threads --disable-shared --disable-libmudflap --disable-libssp 
--disable-libgomp --disable-decimal-float --disable-libquadmath 
--disable-libatomic --disable-libcc1 --disable-libmpx 
--enable-checking=release
Thread model: single
gcc version 8.1.0 (GCC)

[root@localhost linux-powerpc]# powerpc64-linux-ld -v
GNU ld (GNU Binutils) 2.30

Christophe
