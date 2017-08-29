Return-Path: <benh@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhj9W0kPpzDqF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 07:55:10 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7TLn8ok017541
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:55:08 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cnge68b2v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 17:55:07 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <benh@au1.ibm.com>;
 Wed, 30 Aug 2017 07:55:04 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7TLt1jW35193050
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 07:55:01 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7TLt1aB001895
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 07:55:01 +1000
Subject: Re: Question: handling early hotplug interrupts
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
Date: Wed, 30 Aug 2017 07:55:00 +1000
In-Reply-To: <e5975dfb-6609-a3b1-7ea7-b9e8fe31b669@linux.vnet.ibm.com>
References: <e5975dfb-6609-a3b1-7ea7-b9e8fe31b669@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1504043700.2358.37.camel@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-08-29 at 17:43 -0300, Daniel Henrique Barboza wrote:
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

That's not right. This is a bug that needs fixing. The interrupt should
be masked anyway but still.

Tell us more about the crash (backtrace etc...)  this definitely needs
fixing.

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

So I don't think that's the right approach. Virtual interrutps are edge
sensitive and we will potentially lose them if they occur early. I
think what needs to happen is:

 - Fix whatever's causing the above crash

and

 - The hotplug code should check for pending events (check_exception ?)
at boot time to enqueue whatever's there. It needs to do that after
unmasking the interrupt and in a way that is protected from races with
said interrupt.

Cheers,
Ben.
 

> 
> Thanks,
> 
> 
> Daniel
