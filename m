Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ECAC47DB3
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Feb 2024 14:20:27 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LY6Vyq6l;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TRHx62Brtz3cfT
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Feb 2024 01:20:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=LY6Vyq6l;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:40e1:4800::1; helo=sin.source.kernel.org; envelope-from=naveen@kernel.org; receiver=lists.ozlabs.org)
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TRHw92RMJz3cB0
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2024 01:19:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4B2C8CE2A1B;
	Fri,  2 Feb 2024 14:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0D3C433C7;
	Fri,  2 Feb 2024 14:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706883572;
	bh=y0hnzBf06Zk2ONW+OyM/RLUvsg3Q/oa4H8Qi+OMAKhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LY6Vyq6l44vPa2OwOG6VSF337h07gi6azvgJ2hUYYgVQcKJ4iK2YpjtFa2jApdJrQ
	 jiBGm0l8pzi2raHlkqK+OcKpVNle+ENaPbmv283ddJgc2hvS9qbub0bNxf208eDyaR
	 ov4jR8ErdVBIQUXRO54/4HAHFAMny39FVP91SS7srtXqosJVbLJbF+Zuz5e1jRHKDA
	 e5s10uY+p2HmoXRAviSXz38y51j7z02ikZoTAP2bpimexBpqoSO8ybkT4HIHkE4nDk
	 RhWu+x4Cry2xv1v0rd/avIAtglr3q1fyvC5YzRMNCa1+d0UJn6HUuhnmtEgK+vdWKo
	 Xw6aGu0VO2ZBQ==
Date: Fri, 2 Feb 2024 19:45:34 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Re: [PATCH] powerpc/64: Set LR to a non-NULL value in task
 pt_regs on scv entry
Message-ID: <wafpjx2jtlyzkx3ujkmcthiyepnunslrrdwevyea2e2hiyrny3@qezpv3liyuvu>
References: <20240125114228.353257-1-naveen@kernel.org>
 <20240125142410.GO19790@gate.crashing.org>
 <87y1c38vy8.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1c38vy8.fsf@mail.lhotse>
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

On Fri, Feb 02, 2024 at 01:02:39PM +1100, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > Hi!
> >
> > On Thu, Jan 25, 2024 at 05:12:28PM +0530, Naveen N Rao wrote:
> >> diff --git a/arch/powerpc/kernel/interrupt_64.S b/arch/powerpc/kernel/interrupt_64.S
> >> index bd863702d812..5cf3758a19d3 100644
> >> --- a/arch/powerpc/kernel/interrupt_64.S
> >> +++ b/arch/powerpc/kernel/interrupt_64.S
> >> @@ -53,6 +53,7 @@ _ASM_NOKPROBE_SYMBOL(system_call_vectored_\name)
> >>  	ld	r1,PACAKSAVE(r13)
> >>  	std	r10,0(r1)
> >>  	std	r11,_NIP(r1)
> >> +	std	r11,_LINK(r1)
> >
> > Please add a comment here then, saying what the store is for?
> 
> Yeah a comment would be good. 
> 
> Also the r11 value comes from LR, so it's not that we're storing the NIP
> value into the LR slot, rather the value we store in NIP is from LR, see:
> 
> EXC_VIRT_BEGIN(system_call_vectored, 0x3000, 0x1000)
> 	/* SCV 0 */
> 	mr	r9,r13
> 	GET_PACA(r13)
> 	mflr	r11
>         ...
> 	b	system_call_vectored_common
> 
> That's slightly pedantic, but I think it answers the question of why
> it's OK to use the same value for NIP & LR, or why we don't have to do
> mflr in system_call_vectored_common to get the actual LR value.

Thanks for clarifying that. I should have done a better job describing 
that in the commit log. I'll update that, add a comment here and send a 
v2.


- Naveen

