Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46B8DC4828D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Feb 2024 02:03:32 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=GW3Z40Z7;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TQzZp57cnz3cb5
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Feb 2024 13:03:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=GW3Z40Z7;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TQzYt4pC6z3bWn
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Feb 2024 13:02:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1706839360;
	bh=PEcxsJF2CTTjZuWSy4Xx0tjVfsXr7JmaTkfi6RzNsm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GW3Z40Z7fQrY9JQPRF0oibDjuRoaMH5vrqYSBSg4R4dyUx6aXNzHqozZwcCIaYjUt
	 /2e6d4LSgpgjSiaFZ8F7fV3XGJoCqxk1H/RrlwWs73gevyP/d1QbrK6k1fbKVKsg0l
	 iSiSmvHvAQ1QAPmsPacTaG8IV2wU7UVFat1CT0wOWxpDgEH/d16QZWu43UgayHXoUt
	 J1NyUThPQqeoDhVFsgu6BlCAEs15q05jhc2e5c/VRJ28FZGh5LT5AUkBH76A/HRJEK
	 MBLdeLI8aLg/YtzE3iPV3tSqTaMiEdACFyN4R3HjnAFdw1HiI5Ex9xPRxhrmuuN3tu
	 ppsDrzZJEmBlQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQzYr210lz4wcM;
	Fri,  2 Feb 2024 13:02:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>, Naveen N Rao
 <naveen@kernel.org>
Subject: Re: [PATCH] powerpc/64: Set LR to a non-NULL value in task pt_regs
 on scv entry
In-Reply-To: <20240125142410.GO19790@gate.crashing.org>
References: <20240125114228.353257-1-naveen@kernel.org>
 <20240125142410.GO19790@gate.crashing.org>
Date: Fri, 02 Feb 2024 13:02:39 +1100
Message-ID: <87y1c38vy8.fsf@mail.lhotse>
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
Cc: linuxppc-dev@lists.ozlabs.org, "Nysal Jan K.A" <nysal@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> Hi!
>
> On Thu, Jan 25, 2024 at 05:12:28PM +0530, Naveen N Rao wrote:
>> diff --git a/arch/powerpc/kernel/interrupt_64.S b/arch/powerpc/kernel/interrupt_64.S
>> index bd863702d812..5cf3758a19d3 100644
>> --- a/arch/powerpc/kernel/interrupt_64.S
>> +++ b/arch/powerpc/kernel/interrupt_64.S
>> @@ -53,6 +53,7 @@ _ASM_NOKPROBE_SYMBOL(system_call_vectored_\name)
>>  	ld	r1,PACAKSAVE(r13)
>>  	std	r10,0(r1)
>>  	std	r11,_NIP(r1)
>> +	std	r11,_LINK(r1)
>
> Please add a comment here then, saying what the store is for?

Yeah a comment would be good. 

Also the r11 value comes from LR, so it's not that we're storing the NIP
value into the LR slot, rather the value we store in NIP is from LR, see:

EXC_VIRT_BEGIN(system_call_vectored, 0x3000, 0x1000)
	/* SCV 0 */
	mr	r9,r13
	GET_PACA(r13)
	mflr	r11
        ...
	b	system_call_vectored_common

That's slightly pedantic, but I think it answers the question of why
it's OK to use the same value for NIP & LR, or why we don't have to do
mflr in system_call_vectored_common to get the actual LR value.

cheers
