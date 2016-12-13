Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3td8V21mc3zDvjh
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 17:11:22 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBD68nsW114241
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 01:11:19 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27a8a64v1m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 01:11:19 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Tue, 13 Dec 2016 16:11:16 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9952F3578052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 17:11:13 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBD6BDNw7602514
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 17:11:13 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBD6BCN5003918
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 17:11:13 +1100
Subject: Re: [PATCH v2] cxl: prevent read/write to AFU config space while AFU
 not configured
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <20161209061850.23281-1-andrew.donnellan@au1.ibm.com>
 <4f474dcc-8a85-858d-a536-67b25ea9b5a5@linux.vnet.ibm.com>
Cc: ukrishn@linux.vnet.ibm.com, vaibhav@linux.vnet.ibm.com, imunsie@au1.ibm.com
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 13 Dec 2016 17:11:12 +1100
MIME-Version: 1.0
In-Reply-To: <4f474dcc-8a85-858d-a536-67b25ea9b5a5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <bb411ce1-b323-4f7a-9d8d-615645f79381@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It looks like there may still be a recursive locking issue in this 
patch, please don't merge just yet...

On 10/12/16 03:30, Frederic Barrat wrote:
>> +static inline int cxl_pcie_config_info(struct pci_bus *bus, unsigned
>> int devfn,
>> +                       struct cxl_afu *afu, int *_record)
>> +{
>> +    int record;
>>
>> -    afu = (struct cxl_afu *)phb->private_data;
>>      record = cxl_pcie_cfg_record(bus->number, devfn);
>>      if (record > afu->crs_num)
>>          return PCIBIOS_DEVICE_NOT_FOUND;
>>
>> -    *_afu = afu;
>>      *_record = record;
>>      return 0;
>>  }
>
>
> There's no reason to pass the afu parameter to that function, is it?

We use it to check afu->crs_num.

> Pushing it further, do we need cxl_pcie_config_info()? It's now a simple
> wrapper around cxl_pcie_cfg_record()

Hmm...

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
