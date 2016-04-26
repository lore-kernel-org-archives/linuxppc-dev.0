Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvJvz0cmQzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 20:18:39 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 26 Apr 2016 20:18:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 972F2357806D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 20:18:32 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3QAIOtV64618518
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 20:18:32 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3QAHxEr015134
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 20:17:59 +1000
Date: Tue, 26 Apr 2016 20:17:31 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 alistair@popple.id.au, ruscur@russell.cc, mpe@ellerman.id.au
Subject: Re: [PATCH v2 1/3] powerpc/eeh: Ignore error handlers in
 eeh_pe_reset_and_recover()
Message-ID: <20160426101731.GA11928@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1461331687-1069-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160426052959.GJ15176@voom.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160426052959.GJ15176@voom.fritz.box>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 26, 2016 at 03:29:59PM +1000, David Gibson wrote:
>On Fri, Apr 22, 2016 at 11:28:02PM +1000, Gavin Shan wrote:
>> The function eeh_pe_reset_and_recover() is used to recover EEH
>> error when the passthrough device are transferred to guest and
>> backwards, meaning the device's driver is vfio-pci or none.
>> When the driver is vfio-pci that provides error_detected() error
>> handler only, the handler simply stops the guest and it's not
>> expected behaviour. On the other hand, no error handlers will
>> be called if we don't have a bound driver.
>> 
>> This ignores all error handlers provided by device driver in
>> eeh_pe_reset_and_recover() to avoid the exceptional behaviour.
>> 
>> Fixes: 5cfb20b9 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
>> Cc: stable@vger.kernel.org #v3.18+
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> Reviewed-by: Russell Currey <ruscur@russell.cc>
>> ---
>>  arch/powerpc/kernel/eeh_driver.c | 11 +----------
>>  1 file changed, 1 insertion(+), 10 deletions(-)
>> 
>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>> index fb6207d..1c7d703 100644
>> --- a/arch/powerpc/kernel/eeh_driver.c
>> +++ b/arch/powerpc/kernel/eeh_driver.c
>> @@ -552,7 +552,7 @@ static int eeh_clear_pe_frozen_state(struct eeh_pe *pe,
>>  
>>  int eeh_pe_reset_and_recover(struct eeh_pe *pe)
>>  {
>> -	int result, ret;
>> +	int ret;
>>  
>>  	/* Bail if the PE is being recovered */
>>  	if (pe->state & EEH_PE_RECOVERING)
>> @@ -564,9 +564,6 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
>>  	/* Save states */
>>  	eeh_pe_dev_traverse(pe, eeh_dev_save_state, NULL);
>>  
>> -	/* Report error */
>> -	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
>
>Ok, so after chatting to Gavin, I've made sense of this.  The basic
>thing here is that eeh_pe_reset_and_recover() should be discarding any
>errors from before the reset, not reporting them - the whole point is
>that we know things have gone bad, and we want to clear back to a good
>state.
>
>>  	/* Issue reset */
>>  	ret = eeh_reset_pe(pe);
>>  	if (ret) {
>> @@ -581,15 +578,9 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
>>  		return ret;
>>  	}
>>  
>> -	/* Notify completion of reset */
>> -	eeh_pe_dev_traverse(pe, eeh_report_reset, &result);
>
>However, it's not clear if removing the report of a reset makes sense.
>There are no current users of reset notification IIUC, but if we're
>going to remove the reset reporting, we should put that in a separate
>patch with its own justification, and remove the other caller as well.
>

Thanks, David. It makes sense to me. I will split it into two: one removes
eeh_report_error notification and another removes the left notification
handlers.

>>  	/* Restore device state */
>>  	eeh_pe_dev_traverse(pe, eeh_dev_restore_state, NULL);
>>  
>> -	/* Resume */
>> -	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);
>
>And I'm not sure if it makes sense to remove the resume notification either.
>

Based on the offline talk, we either keep all notification handlers or remove
all of them. As we can't keep eeh_report_error, we have to remove all of them.

>>  	/* Clear recovery mode */
>>  	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
>>  
>
>-- 
>David Gibson			| I'll have my music baroque, and my code
>david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
>				| _way_ _around_!
>http://www.ozlabs.org/~dgibson
