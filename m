Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3stGPP5MrJzDskb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 10:22:33 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u9ANJZoh143490
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 19:22:31 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 260ggf92a1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Oct 2016 19:22:31 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 11 Oct 2016 09:22:28 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 867112BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 10:22:27 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u9ANMRKZ10879150
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 10:22:27 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u9ANMRfl027262
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Oct 2016 10:22:27 +1100
Subject: Re: [PATCH] cxl: Prevent adapter reset if an active context exists
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1476108550-31686-1-git-send-email-vaibhav@linux.vnet.ibm.com>
 <d250fc2f-2c56-1bbd-72fa-fc65ab8754d2@linux.vnet.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 11 Oct 2016 10:22:26 +1100
MIME-Version: 1.0
In-Reply-To: <d250fc2f-2c56-1bbd-72fa-fc65ab8754d2@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <11932f92-64f4-2619-03d8-04ce00d5c278@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/10/16 02:09, Frederic Barrat wrote:
>> diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
>> index 01d372a..ed89c57 100644
>> --- a/drivers/misc/cxl/cxl.h
>> +++ b/drivers/misc/cxl/cxl.h
>> @@ -618,6 +618,14 @@ struct cxl {
>>      bool perst_select_user;
>>      bool perst_same_image;
>>      bool psl_timebase_synced;
>> +
>> +    /*
>> +     * number of contexts mapped on to this card.
>> +     * +ve: Number of contexts mapped and new one can be mapped.
>> +     *  0 : No active contexts and new ones can be mapped.
>> +     * -ve: No contexts mapped and new ones cannot be mapped.
>
>
> what does "ve" stand for ?

"+ve" and "-ve" are common English scientific/engineering abbreviations 
for "positive" and "negative" respectively. I suppose they may be 
unfamiliar to those who didn't get an English science education, so it 
might be clearer to say "positive" and "negative" in full.

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
