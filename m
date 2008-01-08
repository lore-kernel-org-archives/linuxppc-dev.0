Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8D6E5DDF2F
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 17:28:11 +1100 (EST)
Message-Id: <7040EDB2-7E89-4BBD-A4FC-50E168F9286F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <11996295742378-git-send-email-Yu.Liu@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] Fix carry bug in 128-bit unsigned integer adding
Date: Tue, 8 Jan 2008 00:27:59 -0600
References: <11996295742378-git-send-email-Yu.Liu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 6, 2008, at 8:26 AM, Liu Yu wrote:

> This bug exists in math emulation for powerpc.
> The macro define are mainly used by multiplication.
>
> When adding two unsigned operands ( r = x + y ),
> the carry bit can be counted by whether r is less than x.
> However, when adding three unsigned operands, this method does not  
> work.
>
> The original code below uses this method to count carry,
> it apparently overlook the case of three operands.
> Assume all the operands is 32-bit wide,
> ( r = x + y + last_carry , x = 0, y = 0xffffffff, last_carry = 1),
> then r is no less than x but it actually gets a carry.
>
> I tried to fix this bug, but this patch seems not that pretty.
> Are there any better ideas?
> Comments are always welcomed!

take a look at how include/math-emu/op-4.h implements __FP_FRAC_ADD_4  
& __FP_FRAC_SUB_4.  Will that fix the bug, if so we should make the  
code match how its done there.

- k
