Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E01D21A09EC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Dec 2014 05:10:40 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 91A60140081
 for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2014 05:10:31 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 18 Dec 2014 04:07:29 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id D4AA72CF0CED
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 22:10:53 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBHBArDj36241578
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 22:10:53 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBHBArRh020706
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2014 22:10:53 +1100
Message-ID: <549164B5.5000406@linux.vnet.ibm.com>
Date: Wed, 17 Dec 2014 16:40:45 +0530
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 1/3] powerpc/nvram: move generic code for nvram and
 pstore
References: <20141216180442.7778.38272.stgit@localhost.localdomain>
 <20141216180530.7778.23702.stgit@localhost.localdomain>
 <1418774597.17248.1.camel@ellerman.id.au>
In-Reply-To: <1418774597.17248.1.camel@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/17/2014 05:33 AM, Michael Ellerman wrote:
> On Tue, 2014-12-16 at 23:35 +0530, Hari Bathini wrote:
>> With minor checks, we can move most of the code for nvram
>> under pseries to a common place to be re-used by other
>> powerpc platforms like powernv. This patch moves such
>> common code to arch/powerpc/kernel/nvram_64.c file.
> Sharing the code is great.
>
> But, you need to keep in mind that it is very common for us to build kernels
> with both POWERNV=y and PSERIES=y.
>
> So you need to make sure you're only using CONFIG_PPC_PSERIES to protect things
> that are optional on pseries. Not things that we *shouldn't* be doing on
> powernv.
>
> For example the logic in nvram_init_oops_partition() looks like it might do the
> wrong thing for PSERIES=y POWERNV=y.

True. It might do wrong thing when an incorrect value is passed by the 
caller.
But since the caller is platform specific code 
[pseries_nvram_init_log_partitions() or
opal_nvram_init_log_partitions() routine], with appropriate parameter 
passed,
I haven't seen any issues while testing.


>> diff --git a/arch/powerpc/include/asm/rtas.h b/arch/powerpc/include/asm/rtas.h
>> index b390f55..a033fe9 100644
>> --- a/arch/powerpc/include/asm/rtas.h
>> +++ b/arch/powerpc/include/asm/rtas.h
>> @@ -343,6 +343,8 @@ extern int early_init_dt_scan_rtas(unsigned long node,
>>   extern void pSeries_log_error(char *buf, unsigned int err_type, int fatal);
>>   
>>   #ifdef CONFIG_PPC_PSERIES
>> +extern unsigned long last_rtas_event;
>> +extern int clobbering_unread_rtas_event(void);
> You should add an empty version of this for !PSERIES, so you don't have to
> ifdef all the call sites.

Sure. Will update accordingly..

Thanks
Hari

> cheers
>
>
