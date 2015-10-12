Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2B9D61A0806
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 10:26:12 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EF4F5140D96
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 10:26:11 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 09:26:10 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0B500357804F
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 10:26:08 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9CNPxO356492076
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 10:26:08 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CNPZgZ007019
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 10:25:35 +1100
Date: Tue, 13 Oct 2015 10:25:10 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 2/8] powerpc/eeh: More relexed hotplug criterion
Message-ID: <20151012232510.GA14333@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1444276739-20372-3-git-send-email-gwshan@linux.vnet.ibm.com>
 <87612b4rye.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87612b4rye.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2015 at 09:55:53AM +1100, Daniel Axtens wrote:
>> Currently, we rely on the existence of struct pci_driver::err_handler
>> to judge if the corresponding PCI device should be unplugged during
>> EEH recovery (partially hotplug case). However, it's not elaborate.
>> some device drivers are implementing part of the EEH error handlers
>> to collect diag-data. That means the driver still expects a hotplug
>> to recover from the EEH error.
>
>
>> This makes the hotplug criterion more relaxed: if the device driver
>> doesn't provide all necessary EEH error handlers, it will experience
>> hotplug during EEH recovery.
>
>Interesting.
>
>My understanding of Documentation/PCI/pci-error-recovery.txt is that a
>driver should be able to just supply an error_detected() callback. If
>the driver just wants to collect diag-data and wants to be hotplugged,
>it should return PCI_ERS_RESULT_NONE.
>
>What drivers did you have in mind?
>

Danienl, The issue is tracked by IBM's bugzilla 127612 reported from Nvida
private GPU drivers. I tried to find the source code from upstream kernel,
but failed.

Taking an example, one PE has two different devices A and B. A's driver
privides error_detected()/slot_reset()/resume() and it's returning NEED_RESET.
B's driver just provides error_detected() that returns NONE as you said.
EEH core receives NEED_RESET and B won't be having hotplug during recovery.
The error won't be recovered on B.

Thanks,
Gavin

>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/eeh_driver.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>> index 3a626ed..32178a4 100644
>> --- a/arch/powerpc/kernel/eeh_driver.c
>> +++ b/arch/powerpc/kernel/eeh_driver.c
>> @@ -416,7 +416,10 @@ static void *eeh_rmv_device(void *data, void *userdata)
>>  	driver = eeh_pcid_get(dev);
>>  	if (driver) {
>>  		eeh_pcid_put(dev);
>> -		if (driver->err_handler)
>> +		if (driver->err_handler &&
>> +		    driver->err_handler->error_detected &&
>> +		    driver->err_handler->slot_reset &&
>> +		    driver->err_handler->resume)
>>  			return NULL;
>>  	}
>>  
>> -- 
>> 2.1.0
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
