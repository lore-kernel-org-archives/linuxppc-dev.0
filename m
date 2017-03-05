Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbzWV6QPWzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:23:50 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v25NNb7G126849
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 18:23:47 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28ys1rjfwf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 18:23:47 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 6 Mar 2017 09:23:44 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1C52F2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 10:23:43 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v25NNZFA48038050
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:23:43 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v25NN99e026513
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 10:23:09 +1100
Date: Mon, 6 Mar 2017 10:22:46 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/eeh: Avoid use after free in
 eeh_handle_special_event()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20170303044718.19253-1-ruscur@russell.cc>
 <2ac7b7d0-c04f-1c33-4661-d2e4f9a0e054@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2ac7b7d0-c04f-1c33-4661-d2e4f9a0e054@ozlabs.ru>
Message-Id: <20170305232246.GA14744@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 03, 2017 at 04:59:11PM +1100, Alexey Kardashevskiy wrote:
>On 03/03/17 15:47, Russell Currey wrote:
>> eeh_handle_special_event() is called when an EEH event is detected but
>> can't be narrowed down to a specific PE.  This function looks through
>> every PE to find one in an erroneous state, then calls the regular event
>> handler eeh_handle_normal_event() once it knows which PE has an error.
>> 
>> However, if eeh_handle_normal_event() found that the PE cannot possibly
>> be recovered, it will remove the PE and associated devices.  This leads
>> to a use after free in eeh_handle_special_event() as it attempts to clear
>> the "recovering" state on the PE after eeh_handle_normal_event() returns.
>> 
>> Thus, make sure the PE is valid when attempting to clear state in
>> eeh_handle_special_event().
>> 
>> Cc: <stable@vger.kernel.org> #3.10+
>> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Signed-off-by: Russell Currey <ruscur@russell.cc>
>> ---
>>  arch/powerpc/kernel/eeh_driver.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>> 
>> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
>> index b94887165a10..492397298a2a 100644
>> --- a/arch/powerpc/kernel/eeh_driver.c
>> +++ b/arch/powerpc/kernel/eeh_driver.c
>> @@ -983,6 +983,19 @@ static void eeh_handle_special_event(void)
>>  		if (rc == EEH_NEXT_ERR_FROZEN_PE ||
>>  		    rc == EEH_NEXT_ERR_FENCED_PHB) {
>>  			eeh_handle_normal_event(pe);
>> +
>> +			/*
>> +			 * eeh_handle_normal_event() can free the PE if it
>> +			 * determines that the PE cannot possibly be recovered.
>> +			 * Make sure the PE still exists before changing its
>> +			 * state.
>> +			 */
>> +			if (!pe || (pe->type & EEH_PE_INVALID)
>> +			    || (pe->state & EEH_PE_REMOVED)) {
>
>
>The bug is that pe becomes stale after eeh_handle_normal_event() returned
>and dereferencing it afterwards is broken.
>

Correct, it won't cause a kernel crash as @pe is deferencing linear mapped
area whose address is always valid. I think the proper fix would be to use
eeh_handle_normal_event() to indicate the @pe has been released and don't
access it any more.

>
>
>> +				pr_warn("EEH: not clearing state on bad PE\n");

The message like this isn't meaningful, no need to have it. The messages that
have prefix "EEH:" is informative messages. We definitely needn't this here.
However, the message might be not needed in next revision.

>> +				continue;
>> +			}
>> +
>>  			eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
>>  		} else {
>>  			pci_lock_rescan_remove();
>> 

Thanks,
Gavin
