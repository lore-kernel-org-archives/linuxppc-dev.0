Return-Path: <danielhb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhgbC0qwDzDqF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 06:43:50 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7TKhm5K141158
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:43:48 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cna46gm16-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:43:47 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <danielhb@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 14:43:40 -0600
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7TKhdox4784390
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 13:43:39 -0700
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0203CBE03A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 14:43:39 -0600 (MDT)
Received: from [9.18.235.124] (unknown [9.18.235.124])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP id 85E66BE03E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 14:43:38 -0600 (MDT)
To: linuxppc-dev@lists.ozlabs.org
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Subject: Question: handling early hotplug interrupts
Date: Tue, 29 Aug 2017 17:43:37 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <e5975dfb-6609-a3b1-7ea7-b9e8fe31b669@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This is a scenario I've been facing when working in early device 
hotplugs in QEMU. When a device is added, a IRQ pulse is fired to warn 
the guest of the event, then the kernel fetches it by calling 
'check_exception' and handles it. If the hotplug is done too early 
(before SLOF, for example), the pulse is ignored and the hotplug event 
is left unchecked in the events queue.

One solution would be to pulse the hotplug queue interrupt after CAS, 
when we are sure that the hotplug queue is negotiated. However, this 
panics the kernel with sig 11 kernel access of bad area, which suggests 
that the kernel wasn't quite ready to handle it.

In my experiments using upstream 4.13 I saw that there is a 'safe time' 
to pulse the queue, sometime after CAS and before mounting the root fs, 
but I wasn't able to pinpoint it. From QEMU perspective, the last hcall 
done (an h_set_mode) is still too early to pulse it and the kernel 
panics. Looking at the kernel source I saw that the IRQ handling is 
initiated quite early in the init process.

So my question (ok, actually 2 questions):

- Is my analysis correct? Is there an unsafe time to fire a IRQ pulse 
before CAS that can break the kernel or am I overlooking/doing something 
wrong?
- is there a reliable way to know when can the kernel safely handle the 
hotplug interrupt?


Thanks,


Daniel
