Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tvnjG3qG5zDqCj
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 12:56:49 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v061sR3D026636
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jan 2017 20:56:47 -0500
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27t1hv1151-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jan 2017 20:56:47 -0500
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 6 Jan 2017 11:56:44 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2FA1D2BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Jan 2017 12:56:42 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v061uggH55509190
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jan 2017 12:56:42 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v061uf0i014709
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 6 Jan 2017 12:56:42 +1100
Date: Fri, 6 Jan 2017 12:56:41 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
Subject: Re: [PATCH] powerpc/eeh: Enable IO path on permanent error
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1483659589-23208-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1483659981.12420.0.camel@russell.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1483659981.12420.0.camel@russell.cc>
Message-Id: <20170106015641.GA18358@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 06, 2017 at 10:46:21AM +1100, Russell Currey wrote:
>On Fri, 2017-01-06 at 10:39 +1100, Gavin Shan wrote:
>> We give up recovery on permanent error, simply shutdown the affected
>> devices and remove them. If the devices can't be put into quiet state,
>> they spew more traffic that is likely to cause another unexpected EEH
>> error. This was observed on "p8dtu2u" machine:
>> 
>>    0002:00:00.0 PCI bridge: IBM Device 03dc
>>    0002:01:00.0 Ethernet controller: Intel Corporation \
>>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
>>    0002:01:00.1 Ethernet controller: Intel Corporation \
>>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
>>    0002:01:00.2 Ethernet controller: Intel Corporation \
>>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
>>    0002:01:00.3 Ethernet controller: Intel Corporation \
>>                 Ethernet Controller X710/X557-AT 10GBASE-T (rev 02)
>> 
>> On P8 PowerNV platform, the IO path is frozen when shutdowning the
>> devices, meaning the memory registers are inaccessible. It is why
>> the devices can't be put into quiet state before removing them.
>> This fixes the issue by enabling IO path prior to putting the devices
>> into quiet state.
>> 
>> Link: https://github.com/open-power/supermicro-openpower/issues/419
>
>FYI this link isn't publicly accessible.
>

Yeah, I knew it. The reason I put it here is more details out there
for you or me.

>> Reported-by: Pridhiviraj Paidipeddi <ppaidipe@linux.vnet.ibm.com>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/eeh.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
>> index 8180bfd..9de7f79 100644
>> --- a/arch/powerpc/kernel/eeh.c
>> +++ b/arch/powerpc/kernel/eeh.c
>> @@ -298,9 +298,17 @@ void eeh_slot_error_detail(struct eeh_pe *pe, int
>> severity)
>>  	 *
>>  	 * For pHyp, we have to enable IO for log retrieval. Otherwise,
>>  	 * 0xFF's is always returned from PCI config space.
>> +	 *
>> +	 * When the @severity is EEH_LOG_PERM, the PE is going to be
>> +	 * removed. Prior to that, the drivers for devices included in
>> +	 * the PE will be closed. The drivers rely on working IO path
>> +	 * to bring the devices to quiet state. Otherwise, PCI traffic
>> +	 * from those devices after they are removed is like to cause
>> +	 * another unexpected EEH error.
>>  	 */
>>  	if (!(pe->type & EEH_PE_PHB)) {
>> -		if (eeh_has_flag(EEH_ENABLE_IO_FOR_LOG))
>> +		if (eeh_has_flag(EEH_ENABLE_IO_FOR_LOG) ||
>> +		    severity == EEH_LOG_PERM)
>>  			eeh_pci_enable(pe, EEH_OPT_THAW_MMIO);
>>  
>>  		/*
>
