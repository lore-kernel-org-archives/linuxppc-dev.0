Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vHnWd2FdqzDqBN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 01:57:49 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vHnWc572yz9s7m
 for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2017 01:57:48 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v17ErxaF068504
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2017 09:57:46 -0500
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28fcnb3n15-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 07 Feb 2017 09:57:46 -0500
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Tue, 7 Feb 2017 20:27:42 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C149E3940060
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Feb 2017 20:27:39 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v17EvdEb14417960
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2017 20:27:39 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v17EvbS5018825
 for <linuxppc-dev@ozlabs.org>; Tue, 7 Feb 2017 20:27:39 +0530
Subject: Re: [PATCH v1 1/2] fadump: reduce memory consumption for capture
 kernel
To: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
References: <148579466976.5257.13873211534670897645.stgit@hbathini.in.ibm.com>
 <3d19b81e-1ea6-cdcf-cb28-ebd2c17d7378@linux.vnet.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 7 Feb 2017 20:27:37 +0530
MIME-Version: 1.0
In-Reply-To: <3d19b81e-1ea6-cdcf-cb28-ebd2c17d7378@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <cffce11c-6037-4c9b-3dd1-8c7102790b6c@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mahesh,


On Tuesday 31 January 2017 01:05 AM, Mahesh Jagannath Salgaonkar wrote:
> On 01/30/2017 10:14 PM, Hari Bathini wrote:
>> In case of fadump, capture (fadump) kernel boots like a normal kernel.
>> While this has its advantages, the capture kernel would initialize all
>> the components like normal kernel, which may not necessarily be needed
>> for a typical dump capture kernel. So, fadump capture kernel ends up
>> needing more memory than a typical (read kdump) capture kernel to boot.
...
>> +#define FADUMP_FORMAT_VERSION	0x00000002
> Why 0x0002 ? Does Phyp now support new version of dump format ? We
> should be more careful not to break backward compatibility.

Dump format version has not changed in Phyp. Undone the change in v2
to keep backward compatibility intact.

>> +static ssize_t fadump_params_show(struct kobject *kobj,
>> +				   struct kobj_attribute *attr,
>> +				   char *buf)
>> +{
>> +	return sprintf(buf, "%s\n",
>> +		get_fadump_params_buf(__va(fw_dump.handover_area_start)));
> May be we should show current cmdline + fadump append params.

I think it is better to display only append parameters as current 
cmdline parameters
may not be accurate always?

Thanks
Hari
