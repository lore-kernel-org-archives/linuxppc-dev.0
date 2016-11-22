Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNNds1gCPzDvs4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 22:33:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
 peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, naveen.n.rao@linux.vnet.ibm.com,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/xmon: Fix data-breakpoint
In-Reply-To: <1479806759-5409-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1479806759-5409-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Date: Tue, 22 Nov 2016 22:33:51 +1100
Message-ID: <87eg23vjds.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> writes:

> Xmon data-breakpoint feature is broken.
>
> Whenever there is a watchpoint match occurs, hw_breakpoint_handler will
> be called by do_break via notifier chains mechanism. If watchpoint is
> registered by xmon, hw_breakpoint_handler won't find any associated
> perf_event and returns immediately with NOTIFY_STOP. Similarly, do_break
> also returns without notifying to xmon.
>
> Solve this by returning NOTIFY_DONE when hw_breakpoint_handler does not
> find any perf_event associated with matched watchpoint.

.. rather than NOTIFY_STOP, which tells the core code to continue
calling the other breakpoint handlers including the xmon one.

Right?

Also any idea when we broke this?

cheers
