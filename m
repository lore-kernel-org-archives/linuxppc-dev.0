Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B474C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 06:45:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 623C02086C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 06:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="RyN8k4dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 623C02086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444lMy4krzzDq6X
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 17:45:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="RyN8k4dr"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444l4G0VrTzDqNJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 17:31:41 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 444l490nF2z9vJg7;
 Thu, 21 Feb 2019 07:31:37 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=RyN8k4dr; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id eEPgbHiiq72J; Thu, 21 Feb 2019 07:31:37 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 444l486XKvz9vJg5;
 Thu, 21 Feb 2019 07:31:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550730696; bh=/wb2LIDZ0fxbdvU6sID2j7WKHhZiR0KJLlAdpH+QLdQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=RyN8k4drr2Odx8Ttdi9V51UZP8P+lXVhGJZIvdC29WHJoOg8JjAECZjy7Du3id7Ko
 iF+gvOzyyKaG+BSIDMmO9nP/2x6QSMewSZ+ADrWPPOqmOM9pnjAsQfVhdY8QOVkv/6
 0aajyJ5jzymwh+O/ayt6LogXvGYBuztdNv6kvREU=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id B7BD08B78F;
 Thu, 21 Feb 2019 07:31:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id TXBC2CR6r9Ia; Thu, 21 Feb 2019 07:31:37 +0100 (CET)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 282A68B75B;
 Thu, 21 Feb 2019 07:31:37 +0100 (CET)
Subject: Re: [PATCH v3 00/16] powerpc/32: Use BATs/LTLBs for STRICT_KERNEL_RWX
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, j.neuschaefer@gmx.net
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
 <87mumpx68h.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <82af8805-3e2a-cfb3-9df6-d883b50ff460@c-s.fr>
Date: Thu, 21 Feb 2019 07:31:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <87mumpx68h.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 21/02/2019 à 02:47, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> The purpose of this serie is to:
>> - use BATs with STRICT_KERNEL_RWX on book3s (See patch 13 for details.)
>> - use LTLBs with STRICT_KERNEL_RWX on 8xx (See patch 15 for a few details.)
> 
> This doesn't boot qemu-mac99 for me:
> 
>    spawn ~/src/qemu/ppc-softmmu/qemu-system-ppc -nographic -vga none -M mac99 -m 1G -kernel build/vmlinux -initrd ppc32-initrd.gz -append console=ttyPZ0 init=/bin/sh
>    >> =============================================================
>    >> OpenBIOS 1.1 [Feb 15 2019 10:05]
>    >> Configuration device id QEMU version 1 machine id 1
>    >> CPUs: 1
>    >> Memory: 1024M
>    >> UUID: 00000000-0000-0000-0000-000000000000
>    >> CPU type PowerPC,G4
>    milliseconds isn't unique.
>    Welcome to OpenBIOS v1.1 built on Feb 15 2019 10:05
>    >> [ppc] Kernel already loaded (0x01000000 + 0x00c2c338) (initrd 0x01d2d000 + 0x007e72f0)
>    >> [ppc] Kernel command line: console=ttyPZ0 init=/bin/sh
>    >> switching to new context:
>    OF stdout device is: /pci@f2000000/mac-io@c/escc@13000/ch-a@13020
>    Preparing to boot Linux version 5.0.0-rc2-gcc-8.2.0-00125-g4fcb83ca7936 (michael@ka4) (gcc version 8.2.0 (Buildroot 2018.11-rc2-00003-ga0787e9)) #724 Thu Feb 21 12:03:14 AEDT 2019
>    Detected machine type: 00000400
>    command line:
>    memory layout at init:
>      memory_limit : 00000000 (16 MB aligned)
>      alloc_bottom : 02515000
>      alloc_top    : 30000000
>      alloc_top_hi : 40000000
>      rmo_top      : 30000000
>      ram_top      : 40000000
>    copying OF device tree...
>    Building dt strings...
>    Building dt structure...
>    Device tree strings 0x02516000 -> 0x025150a4
>    Device tree struct  0x02517000 -> 0x3fde7eb0
>    Quiescing Open Firmware ...
>    Booting Linux via __start() @ 0x01000000 ...
>    FAIL! Booting BE pmac32
> 
> 
> That's pmac32 defconfig ish.
> I haven't had time to debug it further sorry.
> 

Ok. I boots fine without the '-m 1G'.

I'll find out why.

Christophe
