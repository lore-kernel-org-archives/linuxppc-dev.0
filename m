Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v6mCT2SRLzDqLm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:27:33 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0NMNm0v101872
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 17:27:29 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 285kj4akrk-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2017 17:27:29 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 24 Jan 2017 08:27:26 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AA8CE2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:27:24 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v0NMRGKG20578474
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:27:24 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v0NMQqw1027615
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 09:26:52 +1100
Date: Tue, 24 Jan 2017 09:26:27 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc/kernel: Remove nested if statements in
 rtas_initialize()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1485127546-18859-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1485127546-18859-2-git-send-email-gwshan@linux.vnet.ibm.com>
 <8760l6b0u3.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8760l6b0u3.fsf@concordia.ellerman.id.au>
Message-Id: <20170123222627.GA4316@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 23, 2017 at 08:08:20PM +1100, Michael Ellerman wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> This removes the unnecessary nested if statements in function
>> rtas_initialize(), to simplify the code. No functional changes
>> introduced.
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/kernel/rtas.c | 33 ++++++++++++++++-----------------
>>  1 file changed, 16 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
>> index 112cc3b..9ba0f67 100644
>> --- a/arch/powerpc/kernel/rtas.c
>> +++ b/arch/powerpc/kernel/rtas.c
>> @@ -1145,31 +1145,30 @@ asmlinkage int ppc_rtas(struct rtas_args __user *uargs)
>>  void __init rtas_initialize(void)
>>  {
>>  	unsigned long rtas_region = RTAS_INSTANTIATE_MAX;
>> +	const __be32 *basep, *entryp, *sizep;
>>  
>>  	/* Get RTAS dev node and fill up our "rtas" structure with infos
>>  	 * about it.
>>  	 */
>>  	rtas.dev = of_find_node_by_name(NULL, "rtas");
>> -	if (rtas.dev) {
>> -		const __be32 *basep, *entryp, *sizep;
>> -
>> -		basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
>> -		sizep = of_get_property(rtas.dev, "rtas-size", NULL);
>> -		if (basep != NULL && sizep != NULL) {
>			...
>> -		} else
>
>Previously we set rtas.dev to NULL if either basep or sizep was NULL.
>
>> -			rtas.dev = NULL;
>> -	}
>>  	if (!rtas.dev)
>>  		return;
>>  
>> +	basep = of_get_property(rtas.dev, "linux,rtas-base", NULL);
>> +	sizep = of_get_property(rtas.dev, "rtas-size", NULL);
>> +	if (basep == NULL && sizep == NULL) {
>
>But now you set it to NULL only if BOTH basep and sizep are NULL.
>
>Was that intentional? If so you need to mention it in the change log.
>
>> +		rtas.dev = NULL;
>> +		return;
>> +	}
>
>The proper negation of:
>
>	if (basep != NULL && sizep != NULL) {
>is:
>	if (basep == NULL || sizep == NULL) {
>

Thanks, Michael. It's not intentional. I'll update in v2.

Thanks,
Gavin
