Return-Path: <hbathini@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93C921A048F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jan 2015 04:52:36 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6AFD114027A
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2015 04:52:35 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Sat, 17 Jan 2015 03:52:33 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 400BD357804C
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2015 04:52:32 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0GHqVgB40894486
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2015 04:52:32 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0GHqUDw021316
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2015 04:52:30 +1100
Message-ID: <54B94FD6.4000700@linux.vnet.ibm.com>
Date: Fri, 16 Jan 2015 23:22:22 +0530
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 1/3] powerpc/nvram: move generic code for nvram and
 pstore
References: <20141224115729.25731.20371.stgit@localhost.localdomain>
 <20141224115825.25731.65673.stgit@localhost.localdomain>
 <1421209860.10748.10.camel@ellerman.id.au>
 <54B6AFE8.4000104@linux.vnet.ibm.com>
 <1421274513.11409.1.camel@ellerman.id.au>
In-Reply-To: <1421274513.11409.1.camel@ellerman.id.au>
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

On 01/15/2015 03:58 AM, Michael Ellerman wrote:
> On Wed, 2015-01-14 at 23:35 +0530, Hari Bathini wrote:
>> On 01/14/2015 10:01 AM, Michael Ellerman wrote:
>>
>>> On Wed, 2014-12-24 at 17:28 +0530, Hari Bathini wrote:
>>>> With minor checks, we can move most of the code for nvram
>>>> under pseries to a common place to be re-used by other
>>>> powerpc platforms like powernv. This patch moves such
>>>> common code to arch/powerpc/kernel/nvram_64.c file.
>>> As I said in my reply to the previous version:
>>>
>>>      ... you need to keep in mind that it is very common for us to build kernels
>>>      with both POWERNV=y and PSERIES=y.
>>>      
>>>      So you need to make sure you're only using CONFIG_PPC_PSERIES to protect things
>>>      that are optional on pseries. Not things that we *shouldn't* be doing on
>>>      powernv.
>> we could as well do away with the PPC_PSERIES flag in a couple of
>> places in
>> arch/powerpc/kernel/nvram_64.c, but doing that will unnecessarily add
>> few extra variables for !PPC_PSERIES case.
> Yep. I'm happy for them to be there, I just want you to explain in the
> changelog that you've thought about the PSERIES=y POWERNV=y case and why the
> code makes sense for that configuration.
>
>>> Please explain in your commit message how you have dealt with that.
>> Sure. Will update the changelog
> Thanks.
>   
>>> Also, you broke the build for every config that doesn't have
>>> CONFIG_PPC_PSERIES, all 95 of them. This is pasemi_defconfig for example:
>> My bad! clobbering_unread_rtas_event should have been static inline
>> while defining under !PPC_PSERIES
> Correct.
>
> Please make sure you test build at least some of the other configurations in
> future. I realise it's too time consuming to build all of them, but ideally for
> every config symbol you use in your patch you need to build a kernel config
> where that symbol =y and =n (and =m if it's tristate).

Sure, Michael. I will keep this in mind :)

Thanks
Hari

> cheers
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
