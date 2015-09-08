Return-Path: <hemant@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 02D731A0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 14:56:59 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <hemant@linux.vnet.ibm.com>;
 Tue, 8 Sep 2015 14:56:57 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 768D62BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Sep 2015 14:56:53 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t884ugsq21561552
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Sep 2015 14:56:50 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t884uK4I007938
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Sep 2015 14:56:21 +1000
Message-ID: <55EE6A61.3010301@linux.vnet.ibm.com>
Date: Tue, 08 Sep 2015 10:26:01 +0530
From: Hemant Kumar <hemant@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Yarygin <yarygin@linux.vnet.ibm.com>
CC: maddy@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com,
 linux-kernel@vger.kernel.org, warrier@linux.vnet.ibm.com,
 paulus@samba.org, scottwood@freescale.com, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Subject: Re: [PATCH v6 1/2] perf,kvm/powerpc: Add kvm_perf.h for powerpc
References: <1441003681-10259-1-git-send-email-hemant@linux.vnet.ibm.com>
 <20150831201300.GG4423@kernel.org> <55E54A4F.6090205@linux.vnet.ibm.com>
 <20150904205145.GB3475@kernel.org> <1441602655.12945.5.camel@ellerman.id.au>
In-Reply-To: <1441602655.12945.5.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/07/2015 10:40 AM, Michael Ellerman wrote:
> On Fri, 2015-09-04 at 17:51 -0300, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Sep 01, 2015 at 12:18:47PM +0530, Hemant Kumar escreveu:
>>>> Should I try to process the 5 together, applying thest two first?
>>   
>>> Yes, this patchset needs to be applied before applying the other patchset,
>>> since there is a direct dependency on these two for the tooling part to
>>> work.
>>   
>>>> I see there are no acks from powerpc arch maintainers, how should we
>>>> proceed here? If there are no problems with the arch bits, and if it is
>>>> just to enable the tooling part, again, should I process the 5 as just
>>>> one series?
>>   
>>> The reason to split the earlier patchset into two was to separate the
>>> tooling/perf/ and arch/powerpc/ side patches, as asked by Michael..
>>   
>>> Here is the link to that discussion :
>>> http://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg86916.html
>>   
>>> If Michael is ok with the patches, you can process all the 5 patches
>>> together. Michael?
>> Michael?
> I'm not particularly happy with it.
>
> Can we at least remove this hunk from the uapi header:
>
> +/* This is to shut the compiler up */
> +#define KVM_ENTRY_TRACE ""
> +#define KVM_EXIT_TRACE ""
> +#define KVM_EXIT_REASON ""
>

Agreed, I didn't like this too, but I kept this because of the generic
perf userspace code that looks for KVM_{ENTRY,EXIT}_TRACE and
KVM_EXIT_REASON. We can remove this and put this hunk in the
userspace side.

Arnaldo,
Can we remove the dependency on uapi altogether (also suggested
by Scott) because it doesn't seem to fulfill much purpose? Rather,
hardcode the events in the userspace completely (since, tracepoint
event names are unlikely to change) ? Some of what is being done
by x86 already in kvm-stat.c where its defining kvm_events_tp[] and
its not using the macros, rather, the tracepoints directly. Macros are
only being used in builtin-kvm.c where the tracepoint names are
matched with KVM_{ENTRY,EXIT}_TRACE and when we are looking
for the key KVM_EXIT_REASON.

-- 
Thanks,
Hemant Kumar
