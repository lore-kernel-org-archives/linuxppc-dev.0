Return-Path: <srs0=im6g=hm=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Tvpz31CVzF24s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 15:17:31 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40Tvpz24tGz8svR
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Apr 2018 15:17:31 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40Tvpy4SfWz9s19
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 15:17:30 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3N5E7Rt025026
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 01:17:28 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hh3w5h2nm-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2018 01:17:28 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 23 Apr 2018 06:17:26 +0100
Subject: Re: [PATCH v4 3/7] powerpc/fadump: un-register fadump on kexec path.
To: Nicholas Piggin <nicholas.piggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Ananth Narayan
 <ananth@in.ibm.com>, kernelfans@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Hari Bathini <hbathini@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <152420062000.31037.770773018944092449.stgit@jupiter.in.ibm.com>
 <152420067500.31037.2795727017934578072.stgit@jupiter.in.ibm.com>
 <20180422115858.776bac02@roar.ozlabs.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Mon, 23 Apr 2018 10:47:20 +0530
MIME-Version: 1.0
In-Reply-To: <20180422115858.776bac02@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <add68f62-1b82-1c6b-a052-b7c673ab9c78@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/22/2018 07:28 AM, Nicholas Piggin wrote:
> On Fri, 20 Apr 2018 10:34:35 +0530
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
> Is this a bug fix that should go to previous kernels as well?

Yes.

> 
>>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/fadump.c |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
>> index 43bfa535d0ea..16b3e8c5cae0 100644
>> --- a/arch/powerpc/kernel/fadump.c
>> +++ b/arch/powerpc/kernel/fadump.c
>> @@ -1276,6 +1276,9 @@ void fadump_cleanup(void)
>>  	/* Invalidate the registration only if dump is active. */
>>  	if (fw_dump.dump_active) {
>>  		fadump_invalidate_dump(fdm_active);
>> +	} else if (fw_dump.dump_registered) {
>> +		/* Un-register Firmware-assisted dump if it was registered. */
>> +		fadump_unregister_dump(&fdm);
>>  	}
>>  }
>>  
>>
> 
