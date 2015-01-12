Return-Path: <pc@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B4EFF1A0283
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jan 2015 04:27:43 +1100 (AEDT)
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E3E041401F0
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2015 04:27:42 +1100 (AEDT)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <pc@us.ibm.com>;
 Mon, 12 Jan 2015 12:27:39 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id DFDAF6E8046
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2015 12:19:27 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0CHRXkT27328548
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2015 17:27:34 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0CHRXrS007157
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2015 12:27:33 -0500
Message-ID: <54B40403.1000202@us.ibm.com>
Date: Mon, 12 Jan 2015 11:27:31 -0600
From: Paul Clarke <pc@us.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Reword the "returning from prom_init" message
References: <1421056096-20043-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1421056096-20043-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/12/2015 03:48 AM, Michael Ellerman wrote:
> We get way too many bug reports that say "the kernel is hung in
> prom_init", which stems from the fact that the last piece of output
> people see is "returning from prom_init".
>
> The kernel is almost never hung in prom_init(), it's just that it's
> crashed somewhere after prom_init() but prior to the console coming up.
>
> The existing message should give a clue to that, ie. "returning from"
> indicates that prom_init() has finished, but it doesn't seem to work.
> Let's try something different.
>
> This prints:
>
>    Calling quiesce...
>    Shutting down Open Firmware, booting Linux via __start() ...
>
> Which hopefully makes it clear that prom_init() is not the problem, and
> although __start() probably isn't either, it's at least the right place
> to begin looking.

I'm very much in favor of anything that increases usability or decreases 
confusion.

I worry about confusion caused by any phrase that begins "Shutting 
down.."  Even if accurate, I wonder if something more positive that 
indicates that, at least at this point, things are continuing to proceed 
along would be preferred.

Perhaps something like "Transferring control from Open Firmware to 
kernel (via __start) ...".

(Do we know for certain that what is about to be invoked is "Linux" 
per-se, or can it be something else that has a "__start"?)

PC
