Return-Path: <SRS0=yMLg=3F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B96C33CB3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 06:12:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8248E20728
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 06:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WZN0vM84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8248E20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47yv3f3XSRzDqW2
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 17:11:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47yv0h6cNNzDqW9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2020 17:09:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=WZN0vM84; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47yv0h1WT8z9sPW;
 Thu, 16 Jan 2020 17:09:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1579154964;
 bh=MvGZT+9fOj0sr9DNI/NqTlnD+IU/BNYjErvZPCzQ4dg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WZN0vM84wWj/it4iWvAeFopSmOGIgTLG6/toqPUpBLTcKWFUeOdRdxJFeM051y5t+
 TEVtuk1/ldb82715RpbYAtnQG7zY80HuZSor177Ur2sLcPwa7F3HD7lzYXbRlhroyg
 T7bKMSVZCpg3NfVPfB2W7BBBH6ICok94ravqVS1/THe9g+eWqcXSh+Jk4UAq6izad8
 D6EecKsOscDW+FH876WimBkYmWzZcjpL9jo+sJFrzaj2gayriJ22V9wQdtm6s+dqGi
 UbsqcppoOEasbfOqufWa2+lm6bDgyFDuFbta67F+h5gkArLCLcH4omVNCQczHw5V2D
 QAg0rNiR7b2Rw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balamuruhan S <bala24@linux.ibm.com>, Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH 14/18] powerpc/kprobes: Support kprobes on prefixed
 instructions
In-Reply-To: <20200114071927.GA8713@dhcp-9-109-246-161.in.ibm.com>
References: <20191126052141.28009-1-jniethe5@gmail.com>
 <20191126052141.28009-15-jniethe5@gmail.com>
 <20200114071927.GA8713@dhcp-9-109-246-161.in.ibm.com>
Date: Thu, 16 Jan 2020 16:09:32 +1000
Message-ID: <87wo9s7x0j.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: alistair@popple.id.au, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Balamuruhan S <bala24@linux.ibm.com> writes:
> On Tue, Nov 26, 2019 at 04:21:37PM +1100, Jordan Niethe wrote:
...
>> diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
>> index 7303fe3856cc..aa15b3480385 100644
>> --- a/arch/powerpc/kernel/kprobes.c
>> +++ b/arch/powerpc/kernel/kprobes.c
>> @@ -104,17 +104,30 @@ kprobe_opcode_t *kprobe_lookup_name(const char *name, unsigned int offset)
>>  
>>  int arch_prepare_kprobe(struct kprobe *p)
>>  {
>> +	int len;
>>  	int ret = 0;
>> +	struct kprobe *prev;
>>  	kprobe_opcode_t insn = *p->addr;
>> +	kprobe_opcode_t prfx = *(p->addr - 1);
>>  
>> +	preempt_disable();
>>  	if ((unsigned long)p->addr & 0x03) {
>>  		printk("Attempt to register kprobe at an unaligned address\n");
>>  		ret = -EINVAL;
>>  	} else if (IS_MTMSRD(insn) || IS_RFID(insn) || IS_RFI(insn)) {
>>  		printk("Cannot register a kprobe on rfi/rfid or mtmsr[d]\n");
>>  		ret = -EINVAL;
>> +	} else if (IS_PREFIX(prfx)) {
>> +		printk("Cannot register a kprobe on the second word of prefixed instruction\n");
>
> Let's have line with in 80 columns length.

We don't split printk strings across lines. So this is fine.

cheers
