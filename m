Return-Path: <SRS0=7E7R=OX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602FEC65BAE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 00:59:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3DBD2054F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 00:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DBD2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43GByd5t19zDr42
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 11:59:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43GBwQ4SsLzDr3k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 11:57:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43GBwQ2Q8Rz9s9G;
 Fri, 14 Dec 2018 11:57:26 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/mm: make NULL pointer deferences explicit on bad
 page faults.
In-Reply-To: <42e7e2e9b74af526523fb5a1451fdb29cfe2687a.1539060806.git.christophe.leroy@c-s.fr>
References: <42e7e2e9b74af526523fb5a1451fdb29cfe2687a.1539060806.git.christophe.leroy@c-s.fr>
Date: Fri, 14 Dec 2018 11:57:26 +1100
Message-ID: <87zht9udqh.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christophe,

You know it's the trivial patches that are going to get lots of review
comments :)

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> As several other arches including x86, this patch makes it explicit
> that a bad page fault is a NULL pointer dereference when the fault
> address is lower than PAGE_SIZE

I'm being pedantic, but it's not necessarily a NULL pointer dereference.
It might just be a direct access to a low address, eg:

 char *p = 0x100;
 *p = 0;

That's not a NULL pointer dereference.

But other arches do print this so I guess it's OK to add, and in most
cases it will be an actual NULL pointer dereference.

I wonder though if we should use 4096 rather than PAGE_SIZE, given
that's the actual value other arches are using. We support 256K pages on
some systems, which is getting quite large.

> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index d51cf5f4e45e..501a1eadb3e9 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -631,13 +631,16 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
>  	switch (TRAP(regs)) {
>  	case 0x300:
>  	case 0x380:
> -		printk(KERN_ALERT "Unable to handle kernel paging request for "
> -			"data at address 0x%08lx\n", regs->dar);
> +		pr_alert("Unable to handle kernel %s for data at address 0x%08lx\n",
> +			 regs->dar < PAGE_SIZE ? "NULL pointer dereference" :
> +						 "paging request",
> +			 regs->dar);

This is now too long I think, with printk time you get:

[ 1096.450711] Unable to handle kernel NULL pointer dereference for data at address 0x00000000

Which is 93 columns. It's true on many systems it doesn't really matter
any more, but it would still be good if it was shorter.

I like that on x86 they prefix it with "BUG:", just to avoid any confusion.

What if we had for the NULL pointer case:

  BUG: Kernel NULL pointer dereference at 0x00000000

And for the normal case:

  BUG: Unable to handle kernel data access at 0x00000000

Note on the very next line we print:
  Faulting instruction address: 0xc000000000795cc8

So there should be no confusion about whether "at" refers to the data
address or the instruction address.

>  	case 0x400:
>  	case 0x480:
> -		printk(KERN_ALERT "Unable to handle kernel paging request for "
> -			"instruction fetch\n");
> +		pr_alert("Unable to handle kernel %s for instruction fetch\n",
> +			 regs->nip < PAGE_SIZE ? "NULL pointer dereference" :
> +						 "paging request");

I don't really like using "NULL pointer dereference" here, that
terminology makes me think of a load/store, I think it confuses things
rather than making it clearer.

What about:

  BUG: Unable to handle kernel instruction fetch at 0x00000000


>  		break;
>  	case 0x600:
>  		printk(KERN_ALERT "Unable to handle kernel paging request for "

It would be good to clean up these other cases as well. They seem to be
trying to use the "page request for" terminology which leads to them
being very wordy. I assume that was done to help people grepping kernel
logs for errors, but I think we should not worry about that if we have
the "BUG:" prefix.

So we have:
	printk(KERN_ALERT "Unable to handle kernel paging request for "
		"unaligned access at address 0x%08lx\n", regs->dar);

What about:

  BUG: Unable to handle kernel unaligned access at 0x00000000

And:
	printk(KERN_ALERT "Unable to handle kernel paging request for "
		"unknown fault\n");

What about:

  BUG: Unable to handle unknown paging fault at 0x00000000


Thoughts?

cheers
