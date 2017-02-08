Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJNv54SbXzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Feb 2017 01:31:45 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v18EO5mK039010
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 09:31:43 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28g3w7uf1u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Feb 2017 09:31:42 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 8 Feb 2017 20:01:38 +0530
Received: from d28relay07.in.ibm.com (d28relay07.in.ibm.com [9.184.220.158])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 854B4E005E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 20:03:02 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay07.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v18EUbrp22151244
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 20:00:37 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v18EVY8M009956
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Feb 2017 20:01:35 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 frederic.barrat@fr.ibm.com, stable@vger.kernel.org,
 Ian Munsie <ianmunsi@au1.ibm.com>, Andrew Donnellan <andonnel@au1.ibm.com>,
 Gregory Kurz <KURZGREG@fr.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH] cxl: Force context lock during EEH flow
In-Reply-To: <d7499436-f25c-fac8-8908-c622a24d85f1@linux.vnet.ibm.com>
References: <20170203065739.3052-1-vaibhav@linux.vnet.ibm.com>
 <d7499436-f25c-fac8-8908-c622a24d85f1@linux.vnet.ibm.com>
Date: Wed, 08 Feb 2017 20:01:32 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zihwpxdn.fsf@vajain21.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

>>
>> +	/* forcibly take the context lock to prevent new context activation */
>> +	cxl_adapter_context_force_lock(adapter);
>> +
>
> I'm not a fan of the "force lock" call and I'm not convinced it's 
> needed. When an EEH is triggered, we'll force-detach all the contexts. 
> So that in itself should bring the counter of active contexts to 0. So 
> why not just add a cxl_adapter_context_lock() call at the end of 
> cxl_pci_error_detected()? The lock would be released in 
> cxl_configure_adapter when cxl_pci_slot_reset() is called, as is already 
> the case with the current code.
> (as a side note, I don't believe the code is racy and that we need to 
> add extra protection to avoid context activation while 
> cxl_pci_error_detected() is called. We can talk about it if needed)

Hi Fred,

Thanks for reviewing the patch.

Function cxl_adapter_context_force_lock is introduced to handle cases
where in we don't want any new contexts to be activated while we go ahead
and detach all the currently activated contexts. This usually is the
case in error paths when we are performing cleanups of existing contexts
(control flows with cxl_context_detach_all).

This is in contrast with cxl_adapter_context_lock which need to wait for
all the active contexts to be detached and during the wait other
contexts can be activated. The _force_lock variant provides guarantees
against this by not letting any context to be activated and still
letting existing contexts be cleaned up.

This behavior though can also be achieved by having a separate flag in
the adapter-struct and checking it before letting a context
activate. However with cxl_adapter_context_force_lock I tried to re-use
the existing infrastructure we have already put in place to prevent
context activation while we are doing card reset.

In retrospect this is a more generic issue that we may wish to address
in cxl where in we want to prevent certain ops like context activation
or reading config space and also let existing consumers of these ops to
complete. It would be also better if other contributers can also pitch
in and provide there feedback as to possibly solve this problem in a
more generic manner.

Thanks,
-- 
Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Linux Technology Center, IBM India Pvt. Ltd.
