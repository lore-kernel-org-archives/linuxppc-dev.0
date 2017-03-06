Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vc5BX07MHzDqFh
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 14:39:31 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v263d5hi055555
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 22:39:20 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 290u3h9erq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 22:39:20 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 6 Mar 2017 13:39:17 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9CC9D2BB005D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 14:39:14 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v263caZJ35782746
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 14:39:13 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v263cCr4024191
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 14:38:12 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
 linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: Re: [PATCH V3 08/10] powerpc/mm/hash: Increase VA range to 128TB
In-Reply-To: <8760jndt6v.fsf@skywalker.in.ibm.com>
References: <1487498837-12017-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487498837-12017-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170303170013.3f5bfd12@kitsune.suse.cz>
 <8760jndt6v.fsf@skywalker.in.ibm.com>
Date: Mon, 06 Mar 2017 09:07:48 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Message-Id: <87y3wjcbxv.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Michal Such=C3=A1nek <msuchanek@suse.de> writes:
>
>> Hello,
>>
>> On Sun, 19 Feb 2017 15:37:15 +0530
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>>
>>> We update the hash linux page table layout such that we can support
>>> 512TB. But we limit the TASK_SIZE to 128TB. We can switch to 128TB by
>>> default without conditional because that is the max virtual address
>>> supported by other architectures. We will later add a mechanism to
>>> on-demand increase the application's effective address range to 512TB.
>>>=20
>>> Having the page table layout changed to accommodate 512TB  makes
>>> testing large memory configuration easier with less code changes to
>>> kernel
>>>=20
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> ....
>
>> index b64daf124fee..c7ca70dc3ba5 100644
>>> --- a/arch/powerpc/kernel/paca.c
>>> +++ b/arch/powerpc/kernel/paca.c
>>> @@ -253,8 +253,15 @@ void copy_mm_to_paca(struct mm_struct *mm)
>>>  	get_paca()->mm_ctx_id =3D context->id;
>>>  #ifdef CONFIG_PPC_MM_SLICES
>>>  	get_paca()->mm_ctx_low_slices_psize =3D
>>> context->low_slices_psize;
>>> +	/*
>>> +	 * We support upto 128TB for now. Hence copy only 128/2
>>> bytes.
>>> +	 * Later when we support tasks with different max effective
>>> +	 * address, we can optimize this based on mm->task_size.
>>> +	 */
>>> +	BUILD_BUG_ON(TASK_SIZE_USER64 !=3D TASK_SIZE_128TB);
>>
>> Can this be handled by KConfig?
>> Above I see=20
>
> I am reworking the series so that we depend on mm->task_size. Will send
> a new version soon.
>
>
>
>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>> +#define TASK_SIZE_USER64 TASK_SIZE_128TB
>>> +#else
>>> +#define TASK_SIZE_USER64 TASK_SIZE_64TB
>>> +#endif
>> and=20
>>> #ifdef CONFIG_PPC_MM_SLICES
>>> ILD_BUG_ON(TASK_SIZE_USER64 !=3D TASK_SIZE_128TB)
>>
>> which boils down to
>> #ifndef CONFIG_PPC_BOOK3S_64
>> #ifdef CONFIG_PPC_MM_SLICES
>> #error TASK_SIZE_USER64 !=3D TASK_SIZE_128TB
>>
>>
>>>  	memcpy(&get_paca()->mm_ctx_high_slices_psize,
>>> -	       &context->high_slices_psize, SLICE_ARRAY_SIZE);
>>> +	       &context->high_slices_psize, TASK_SIZE_128TB >> 41);
>>
>> Can we avoid magic numbers, please?
>>
>
> Since array is 4 bytes per each TB which is documented else where.

4 bits per teach TB.


-aneesh
