Return-Path: <mwb@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rC743hCTzDr4N
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 09:49:52 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4MNmXcE068983
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 19:49:50 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2j4qsrw1mh-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 May 2018 19:49:50 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mwb@linux.vnet.ibm.com>;
 Tue, 22 May 2018 17:49:49 -0600
Subject: Re: [RFC v5 3/6] migration/dlpar: Add device readd queuing function
To: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 John Allen <jallen@linux.vnet.ibm.com>
References: <a44f908b-03f9-9042-afaa-2a8bb593db4b@linux.vnet.ibm.com>
 <0445c87f-1ab3-7b03-6956-56d4c1beab80@linux.vnet.ibm.com>
From: Michael Bringmann <mwb@linux.vnet.ibm.com>
Date: Tue, 22 May 2018 18:49:45 -0500
MIME-Version: 1.0
In-Reply-To: <0445c87f-1ab3-7b03-6956-56d4c1beab80@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <4fc25f65-cb64-f52e-8701-51497849bee2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 05/22/2018 03:24 PM, Thomas Falcon wrote:
> On 05/21/2018 12:52 PM, Michael Bringmann wrote:
>> migration/dlpar: This patch adds function dlpar_readd_action()
>> which will queue a worker function to 'readd' a device in the
>> system.  Such devices must be identified by a 'resource' type
>> and a drc_index to be readded.
> 
> The function in the commit message and the patch have different names. The patch seems to queue a generic action instead of a readd.  The commit message needs to be updated to describe this new function.
> 
> Tom

Fixed.

Michael
> 
>>
>> Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/dlpar.c   |   14 ++++++++++++++
>>  arch/powerpc/platforms/pseries/pseries.h |    1 +
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
>> index a0b20c0..a14684e 100644
>> --- a/arch/powerpc/platforms/pseries/dlpar.c
>> +++ b/arch/powerpc/platforms/pseries/dlpar.c
>> @@ -407,6 +407,20 @@ void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
>>  	}
>>  }
>>
>> +int dlpar_queue_action(int resource, int action, u32 drc_index)
>> +{
>> +	struct pseries_hp_errorlog hp_elog;
>> +
>> +	hp_elog.resource = resource;
>> +	hp_elog.action = action;
>> +	hp_elog.id_type = PSERIES_HP_ELOG_ID_DRC_INDEX;
>> +	hp_elog._drc_u.drc_index = drc_index;
>> +
>> +	queue_hotplug_event(&hp_elog, NULL, NULL);
>> +
>> +	return 0;
>> +}
>> +
>>  static int dlpar_parse_resource(char **cmd, struct pseries_hp_errorlog *hp_elog)
>>  {
>>  	char *arg;
>> diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
>> index 60db2ee..cb2beb1 100644
>> --- a/arch/powerpc/platforms/pseries/pseries.h
>> +++ b/arch/powerpc/platforms/pseries/pseries.h
>> @@ -61,6 +61,7 @@ extern struct device_node *dlpar_configure_connector(__be32,
>>
>>  void queue_hotplug_event(struct pseries_hp_errorlog *hp_errlog,
>>  			 struct completion *hotplug_done, int *rc);
>> +extern int dlpar_queue_action(int resource, int action, u32 drc_index);
>>  #ifdef CONFIG_MEMORY_HOTPLUG
>>  int dlpar_memory(struct pseries_hp_errorlog *hp_elog);
>>  #else
> 
> 
> 

-- 
Michael W. Bringmann
Linux Technology Center
IBM Corporation
Tie-Line  363-5196
External: (512) 286-5196
Cell:       (512) 466-0650
mwb@linux.vnet.ibm.com
