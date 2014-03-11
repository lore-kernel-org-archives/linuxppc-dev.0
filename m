Return-Path: <saikia.partha@gmail.com>
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 11DA72C00A3
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2014 01:19:27 +1100 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <saikia.partha@gmail.com>) id 1WNNWe-0001oU-NA
 for linuxppc-dev@ozlabs.org; Tue, 11 Mar 2014 07:19:24 -0700
Date: Tue, 11 Mar 2014 07:19:24 -0700 (PDT)
From: perth1415 <saikia.partha@gmail.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1394547564081-80712.post@n7.nabble.com>
In-Reply-To: <1394541351657-80711.post@n7.nabble.com>
References: <r2u389deec71004291743ra5fe0d49yaf317b5c5aaea6b7@mail.gmail.com>
 <1394541351657-80711.post@n7.nabble.com>
Subject: Re: how do I increase default kernel stack size for my MPC8548 board?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Looks like I found the issue :-) The stack size for init task needs to be
updated too. Right now it's by default set to 8K for PPC32.

In arch/powerpc/kernel/vmlinux.lds.S -
===
    /* The initial task and kernel stack */
#ifdef CONFIG_PPC32
    . = ALIGN(8192);
#else
    . = ALIGN(16384);
#endif
===

Problem is, how do we link this to THREAD_SHIFT?

Thanks,
Partha



--
View this message in context: http://linuxppc.10917.n7.nabble.com/how-do-I-increase-default-kernel-stack-size-for-my-MPC8548-board-tp52842p80712.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
