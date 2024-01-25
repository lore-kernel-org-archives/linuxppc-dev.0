Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9833CC47258
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jan 2024 14:26:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TLNSL1cmKz3cYJ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jan 2024 01:26:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57; helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org; receiver=lists.ozlabs.org)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TLNRr6XQQz3bnk
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2024 01:26:30 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 40PEOBb1007229;
	Thu, 25 Jan 2024 08:24:12 -0600
Received: (from segher@localhost)
	by gate.crashing.org (8.14.1/8.14.1/Submit) id 40PEOB0d007228;
	Thu, 25 Jan 2024 08:24:11 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date: Thu, 25 Jan 2024 08:24:10 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH] powerpc/64: Set LR to a non-NULL value in task pt_regs on scv entry
Message-ID: <20240125142410.GO19790@gate.crashing.org>
References: <20240125114228.353257-1-naveen@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125114228.353257-1-naveen@kernel.org>
User-Agent: Mutt/1.4.2.3i
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

Hi!

On Thu, Jan 25, 2024 at 05:12:28PM +0530, Naveen N Rao wrote:
> diff --git a/arch/powerpc/kernel/interrupt_64.S b/arch/powerpc/kernel/interrupt_64.S
> index bd863702d812..5cf3758a19d3 100644
> --- a/arch/powerpc/kernel/interrupt_64.S
> +++ b/arch/powerpc/kernel/interrupt_64.S
> @@ -53,6 +53,7 @@ _ASM_NOKPROBE_SYMBOL(system_call_vectored_\name)
>  	ld	r1,PACAKSAVE(r13)
>  	std	r10,0(r1)
>  	std	r11,_NIP(r1)
> +	std	r11,_LINK(r1)

Please add a comment here then, saying what the store is for?


Segher
