Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0141.outbound.protection.outlook.com [207.46.163.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 673072C00CF
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2014 11:27:05 +1100 (EST)
Message-ID: <1394755900.12479.26.camel@snotra.buserror.net>
Subject: Re: how do I increase default kernel stack size for my MPC8548 board?
From: Scott Wood <scottwood@freescale.com>
To: perth1415 <saikia.partha@gmail.com>
Date: Thu, 13 Mar 2014 19:11:40 -0500
In-Reply-To: <1394547564081-80712.post@n7.nabble.com>
References: <r2u389deec71004291743ra5fe0d49yaf317b5c5aaea6b7@mail.gmail.com>
 <1394541351657-80711.post@n7.nabble.com>
 <1394547564081-80712.post@n7.nabble.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-03-11 at 07:19 -0700, perth1415 wrote:
> Looks like I found the issue :-) The stack size for init task needs to be
> updated too. Right now it's by default set to 8K for PPC32.
> 
> In arch/powerpc/kernel/vmlinux.lds.S -
> ===
>     /* The initial task and kernel stack */
> #ifdef CONFIG_PPC32
>     . = ALIGN(8192);
> #else
>     . = ALIGN(16384);
> #endif
> ===
> 
> Problem is, how do we link this to THREAD_SHIFT?

Have you tried:

	. = ALIGN(THREAD_SIZE)

?

Or just use a newer kernel, where this is already done. :-)

-Scott
