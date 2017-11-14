Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yblFs6NkzzDqpF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Nov 2017 22:12:01 +1100 (AEDT)
In-Reply-To: <20170831162557.24904-1-naveen.n.rao@linux.vnet.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Richard Weinberger <richard@nod.at>, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: powerpc/signal: Properly handle return value from
 uprobe_deny_signal()
Message-Id: <3yblFs36rqz9t1t@ozlabs.org>
Date: Tue, 14 Nov 2017 22:12:01 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-08-31 at 16:25:57 UTC, "Naveen N. Rao" wrote:
> When a uprobe is installed on an instruction that we currently do not
> emulate, we copy the instruction into a xol buffer and single step
> that instruction. If that instruction generates a fault, we abort the
> single stepping before invoking the signal handler. Once the signal
> handler is done, the uprobe trap is hit again since the instruction is
> retried and the process repeats.
> 
> We use uprobe_deny_signal() to detect if the xol instruction triggered
> a signal. If so, we clear TIF_SIGPENDING and set TIF_UPROBE so that the
> signal is not handled until after the single stepping is aborted. In
> this case, uprobe_deny_signal() returns true and get_signal() ends up
> returning 0. However, in do_signal(), we are not looking at the return
> value, but depending on ksig.sig for further action, all with an
> uninitialized ksig that is not touched in this scenario. Fix the same
> by initializing ksig.sig to 0.
> 
> Fixes: 129b69df9c907 ("powerpc: Use get_signal() signal_setup_done()")
> 
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/46725b17f1c6c815a41429259b3f07

cheers
