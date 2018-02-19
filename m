Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zlKQZ4Kg2zDrF9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 21:16:05 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1JAF3pp105416
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 05:16:02 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2g7ruq0axh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Feb 2018 05:16:01 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 19 Feb 2018 10:15:59 -0000
Subject: Re: [PATCH V3] cxl: Fix timebase synchronization status on P9
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
References: <1518794852-30137-1-git-send-email-clombard@linux.vnet.ibm.com>
 <87woz9h5lp.fsf@vajain21.in.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 11:15:55 +0100
MIME-Version: 1.0
In-Reply-To: <87woz9h5lp.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <966ae15f-3771-65e8-387a-8d49170b56a2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 19/02/2018 à 07:10, Vaibhav Jain a écrit :
> 
> Hi Christophe,
> 
> Mostly ok with this patch. Some very minor review comments:
> 
> Christophe Lombard <clombard@linux.vnet.ibm.com> writes:
>> --- a/drivers/misc/cxl/sysfs.c
>> +++ b/drivers/misc/cxl/sysfs.c
>> @@ -62,6 +62,16 @@ static ssize_t psl_timebase_synced_show(struct device *device,
>>   					char *buf)
>>   {
>>   	struct cxl *adapter = to_cxl_adapter(device);
>> +	u64 psl_tb;
>> +	int delta;
>> +
>> +	psl_tb = adapter->native->sl_ops->timebase_read(adapter);
>> +	delta = mftb() - psl_tb;
>> +	if (delta < 0)
>> +		delta = -delta;
> Can just use abs().

okay, I can.

>> +
>> +	/* CORE TB and PSL TB difference <= 16usecs ? */
>> +	adapter->psl_timebase_synced = (tb_to_ns(delta) < 16000) ? true : false;
> Can be re-written as
> 'adapter->psl_timebase_synced = (tb_to_ns(abs(delta)) < 16000);'

I prefer to keep the original version for easier reading.

> 
>>
>>   	return scnprintf(buf, PAGE_SIZE, "%i\n",
>>   	adapter->psl_timebase_synced);
> Might be a good idea to debug print/print_once the delta.

sounds good.

> 
