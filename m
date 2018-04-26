Return-Path: <srs0=trvj=hp=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Wy3V26gczF24d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 23:05:26 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40Wy3T4XKzz8vnS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Apr 2018 23:05:25 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40Wy3S56hrz9s0R
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 23:05:24 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3QD5Js8094987
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 09:05:21 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hkce0gd6d-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2018 09:05:20 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 26 Apr 2018 14:05:16 +0100
Subject: Re: [PATCH v5 1/4] powerpc/fadump: un-register fadump on kexec path.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <152474278043.5697.2553982145593952228.stgit@jupiter.in.ibm.com>
 <152474292369.5697.4957552670306451723.stgit@jupiter.in.ibm.com>
 <20180426225757.2a8552e0@roar.ozlabs.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 26 Apr 2018 18:35:10 +0530
MIME-Version: 1.0
In-Reply-To: <20180426225757.2a8552e0@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <d064a5aa-9568-b83b-3154-c719721de17e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/26/2018 06:28 PM, Nicholas Piggin wrote:
> On Thu, 26 Apr 2018 17:12:03 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> otherwise the fadump registration in new kexec-ed kernel complains that
>> fadump is already registered. This makes new kernel to continue using
>> fadump registered by previous kernel which may lead to invalid vmcore
>> generation. Hence this patch fixes this issue by un-registering fadump
>> in fadump_cleanup() which is called during kexec path so that new kernel
>> can register fadump with new valid values.
> 
> I assume this series is for 4.17, but it might be good to get this one
> into the 4.16 fixes branch? Should it go to stable kernels?

You are right. Should I send it out as separate patch ?

> 
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/fadump.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index 8ceabef40d3d..07e8396d472b 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -1180,6 +1180,9 @@ void fadump_cleanup(void)
>>  		init_fadump_mem_struct(&fdm,
>>  			be64_to_cpu(fdm_active->cpu_state_data.destination_address));
>>  		fadump_invalidate_dump(&fdm);
>> +	} else if (fw_dump.dump_registered) {
>> +		/* Un-register Firmware-assisted dump if it was registered. */
>> +		fadump_unregister_dump(&fdm);
>>  	}
>>  }
>>  
>>
> 
