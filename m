Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 569711A0E83
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 17:07:36 +1000 (AEST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1795A140285
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:07:36 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 12 Jun 2015 17:07:34 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 64D382BB0040
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:07:32 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5C769Vd60817468
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:06:17 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5C75iQr026366
 for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2015 17:05:44 +1000
Message-ID: <557A84B6.2010104@linux.vnet.ibm.com>
Date: Fri, 12 Jun 2015 12:35:26 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Daniel Axtens <dja@axtens.net>
CC: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
Subject: Re: [PATCH V8 03/10] powerpc, perf: Re organize BHRB processing
References: <1433763511-5270-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1433763511-5270-3-git-send-email-khandual@linux.vnet.ibm.com>
 <1433910976.3096.26.camel@axtens.net> <557828ED.9090803@linux.vnet.ibm.com>
 <1433993542.31423.37.camel@axtens.net>
In-Reply-To: <1433993542.31423.37.camel@axtens.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/11/2015 09:02 AM, Daniel Axtens wrote:
>>>> +
>>>>  /* Processing BHRB entries */
>>>>  static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
>>>>  {
>>>> -	u64 val;
>>>> -	u64 addr;
>>>> +	u64 val, addr, tmp;
>>> Please don't use 'tmp' here. As far as I can tell, you use this variable
>>> to compute the 'to' address. The name should reflect that.
>>
>> Agreed but then it will be a new preparatory patch at the beginning
>> of this patch series.
>>
> I don't think I understand what you're saying here. Why do you need a
> new patch? As I understand it, you've introduced 'tmp' in this patch;
> couldn't you just rename it to, for example, to_addr, instead of tmp in
> this patch?

Sorry for the confusion, I meant separate patch for the other
two changes I had agreed to (i.e changing the name and type of
'pred' variable) as suggested in the previous mail not for this
one. Will change 'tmp' into 'to_addr' in this patch itself.
