Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6013E1A06C2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 16:27:18 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Mar 2016 00:27:14 -0500
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id C3C25C90041
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Mar 2016 00:27:09 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u215RC8p33161402
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 05:27:12 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u215RC4r003461
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 00:27:12 -0500
Received: from kernel.stglabs.ibm.com (kernel.stglabs.ibm.com [9.114.214.19])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u215RCWl003436
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Mar 2016 00:27:12 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/lpar: Don't crash on H_PROTECT errors
In-Reply-To: <56D476DD.9060402@linux.vnet.ibm.com>
References: <1456746752-9298-1-git-send-email-khandual@linux.vnet.ibm.com>
 <56D476DD.9060402@linux.vnet.ibm.com>
Date: Tue, 01 Mar 2016 10:57:09 +0530
Message-ID: <871t7urcnm.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:

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

One of the possible thing we could do is sent SIGBUS to the application
rather than taking down the system ?

-aneesh
