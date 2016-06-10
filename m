Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rQswW0GL2zDqPC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 16:39:38 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5A6caSg018143
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 02:39:35 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23f9vdhwvf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 02:39:35 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 10 Jun 2016 16:39:32 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D9F6A3578066
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 16:39:23 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5A6dCwR3866942
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 16:39:12 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5A6d7ik027282
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jun 2016 16:39:07 +1000
Date: Fri, 10 Jun 2016 16:37:58 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 alistair@popple.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v10 09/18] powerpc/powernv: Extend PCI bridge resources
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1463726502-14679-10-git-send-email-gwshan@linux.vnet.ibm.com>
 <9bd72b5a-c4c5-9ab7-7c82-cb4d7e8d51fd@ozlabs.ru>
 <20160610043349.GA17817@gwshan>
 <fb22a56a-92fe-b12b-2f79-dc77e26fcc09@ozlabs.ru>
 <1465537530.2948.51.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1465537530.2948.51.camel@kernel.crashing.org>
Message-Id: <20160610063758.GA6836@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 10, 2016 at 03:45:30PM +1000, Benjamin Herrenschmidt wrote:
>On Fri, 2016-06-10 at 15:28 +1000, Alexey Kardashevskiy wrote:
>> > Actually, it's likely caused by hardware defect
>> > - we can't set 2GB (0x80000000 - 0xffffffff) to RC's memory window.
>> > Otherwise, it *seems* the window is disabled. I tried updating the
>> > window with (0x80000000 - 0xffefffff) or (0x80000000 - 0xffdffff), no
>> > EEH error was seen. I already got 0x00001000 on read despite whatever
>> > I wrote to 0x20 reg.
>> > 
>> > The hardware is broken. In order to fix this, I intend to include a
>> > bitmap for every PHB device node in skiboot. Kernel uses this to apply
>> > fixup accordingly. One bit is reserved on Garrison platform to avoid
>> > this issue. The fix can be a patch inserted before this patch in next
>> > revision
>> 
>> This sounds better as preserves bisectability. Thanks.
>
>Ah yes they made those registers read-only. Look at my PHB4 code, I
>implement a cache for them in SW.
>

Ben, thanks for your confirm. Could you please share the link to
your PHB4 code? I think writing to SW cache, not going to hardware
will fix the issue.

Currently, skiboot supports emulated config regiters with help of
(struct pci_cfg_reg_filter) that was introduced for CAPI M64 BAR
issue on Garrison platform. Potentially, I can have similar thing
for 0x20 (memory window) to avoid writing to the register. However,
I need take a look on your PHB4 code to see if there is anything I
can lend. Otherwise, I will reuse the struct pci_cfg_reg_filter.
At same time, I guess the bitmap (mentioned as above) is still
needed to ensure (new kernel + old skiboot) works well, but it
depends on how much Garrison boxes have been deployed.

>Cheers,
>Ben.
>

Thanks,
Gavin

>_______________________________________________
>Linuxppc-dev mailing list
>Linuxppc-dev@lists.ozlabs.org
>https://lists.ozlabs.org/listinfo/linuxppc-dev
