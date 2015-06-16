Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2FFF01A0431
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 13:29:06 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Tue, 16 Jun 2015 13:29:04 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C2BE23578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 13:29:00 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5G3SqTc63766678
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 13:29:00 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5G3SROL015623
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jun 2015 13:28:28 +1000
Message-ID: <557F97C7.1090100@linux.vnet.ibm.com>
Date: Tue, 16 Jun 2015 08:58:07 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mingo@kernel.org, mpe@ellerman.id.au,
 sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 warrier@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 scottwood@freescale.com
Subject: Re: [PATCH RESEND v4 1/3] kvm/powerpc: Export kvm exit reasons
References: <1434344169-32438-1-git-send-email-hemant@linux.vnet.ibm.com>
 <20150615053943.GB15637@pale.ozlabs.ibm.com>
In-Reply-To: <20150615053943.GB15637@pale.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

On 06/15/2015 11:09 AM, Paul Mackerras wrote:
> On Mon, Jun 15, 2015 at 10:26:07AM +0530, Hemant Kumar wrote:
>> To analyze the kvm exits with perf, we will need to map the exit codes
>> with the exit reasons. Such a mapping exists today in trace_book3s.h.
>> Currently its not exported to perf.
>>
>> This patch moves these kvm exit reasons and their mapping from
>> "arch/powerpc/kvm/trace_book3s.h" to
>> "arch/powerpc/include/uapi/asm/trace_book3s.h".
>> Accordingly change the include files in "trace_hv.h" and "trace_pr.h".
> These are not really exit reasons so much as Power ISA interrupt
> vectors, defined externally to the kernel (in the Power ISA document)
> and not subject to change (at least, kernel developers can't change
> them).  So I don't see why this needs to be "exported" from the
> kernel.
>
> Paul.
>

The exit reasons are needed in the perf userspace and we wanted to avoid
code duplication, so, if there are any changes, we won't need to update them
at both places.
However, we could add them to perf userspace itself separately and let perf
userspace use those.

What would you suggest?

-- 
Thanks,
Hemant Kumar
