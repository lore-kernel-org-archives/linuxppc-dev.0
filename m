Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2Pb721yczDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 21:14:43 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3BBERKS009578
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 07:14:30 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29rh6yp5rd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 07:14:29 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 12:14:13 +0100
Subject: Re: [PATCH v4] cxl: Force context lock during EEH flow
To: Michael Ellerman <mpe@ellerman.id.au>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20170405113553.7354-1-vaibhav@linux.vnet.ibm.com>
 <272babe1-780f-c1da-c358-c70238a8ada7@linux.vnet.ibm.com>
 <87mvbnut12.fsf@concordia.ellerman.id.au>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>, stable@vger.kernel.org,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
 Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 11 Apr 2017 13:13:42 +0200
MIME-Version: 1.0
In-Reply-To: <87mvbnut12.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a175a714-fa02-2fbd-e1c7-aa9e1305aac1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 11/04/2017 à 12:40, Michael Ellerman a écrit :
> Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
>
>> Le 05/04/2017 à 13:35, Vaibhav Jain a écrit :
>>> During an eeh event when the cxl card is fenced and card sysfs attr
>>> perst_reloads_same_image is set following warning message is seen in the
>>> kernel logs:
>>>
>>>  [   60.622727] Adapter context unlocked with 0 active contexts
>>>  [   60.622762] ------------[ cut here ]------------
>>>  [   60.622771] WARNING: CPU: 12 PID: 627 at
>>>  ../drivers/misc/cxl/main.c:325 cxl_adapter_context_unlock+0x60/0x80 [cxl]
>>>
>>> Even though this warning is harmless, it clutters the kernel log
>>> during an eeh event. This warning is triggered as the EEH callback
>>> cxl_pci_error_detected doesn't obtain a context-lock before forcibly
>>> detaching all active context and when context-lock is released during
>>> call to cxl_configure_adapter from cxl_pci_slot_reset, a warning in
>>> cxl_adapter_context_unlock is triggered.
>>>
>>> To fix this warning, we acquire the adapter context-lock via
>>> cxl_adapter_context_lock() in the eeh callback
>>> cxl_pci_error_detected() once all the virtual AFU PHBs are notified
>>> and their contexts detached. The context-lock is released in
>>> cxl_pci_slot_reset() after the adapter is successfully reconfigured
>>> and before we call slot_reset callback on slice attached device-drivers.
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: 70b565bbdb91("cxl: Prevent adapter reset if an active context exists")
>>> Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>>> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
>>> ---
>>
>> Pending test result from cxl-flash:
>> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>
> Still pending ... ?

Yes, still waiting. It was mentioned in a call with the cxlflash team 
yesterday.

   Fred



>
> cheers
>
