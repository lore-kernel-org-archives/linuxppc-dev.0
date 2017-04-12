Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2xw95smxzDq7h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 18:31:21 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3C8NiO5115518
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 04:31:15 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29sb7c45yq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 04:31:15 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Wed, 12 Apr 2017 09:31:12 +0100
Subject: Re: [PATCH V4 7/7] cxl: Add psl9 specific code
To: Michael Ellerman <mpe@ellerman.id.au>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 andrew.donnellan@au1.ibm.com
References: <1491574319-11852-1-git-send-email-clombard@linux.vnet.ibm.com>
 <1491574319-11852-8-git-send-email-clombard@linux.vnet.ibm.com>
 <2584b575-bc19-d7d8-3017-7c462a5fa800@linux.vnet.ibm.com>
 <87bms2v0h2.fsf@concordia.ellerman.id.au>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Wed, 12 Apr 2017 10:30:32 +0200
MIME-Version: 1.0
In-Reply-To: <87bms2v0h2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <55ea010d-fc0b-9f8b-35f5-37cdc5d4792f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 12/04/2017 à 04:11, Michael Ellerman a écrit :
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>
>> Le 07/04/2017 à 16:11, Christophe Lombard a écrit :
>>> The new Coherent Accelerator Interface Architecture, level 2, for the
>>> IBM POWER9 brings new content and features:
>>> - POWER9 Service Layer
>>> - Registers
>>> - Radix mode
>>> - Process element entry
>>> - Dedicated-Shared Process Programming Model
>>> - Translation Fault Handling
>>> - CAPP
>>> - Memory Context ID
>>>      If a valid mm_struct is found the memory context id is used for each
>>>      transaction associated with the process handle. The PSL uses the
>>>      context ID to find the corresponding process element.
>>>
>>> Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
>>> ---
>>
>> I'm ok with the code. However checkpatch is complaining about a
>> tab/space error in native.c
> I already fixed it up when I applied them (and a bunch of other things).
>
>> If you have a quick respin, I also have a comment below about the
>> documentation.
> So please send me an incremental patch to update the doco and I'll
> squash it before merging the series.
>
> cheers
>
Hi,

Here is a new patch which updates the documentation based
on the complet PATCH V4 7/7.
Let me know if it suits you.
Thanks


Index: capi2_linux_prepare_patch_V4/Documentation/powerpc/cxl.txt
===================================================================
--- capi2_linux_prepare_patch_V4.orig/Documentation/powerpc/cxl.txt
+++ capi2_linux_prepare_patch_V4/Documentation/powerpc/cxl.txt
@@ -62,6 +62,7 @@ Hardware overview
      POWER8 <-----> PSL Version 8 is compliant to the CAIA Version 1.0.
      POWER9 <-----> PSL Version 9 is compliant to the CAIA Version 2.0.
      This PSL Version 9 provides new features as:
+    * Interaction with the nest MMU which resides within each P9 chip.
      * Native DMA support.
      * Supports sending ASB_Notify messages for host thread wakeup.
      * Supports Atomic operations.
