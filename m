Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A68631A074D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 15:34:16 +1100 (AEDT)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 1 Mar 2016 10:04:13 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u214Y87U19005880
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 10:04:08 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u214Y9WO012903
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 10:04:10 +0530
Message-ID: <56D51BC1.7050904@linux.vnet.ibm.com>
Date: Tue, 01 Mar 2016 10:04:09 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
CC: aneesh.kumar@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/lpar: Don't crash on H_PROTECT errors
References: <1456746752-9298-1-git-send-email-khandual@linux.vnet.ibm.com>
 <56D476DD.9060402@linux.vnet.ibm.com>
In-Reply-To: <56D476DD.9060402@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/29/2016 10:20 PM, Tyrel Datwyler wrote:
> On 02/29/2016 03:52 AM, Anshuman Khandual wrote:
>> There are certain condition in which H_PROTECT can return error code
>> other than H_NOT_FOUND and H_SUCCESS. One such being an attempt to
>> update an hpte owned by adjunct partition. Return 0 in that case so
>> that user space will retry the access. In adjunct case this mean we
>> will not make much progress in the user space. But atleast we get a
>> chance to kill the task and avoid taking down the entire box.
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/platforms/pseries/lpar.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
>> index 477290a..31bcdaf 100644
>> --- a/arch/powerpc/platforms/pseries/lpar.c
>> +++ b/arch/powerpc/platforms/pseries/lpar.c
>> @@ -310,7 +310,7 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
>>  
>>  	pr_devel("ok\n");
>>  
>> -	BUG_ON(lpar_rc != H_SUCCESS);
>> +	WARN_RATELIMIT(lpar_rc != H_SUCCESS, "H_PROTECT returned %lu\n", lpar_rc);
> 
> In the event that we don't get H_NOT_FOUND (which is handled earlier in
> the function) or H_SUCCESS this patch assumes H_RESOURCE. It fails to
> handle H_PARAMETER which is also a valid return from the H_PROTECT
> hypercall.

Right, I guess its okay to BUG_ON() if we detect H_PARAMETER return code
as the kernel should not have created wrong arguments to the hcall in
the first place. Although we will still want to return 0 from here for
H_RESOURCE return code with a WARN_RATELIMIT message. Will change the
code accordingly next time around.
