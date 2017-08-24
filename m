Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xdG120q64zDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 17:20:53 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7O7JO6F132115
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 03:20:51 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2chq9b6r7k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Aug 2017 03:20:51 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Thu, 24 Aug 2017 08:20:48 +0100
Subject: Re: [PATCH] cxl: Add support for POWER9 DD2
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 fbarrat@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
References: <1503500286-1684-1-git-send-email-clombard@linux.vnet.ibm.com>
 <87378hv3vb.fsf@vajain21.in.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Thu, 24 Aug 2017 09:20:44 +0200
MIME-Version: 1.0
In-Reply-To: <87378hv3vb.fsf@vajain21.in.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f2bebf50-bb13-3295-0379-524e6b090446@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 24/08/2017 à 09:09, Vaibhav Jain a écrit :
> Hi Christophe,
>
> Christophe Lombard <clombard@linux.vnet.ibm.com> writes:
>> +	/* For debugging with trace arrays */
>> +	/* Configure RX trace 0 segmented mode */
>> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000000ULL);
>> +	/* Configure RX trace 1 segmented mode */
>> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0xAA00000000000001ULL);
>> +	/* Configure CT trace 0 segmented mode */
>> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0xA2B8000000000003ULL);
>> +	/* Configure LA0 trace 0 segmented mode */
>> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x83FFC00000000005ULL);
>> +	/* Configure JM0 trace 0 segmented mode */
>> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000007ULL);
>> +	/* Configure DMA trace 0 segmented mode */
>> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000008ULL);
>> +	/* Configure DMA trace 1 segmented mode */
>> +	cxl_p1_write(adapter, CXL_PSL9_TRACECFG, 0x8200000000000009ULL);
> Please wrap this block that configures the trace arrays in #ifdef
> DEBUG. Or it will be better if we remove it from here as the register is
> already accessible via debugfs.
>
> ---
> Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> Linux Technology Center, IBM India Pvt. Ltd.

okay, I will remove this block

Thanks
