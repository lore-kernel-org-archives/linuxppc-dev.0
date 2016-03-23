Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qVHs43CLTzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Mar 2016 16:18:15 +1100 (AEDT)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 22 Mar 2016 23:18:13 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C7A6C3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 23:18:11 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u2N5IBCG37486670
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 22:18:11 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2N5IAir010742
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 23:18:11 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Samuel Mendoza-Jonas <sam@mendozajonas.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] tty/hvc: Use IRQF_SHARED for hvc consoles
In-Reply-To: <1458262483-15149-1-git-send-email-sam@mendozajonas.com>
References: <1458262483-15149-1-git-send-email-sam@mendozajonas.com>
Date: Wed, 23 Mar 2016 16:17:56 +1100
Message-ID: <87twjxydq3.fsf@birb.au.ibm.com>
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

Samuel Mendoza-Jonas <sam@mendozajonas.com> writes:
> Commit 2def86a7200c
> ("hvc: Convert to using interrupts instead of opal events")
> enabled the use of interrupts in the hvc_driver for OPAL platforms.
> However on machines with more than one hvc console, any console after
> the first will fail to register an interrupt handler in
> notifier_add_irq() since all consoles share the same IRQ number but do
> not set the IRQF_SHARED flag:
>
> [   51.179907] genirq: Flags mismatch irq 31. 00000000 (hvc_console) vs.
> 00000000 (hvc_console)
> [   51.180010] hvc_open: request_irq failed with rc -16.
>
> This error propagates up to hvc_open() and the console is closed, but
> OPAL will still generate interrupts that are not handled, leading to
> rcu_sched stall warnings.
>
> Set IRQF_SHARED when calling request_irq, allowing additional consoles
> to start properly.
>
> Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Cc: <stable@vger.kernel.org> # 4.1.x-

Tested on 4.4.6 - seemed to stop (some of) the problems I was having
when using it as a kernel for the bootloader on a FSP based POWER8
system.

Tested-by: Stewart Smith <stewart@linux.vnet.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
