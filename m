Return-Path: <ananth@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2GfB1NkKzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 16:01:53 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3B5wnuC023005
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 02:01:51 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29rmq6u274-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 02:01:51 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 00:01:50 -0600
Date: Tue, 11 Apr 2017 11:31:43 +0530
From: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, chris@distroguy.com, npiggin@gmail.com,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] ppc64/kprobe: Fix oops when kprobed on 'stdu'
 instruction
Reply-To: ananth@linux.vnet.ibm.com
References: <1491887293-3815-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1491887293-3815-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Message-Id: <20170411060143.GC5926@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 11, 2017 at 10:38:13AM +0530, Ravi Bangoria wrote:
> If we set a kprobe on a 'stdu' instruction on powerpc64, we see a kernel 
> OOPS:
> 
>   [ 1275.165932] Bad kernel stack pointer cd93c840 at c000000000009868
>   [ 1275.166378] Oops: Bad kernel stack pointer, sig: 6 [#1]
>   ...
>   GPR00: c000001fcd93cb30 00000000cd93c840 c0000000015c5e00 00000000cd93c840
>   ...
>   [ 1275.178305] NIP [c000000000009868] resume_kernel+0x2c/0x58
>   [ 1275.178594] LR [c000000000006208] program_check_common+0x108/0x180
> 
> Basically, on 64 bit system, when user probes on 'stdu' instruction,
> kernel does not emulate actual store in emulate_step itself because it
> may corrupt exception frame. So kernel does actual store operation in
> exception return code i.e. resume_kernel().
> 
> resume_kernel() loads the saved stack pointer from memory using lwz,
> effectively loading a corrupt (32bit) address, causing the kernel crash.
> 
> Fix this by loading the 64bit value instead.
> 
> Fixes: be96f63375a1 ("powerpc: Split out instruction analysis part of emulate_step()") 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Reviewed-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com> 

Reviewed-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
