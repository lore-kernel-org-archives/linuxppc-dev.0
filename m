Return-Path: <srs0=vg/h=77=linux.vnet.ibm.com=gpiccoli@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhTNZ4vmKzDqgj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 23:03:58 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xhTNX6mkGz8tjh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 23:03:56 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xhTNF0nsYz9t1t
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 23:03:40 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7TCxEwD124862
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 09:03:29 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cn6sc0mys-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 29 Aug 2017 09:03:29 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Tue, 29 Aug 2017 07:03:28 -0600
Subject: Re: [PATCH] powerpc/powernv: Turn on SCSI_AACRAID in powernv_defconfig
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, Brian King <brking@linux.vnet.ibm.com>,
 "dougmill@us.ibm.com" <dougmill@us.ibm.com>
References: <1503899802-13248-1-git-send-email-mpe@ellerman.id.au>
 <72f7e609-58b9-32dc-4090-fdbd97d0c924@linux.vnet.ibm.com>
 <87h8wq1uvv.fsf@concordia.ellerman.id.au>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 10:03:24 -0300
MIME-Version: 1.0
In-Reply-To: <87h8wq1uvv.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Message-Id: <58487ce7-aea1-39c1-b9c8-cd8435e493e0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/29/2017 08:22 AM, Michael Ellerman wrote:
> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
> 
>> On 08/28/2017 02:56 AM, Michael Ellerman wrote:
>>> Some Power9 boxes will have this adapter installed, so add it to the
>>> defconfig so we can boot on those machines without an initrd.
>>
>> Michael, not sure if this affects Petitboot (I know it has its own
>> default config files), but in the past we had some issues with this
>> driver and it's nice to have the possibility to blacklist it.
> 
> Why we were black listing it?

Basically for the same reason you want it built-in - debug purposes heheh

In fact, this driver takes some time in its initialization process, so
if my rootfs is not under it, to speedup my boot-time I could blacklist
it; also, to debug the aacraid driver we could blacklist it in Petitboot
and debug on distro (easier to build kernels there), since the issue
could be in first probe only (or be affected by kexec-out from Petitboot).

Anyway, since make it a module will harm your workflow, I agree built-in
is the best option!

Thanks for your detailed explanation.
Cheers,


Guilherme


> 
>> What is the rationale for this change? I mean, how being able to boot
>> without initrd is interesting here? Sorry if it's silly question!
> 
> It is a silly question! :)
> 
> When you boot as many kernels as me it's preferable to be able to build
> a kernel completely remote from the box, throw the kernel on a tftp
> server and have the machine boot from that kernel all the way to
> userspace.
> 
> That requires not using an initrd, and therefore having all the drivers
> built-in that are needed to get to the boot disk.
> 
> (Yeah it is "possible" to build an initrd remotely but it's a pain).
> 
> And the one P9 box I have here uses that driver for its root disk, so I
> do really want it to be =y.
> 
> cheers
> 
