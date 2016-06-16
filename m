Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVvJN6mx8zDqlS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 05:55:48 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5GJs14M101819
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 15:55:46 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23kr61tgfw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 15:55:46 -0400
Received: from localhost
 by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 16 Jun 2016 16:55:44 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 69D3E3520068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 15:55:24 -0400 (EDT)
Received: from d24av02.br.ibm.com (d24av02.br.ibm.com [9.8.31.93])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5GJteLt26411484
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 16:55:40 -0300
Received: from d24av02.br.ibm.com (localhost [127.0.0.1])
 by d24av02.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5GJtdGs028075
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 16:55:40 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] kexec_file_load implementation for PowerPC
Date: Thu, 16 Jun 2016 16:55:33 -0300
In-Reply-To: <1466056110.5400.8.camel@ellerman.id.au>
References: <1465916349-3398-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1466056110.5400.8.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <17475630.nMjKSPkg4b@hactar>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, 16 Juni 2016, 15:48:30 schrieb Michael Ellerman:
> On Tue, 2016-06-14 at 11:59 -0300, Thiago Jung Bauermann wrote:
> > Hello,
> > 
> > This patch series implements the kexec_file_load system call on PowerPC.
> 
> Can you tell me what this syscall does and why I would want it?

Sorry, should have provided the motivation when I posted the patches.

This system call moves the reading of the kernel, initrd and the device tree 
from the userspace kexec tool to the kernel. This is needed if you want to 
do one or both of the following:

1. only allow loading of signed kernels.
2. "measure" (i.e., record the hashes of) the kernel, initrd, kernel command 
line and other boot inputs for the  Integrity Measurement Architecture 
subsystem.

The above are the functions kexec already has built into kexec_file_load. I 
will soon post a set of patches which will allow a third feature:

3. have IMA pass-on its event log (where integrity measurements are 
registered) accross kexec to the second kernel, so that the event history is 
preserved.

Because OpenPower uses an intermediary Linux instance as a boot loader 
(skiroot), feature 1 is needed to implement secure boot for the platform, 
while features 2 and 3 are needed to implement trusted boot.

There's an LWN article giving more context on the origins of the system 
call, if you are interested:

https://lwn.net/Articles/603116/

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
