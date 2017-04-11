Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2NqG3MCCzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 20:40:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>, stable@vger.kernel.org,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>,
 Greg Kurz <gkurz@linux.vnet.ibm.com>
Subject: Re: [PATCH v4] cxl: Force context lock during EEH flow
In-Reply-To: <272babe1-780f-c1da-c358-c70238a8ada7@linux.vnet.ibm.com>
References: <20170405113553.7354-1-vaibhav@linux.vnet.ibm.com>
 <272babe1-780f-c1da-c358-c70238a8ada7@linux.vnet.ibm.com>
Date: Tue, 11 Apr 2017 20:40:09 +1000
Message-ID: <87mvbnut12.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Le 05/04/2017 =C3=A0 13:35, Vaibhav Jain a =C3=A9crit :
>> During an eeh event when the cxl card is fenced and card sysfs attr
>> perst_reloads_same_image is set following warning message is seen in the
>> kernel logs:
>>
>>  [   60.622727] Adapter context unlocked with 0 active contexts
>>  [   60.622762] ------------[ cut here ]------------
>>  [   60.622771] WARNING: CPU: 12 PID: 627 at
>>  ../drivers/misc/cxl/main.c:325 cxl_adapter_context_unlock+0x60/0x80 [cx=
l]
>>
>> Even though this warning is harmless, it clutters the kernel log
>> during an eeh event. This warning is triggered as the EEH callback
>> cxl_pci_error_detected doesn't obtain a context-lock before forcibly
>> detaching all active context and when context-lock is released during
>> call to cxl_configure_adapter from cxl_pci_slot_reset, a warning in
>> cxl_adapter_context_unlock is triggered.
>>
>> To fix this warning, we acquire the adapter context-lock via
>> cxl_adapter_context_lock() in the eeh callback
>> cxl_pci_error_detected() once all the virtual AFU PHBs are notified
>> and their contexts detached. The context-lock is released in
>> cxl_pci_slot_reset() after the adapter is successfully reconfigured
>> and before we call slot_reset callback on slice attached device-drivers.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 70b565bbdb91("cxl: Prevent adapter reset if an active context exi=
sts")
>> Reported-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
>> ---
>
> Pending test result from cxl-flash:
> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>

Still pending ... ?

cheers
