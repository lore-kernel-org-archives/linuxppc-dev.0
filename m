Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C7AEC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 07:57:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDD1420823
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 07:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="l849hmSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD1420823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44T3QR5W3hzDqLG
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 18:57:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="l849hmSN"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44T3NZ1ZqdzDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 18:56:11 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44T3NQ5Prcz9v0yr;
 Tue, 26 Mar 2019 08:56:06 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=l849hmSN; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id D0GpGQyD4B87; Tue, 26 Mar 2019 08:56:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44T3NQ4Hffz9v94R;
 Tue, 26 Mar 2019 08:56:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553586966; bh=GEQyIWZhoFKvkHQMxXJT/lBoKmqbNtMGn6R0vP/VFyc=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=l849hmSNvNQTLip35PNMKLUjnYz3t9Fd2+Wsy0HsdL8bMcOh3Xs8+v5/fwtXlfddB
 TKY0BJxhW50qRf1mi2tearPzP+XrV07NdD/9aQGdVX4KW6i2qKVdx44UWbFl5AjO6+
 5kiuB79OJ6YUwNdcUk0usIrf8EOWT5ntIlmjB5pk=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 83EE78B8B9;
 Tue, 26 Mar 2019 08:56:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id bdz6WbiR9Bo6; Tue, 26 Mar 2019 08:56:07 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 38F558B74C;
 Tue, 26 Mar 2019 08:56:07 +0100 (CET)
Subject: Re: [PATCH] powerpc: vmlinux.lds: Drop Binutils 2.18 workarounds
To: Michael Ellerman <mpe@ellerman.id.au>, Joel Stanley <joel@jms.id.au>,
 linuxppc-dev@lists.ozlabs.org
References: <20190321003253.22100-1-joel@jms.id.au>
 <874l7qpi7l.fsf@concordia.ellerman.id.au>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <d340ae4b-a009-0ef3-9621-da3e0a7684f5@c-s.fr>
Date: Tue, 26 Mar 2019 07:55:33 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <874l7qpi7l.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 03/26/2019 12:55 AM, Michael Ellerman wrote:
> Joel Stanley <joel@jms.id.au> writes:
>> Segher added some workarounds for GCC 4.2 and bintuils 2.18. We now set
>> 4.6 and 2.20 as the minimum, so they can be dropped.
>>
>> This is mostly a revert of c69cccc95fe4 ("powerpc: Fix build bug with
>> binutils < 2.18 and GCC < 4.2").
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>   arch/powerpc/kernel/vmlinux.lds.S | 35 ++++---------------------------
>>   1 file changed, 4 insertions(+), 31 deletions(-)
> 
> Seems this breaks some toolchains, at least the one from kernel.org:
> 
>    /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: .tmp_vmlinux1: Not enough room for program headers, try linking with -N
>    /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: final link failed: Bad value
>    make[1]: *** [/kisskb/src/Makefile:1024: vmlinux] Error 1
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/13743374/
> 
> Not sure why.
> 
> That's binutils 2.30.
> 
> cheers
> 

Without the patch on PPC32:

Program Header:
     LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
          filesz 0x003c2ce4 memsz 0x003e1a08 flags rwx
     NOTE off    0x0038dca8 vaddr 0xc037dca8 paddr 0x0037dca8 align 2**2
          filesz 0x0000003c memsz 0x0000003c flags ---
     NOTE off    0x0038dce4 vaddr 0xc037dce4 paddr 0x0037dce4 align 2**0
          filesz 0x0000000c memsz 0x0000000c flags ---

With the patch:

Program Header:
     LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
          filesz 0x003c2ce4 memsz 0x003e1a08 flags rwx
     NOTE off    0x0038dca8 vaddr 0xc037dca8 paddr 0x0037dca8 align 2**2
          filesz 0x0000003c memsz 0x0000003c flags r--
    STACK off    0x00000000 vaddr 0x00000000 paddr 0x00000000 align 2**4
          filesz 0x00000000 memsz 0x00000000 flags rwx



Christophe
