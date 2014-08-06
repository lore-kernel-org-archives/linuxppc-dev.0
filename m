Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F08621A013E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 20:38:14 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 6 Aug 2014 16:08:10 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id CCC13125801E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 16:08:11 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s76AcT0O61604054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 16:08:29 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s76Ac7at002658
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Aug 2014 16:08:07 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc: subpage_protect: Increase the array size to take
 care of 64TB
In-Reply-To: <1405435950-24187-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1405435950-24187-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 06 Aug 2014 16:08:06 +0530
Message-ID: <87y4v1dhtd.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> We now support TASK_SIZE of 16TB, hence the array should be 8.
>
> Fixes the below crash:
>
> Unable to handle kernel paging request for data at address 0x000100bd
> Faulting instruction address: 0xc00000000004f914
> cpu 0x13: Vector: 300 (Data Access) at [c000000fea75fa90]
>     pc: c00000000004f914: .sys_subpage_prot+0x2d4/0x5c0
>     lr: c00000000004fb5c: .sys_subpage_prot+0x51c/0x5c0
>     sp: c000000fea75fd10
>    msr: 9000000000009032
>    dar: 100bd
>  dsisr: 40000000
>   current = 0xc000000fea6ae490
>   paca    = 0xc00000000fb8ab00   softe: 0        irq_happened: 0x00
>     pid   = 8237, comm = a.out
> enter ? for help
> [c000000fea75fe30] c00000000000a164 syscall_exit+0x0/0x98
> --- Exception: c00 (System Call) at 00003fff89737004
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

This should go to stable also. Merged upstream as
dad6f37c2602e4af6c3aecfdb41f2d8bd4668163. Let me know how it should be
handled.

-aneesh
