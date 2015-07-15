Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7D101A0250
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 20:18:28 +1000 (AEST)
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1D5EB1402BA
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2015 20:18:27 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Wed, 15 Jul 2015 15:48:25 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 899333940073
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2015 15:48:17 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6FAHdf734537476
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2015 15:48:15 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6FAFi8k022598
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jul 2015 15:45:44 +0530
Message-ID: <55A632CD.7060500@linux.vnet.ibm.com>
Date: Wed, 15 Jul 2015 15:45:41 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Joel Stanley <joel@jms.id.au>
CC: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v4 3/6] cpufreq: powernv: Register for OCC related
 opal_message notification
References: <1436796602-10228-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1436796602-10228-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1436941021.17171.12.camel@jms.id.au>
In-Reply-To: <1436941021.17171.12.camel@jms.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joel,

On 07/15/2015 11:47 AM, Joel Stanley wrote:
> Hello,
> 
> On Mon, 2015-07-13 at 19:39 +0530, Shilpasri G Bhat wrote:
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index d0c18c9..1f59958 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -414,6 +415,71 @@ static struct notifier_block powernv_cpufreq_reboot_nb = {
>>  	.notifier_call = powernv_cpufreq_reboot_notifier,
>>  };
>>  
>> +static char throttle_reason[][30] = {
>> +					"No throttling",
>> +					"Power Cap",
>> +					"Processor Over Temperature",
>> +					"Power Supply Failure",
>> +					"Over Current",
>> +					"OCC Reset"
>> +				     };
>> +
>> +static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
>> +				   unsigned long msg_type, void *_msg)
>> +{
>> +	struct opal_msg *msg = _msg;
>> +	struct opal_occ_msg omsg;
>> +
>> +	if (msg_type != OPAL_MSG_OCC)
>> +		return 0;
>> +
>> +	memcpy(&omsg, msg->params, sizeof(omsg));
> 
> You need to ensure the of the members of struct opal_occ_msg are in the
> correct byte order when copying them over.
> 
> Have you tested this code with in a little endian configuration?

Ah yes this wont work in LE.
I tested the below diff in both BE/LE configuration on Power8 box which has FSP.

-       memcpy(&omsg, msg->params, sizeof(omsg));
+       omsg.type = be64_to_cpu(msg->params[0]);
+       omsg.chip = be64_to_cpu(msg->params[1]);
+       omsg.throttle_status = be64_to_cpu(msg->params[2]);
> 
> Do the messages you're sending make sense for a system that has a BMC
> instead of a FSP?

For a system with BMC, only OCC_THROTTLE will be received by the host. The
remaining two (OCC_RESET and OCC_LOAD) are sent only in FSP based systems.
OCC_THROTTLE is sent by opal which polls on the throttle_status byte in the
OPAL-OCC shared memory region.

> 
> Cheers,
> 
> Joel
> 

Thanks and Regards,
Shilpa
