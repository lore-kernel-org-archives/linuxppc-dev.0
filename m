Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rVZZw0xH1zDqdd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 17:22:15 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5G7Innf078922
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 03:22:14 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23jgpfkhe2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 03:22:13 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Jun 2016 12:52:11 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4ED97394005C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 12:52:09 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5G7M9Su50331782
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 12:52:09 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5G7Lv97010343
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jun 2016 12:52:07 +0530
Subject: Re: [PATCH] tools/perf: fix the word selected in find_*_bit
To: George Spelvin <linux@sciencehorizons.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <20160615124409.6985.qmail@ns.sciencehorizons.net>
Cc: acme@kernel.org, adrian.hunter@intel.com, bp@suse.de, dsahern@gmail.com,
 jolsa@redhat.com, linux@horizon.com, linux@rasmusvillemoes.dk,
 mpe@ellerman.id.au, namhyung@kernel.org, wangnan0@huawei.com,
 yury.norov@gmail.com
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Thu, 16 Jun 2016 12:51:44 +0530
MIME-Version: 1.0
In-Reply-To: <20160615124409.6985.qmail@ns.sciencehorizons.net>
Content-Type: text/plain; charset=windows-1252
Message-Id: <479a4811-9aa2-57fd-a1a5-900bacdd69fc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 15 June 2016 06:14 PM, George Spelvin wrote:
> Madhavan Srinivasan wrote:
>> +#if (__BYTE_ORDER == __BIG_ENDIAN) && (BITS_PER_LONG != 64)
>> +	tmp = addr[(((nbits - 1)/BITS_PER_LONG) - (start / BITS_PER_LONG))]
>> +								^ invert;
>> +#else
>>  	tmp = addr[start / BITS_PER_LONG] ^ invert;
>> +#endif
> Than you for diagnosing this problem, but I don't think the fix
> is correct.
>
> 1) It's not clear that all users of _find_next_bit and for_each_set_bit()
>    want this change.
> 2) Is your code even correct?  I'd think you'd want addr[x ^ 1].  Are you
>    sure you shpuld be reversing the whole array, and not just the halves of
>    each 64-bit word?
> 3) You've now broken the case of 32-bit big-endian kernel.

Yes. But looks like we havent hit this case yet. Will post a fix.

Maddy

>
> I think the proper solution is uglier than this. :-(
>
