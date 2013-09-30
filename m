Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp03.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D51E2C00CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 01:53:22 +1000 (EST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Sep 2013 21:23:17 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 3EA53E0053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 21:24:23 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8UFrA2D34472066
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 21:23:10 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8UFrCgv019372
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 21:23:12 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [RFC PATCH 07/11] kvm: powerpc: book3s: pr: move PR related
 tracepoints to a separate header
In-Reply-To: <52499003.1090405@suse.de>
References: <1380276233-17095-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1380276233-17095-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <C02177CF-C8A0-4E84-82FE-1994742B8EBD@suse.de>
 <87wqm29zxk.fsf@linux.vnet.ibm.com>
 <BAB3B542-A47C-49A8-B2D5-26C461A4E12D@suse.de>
 <87mwmubh70.fsf@linux.vnet.ibm.com> <52499003.1090405@suse.de>
Date: Mon, 30 Sep 2013 21:23:11 +0530
Message-ID: <87bo3ab920.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> writes:

> On 09/30/2013 02:57 PM, Aneesh Kumar K.V wrote:
>> Alexander Graf<agraf@suse.de>  writes:
>>>>>> diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
>>>>>> index a088e9a..7d5a136 100644
>>>>>> --- a/arch/powerpc/kvm/trace.h
>>>>>> +++ b/arch/powerpc/kvm/trace.h
>>>>>> @@ -85,6 +85,12 @@ TRACE_EVENT(kvm_ppc_instr,
>>>>>> 	{41, "HV_PRIV"}
>>>>>> #endif
>>>>>>
>>>>>> +#ifndef CONFIG_KVM_BOOK3S_PR
>>>>>> +/*
>>>>>> + * For pr we define this in trace_pr.h since it pr can be built as
>>>>>> + * a module
>>>>> Not sure I understand the need. If the config option is available, so
>>>>> should the struct field. Worst case that happens with HV is that we
>>>>> get empty shadow_srr1 values in our trace, no?
>>>> That is not the real reason. trace.h get built as part of kvm.ko or as
>>>> part of kernel. These trace functions actually get called from
>>>> kvm-pr.ko. To make they build i would either need EXPORT_SYMBOL or move
>>>> the definition of them to kvm-pr.ko. I did the later and moved only pr
>>>> related traces to kvm-pr.ko
>>> I fail to see why we wouldn't have a trace_hv.h file then, as that can
>>> also be built as a module, no? And at that point I don't see why we
>>> would need any conditionals at all in trace.h anymore, as it would
>>> only cover generic code.
>> Currently HV module is not using any tracepoints. Once it start using
>> tracepoints we would have trace_hv.h
>
> So why would there be an #ifndef in trace.h?
>

to handle things like trace_kvm_exit in booke.c. For that we still don't
have kernel module, and booke.c include trace.h.

-aneesh
