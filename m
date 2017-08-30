Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhvwV0N0zzDqK8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 15:59:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: Question: handling early hotplug interrupts
In-Reply-To: <e5975dfb-6609-a3b1-7ea7-b9e8fe31b669@linux.vnet.ibm.com>
References: <e5975dfb-6609-a3b1-7ea7-b9e8fe31b669@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 15:59:30 +1000
Message-ID: <8760d538al.fsf@concordia.ellerman.id.au>
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

Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com> writes:

> Hi,
>
> This is a scenario I've been facing when working in early device 
> hotplugs in QEMU. When a device is added, a IRQ pulse is fired to warn 
> the guest of the event, then the kernel fetches it by calling 
> 'check_exception' and handles it. If the hotplug is done too early 
> (before SLOF, for example), the pulse is ignored and the hotplug event 
> is left unchecked in the events queue.
>
> One solution would be to pulse the hotplug queue interrupt after CAS, 
> when we are sure that the hotplug queue is negotiated. However, this 
> panics the kernel with sig 11 kernel access of bad area, which suggests 
> that the kernel wasn't quite ready to handle it.
>
> In my experiments using upstream 4.13 I saw that there is a 'safe time' 
> to pulse the queue, sometime after CAS and before mounting the root fs, 
> but I wasn't able to pinpoint it. From QEMU perspective, the last hcall 
> done (an h_set_mode) is still too early to pulse it and the kernel 
> panics. Looking at the kernel source I saw that the IRQ handling is 
> initiated quite early in the init process.
>
> So my question (ok, actually 2 questions):
>
> - Is my analysis correct? Is there an unsafe time to fire a IRQ pulse 
> before CAS that can break the kernel or am I overlooking/doing something 
> wrong?
> - is there a reliable way to know when can the kernel safely handle the 
> hotplug interrupt?

In addition to Ben's comments, you need to think about this differently.

The operating system you're booting may not be Linux.

Whatever Qemu does needs to make sense without reference to the exact
details or ordering of the Linux code. Qemu needs to provide a mechanism
that any operating system could use, and then we can make it work with
Linux.

cheers
