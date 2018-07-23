Return-Path: <jallen@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4yP4mTRzDrG3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:23:41 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6NFLBrS104487
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 11:23:39 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kdggtamt7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2018 11:23:04 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <jallen@linux.ibm.com>;
 Mon, 23 Jul 2018 09:22:27 -0600
Date: Mon, 23 Jul 2018 10:22:23 -0500
From: John Allen <jallen@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, nfont@linux.vnet.ibm.com
Subject: Re: [PATCH v2 2/2] powerpc/pseries: Wait for completion of hotplug
 events during PRRN handling
References: <20180717194048.3057-1-jallen@linux.ibm.com>
 <20180717194048.3057-3-jallen@linux.ibm.com>
 <87k1pmhxx7.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <87k1pmhxx7.fsf@concordia.ellerman.id.au>
Message-Id: <20180723152223.mydr5dovcv26domv@p50>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 23, 2018 at 11:41:24PM +1000, Michael Ellerman wrote:
>John Allen <jallen@linux.ibm.com> writes:
>
>> While handling PRRN events, the time to handle the actual hotplug events
>> dwarfs the time it takes to perform the device tree updates and queue the
>> hotplug events. In the case that PRRN events are being queued continuously,
>> hotplug events have been observed to be queued faster than the kernel can
>> actually handle them. This patch avoids the problem by waiting for a
>> hotplug request to complete before queueing more hotplug events.
>
>So do we need the hotplug work queue at all? Can we just call
>handle_dlpar_errorlog() directly?
>
>Or are we using the work queue to serialise things? And if so would a
>mutex be better?

Right, the workqueue is meant to serialize all hotplug events and it 
gets used for more than just PRRN events. I believe the motivation for 
using the workqueue over a mutex is that KVM guests initiate hotplug 
events through the hotplug interrupt and can queue fairly large requests 
meaning that in this scenario, waiting for a lock would block interrupts
for a while. Using the workqueue allows us to serialize hotplug events 
from different sources in the same way without worrying about the 
context in which the event is generated.

>
>It looks like prrn_update_node() is called via at least, prrn_work_fn()
>and post_mobility_fixup().
>
>The latter is called from migration_store(), which seems like it would
>be harmless. But also from pseries_suspend_enable_irqs() which I'm less
>clear on.

Yeah, that doesn't seem to make sense based on the function name. Odd 
that prrn_update_node is being called from anywhere outside of handling 
PRRN events. Perhaps if other code paths are using the function, it 
needs a more generic name.

-John

>
>cheers
>
>> diff --git a/arch/powerpc/platforms/pseries/mobility.c b/arch/powerpc/platforms/pseries/mobility.c
>> index 8a8033a249c7..49930848fa78 100644
>> --- a/arch/powerpc/platforms/pseries/mobility.c
>> +++ b/arch/powerpc/platforms/pseries/mobility.c
>> @@ -242,6 +242,7 @@ static int add_dt_node(__be32 parent_phandle, __be32 drc_index)
>>  static void prrn_update_node(__be32 phandle)
>>  {
>>  	struct pseries_hp_errorlog *hp_elog;
>> +	struct completion hotplug_done;
>>  	struct device_node *dn;
>>
>>  	/*
>> @@ -263,7 +264,9 @@ static void prrn_update_node(__be32 phandle)
>>  	hp_elog->id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
>>  	hp_elog->_drc_u.drc_index = phandle;
>>
>> -	queue_hotplug_event(hp_elog, NULL, NULL);
>> +	init_completion(&hotplug_done);
>> +	queue_hotplug_event(hp_elog, &hotplug_done, NULL);
>> +	wait_for_completion(&hotplug_done);
>>
>>  	kfree(hp_elog);
>>  }
>> --
>> 2.17.1
>
