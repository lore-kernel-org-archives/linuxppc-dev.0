Return-Path: <srs0=xhv0=i2=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412Bxn1svSzF1gC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 16:16:29 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 412Bxm4sP2z8vBK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 16:16:28 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 412Bxl6MhYz9s3x
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2018 16:16:26 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w586EQZd057875
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Jun 2018 02:16:24 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jfmac0583-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 08 Jun 2018 02:16:24 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Fri, 8 Jun 2018 07:16:21 +0100
Subject: Re: [v3 PATCH 1/5] powerpc/pseries: convert rtas_log_buf to linear
 allocation.
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, stable@vger.kernel.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
References: <152839244928.25118.15100234720683911223.stgit@jupiter.in.ibm.com>
 <152839248387.25118.579137029955034015.stgit@jupiter.in.ibm.com>
 <20180608113137.7d409c6c@roar.ozlabs.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Fri, 8 Jun 2018 11:46:15 +0530
MIME-Version: 1.0
In-Reply-To: <20180608113137.7d409c6c@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <81380cda-66d1-0d16-ab38-09f86ef767cf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/08/2018 07:01 AM, Nicholas Piggin wrote:
> On Thu, 07 Jun 2018 22:58:11 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> rtas_log_buf is a buffer to hold RTAS event data that are communicated
>> to kernel by hypervisor. This buffer is then used to pass RTAS event
>> data to user through proc fs. This buffer is allocated from vmalloc
>> (non-linear mapping) area.
>>
>> On Machine check interrupt, register r3 points to RTAS extended event
>> log passed by hypervisor that contains the MCE event. The pseries
>> machine check handler then logs this error into rtas_log_buf. The
>> rtas_log_buf is a vmalloc-ed (non-linear) buffer we end up taking up a
>> page fault (vector 0x300) while accessing it. Since machine check
>> interrupt handler runs in NMI context we can not afford to take any
>> page fault. Page faults are not honored in NMI context and causes
>> kernel panic. This patch fixes this issue by allocating rtas_log_buf
>> using kmalloc.
>>
>> Fixes: b96672dd840f ("powerpc: Machine check interrupt is a non-maskable interrupt")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/rtasd.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/rtasd.c b/arch/powerpc/kernel/rtasd.c
>> index f915db93cd42..3957d4ae2ba2 100644
>> --- a/arch/powerpc/kernel/rtasd.c
>> +++ b/arch/powerpc/kernel/rtasd.c
>> @@ -559,7 +559,7 @@ static int __init rtas_event_scan_init(void)
>>  	rtas_error_log_max = rtas_get_error_log_max();
>>  	rtas_error_log_buffer_max = rtas_error_log_max + sizeof(int);
>>  
>> -	rtas_log_buf = vmalloc(rtas_error_log_buffer_max*LOG_NUMBER);
>> +	rtas_log_buf = kmalloc(rtas_error_log_buffer_max*LOG_NUMBER, GFP_KERNEL);
> 
> Does this have to be in the RMA region if it's to be accessed with
> relocation off in the guest?

Nope not required. It never gets accessed with relocation off.

> 
> A comment about it being accessed with relocation off might be helpful
> too.

Sure.

Thanks,
-Mahesh.
