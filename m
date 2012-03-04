Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 587F0B6EEC
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Mar 2012 10:11:16 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q24NBBAW026568
 for <linuxppc-dev@ozlabs.org>; Sun, 4 Mar 2012 17:11:12 -0600
Message-ID: <1330902669.11728.84.camel@pasglop>
Subject: Re: [PATCH 12/12] powerpc: Rework lazy-interrupt handling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Mon, 05 Mar 2012 10:11:09 +1100
In-Reply-To: <1330680922-6894-13-git-send-email-benh@kernel.crashing.org>
References: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
 <1330680922-6894-13-git-send-email-benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-03-02 at 20:35 +1100, Benjamin Herrenschmidt wrote:
>  
> +static inline may_hard_irq_enable(void) { }
> + 

And that works much better with a void :

+static inline void may_hard_irq_enable(void) { }

Or 32-bit won't build ;-) With that fix it builds on both 32 and 64-bit,
now time to test !

Cheers,
Ben.
