Return-Path: <srs0=u5mw=4j=linux.vnet.ibm.com=khandual@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wHwNJ6FRJzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 21:07:12 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wHwNJ5HS5z8sxm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 May 2017 21:07:12 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wHwNJ0sfWz9rvt
 for <linuxppc-dev@ozlabs.org>; Wed,  3 May 2017 21:07:11 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v43B3nhw069587
 for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2017 07:07:05 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a7duq8hjt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 03 May 2017 07:07:05 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 3 May 2017 21:07:02 +1000
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v43B6p0c66257066
 for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2017 21:06:59 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v43B6QgQ014316
 for <linuxppc-dev@ozlabs.org>; Wed, 3 May 2017 21:06:27 +1000
Subject: Re: [PATCH] powerpc/mm: Fix mapped range information print during boot
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <20170428142445.17615-1-khandual@linux.vnet.ibm.com>
 <87o9vauvyk.fsf@concordia.ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Wed, 3 May 2017 16:36:08 +0530
MIME-Version: 1.0
In-Reply-To: <87o9vauvyk.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
Message-Id: <e896f10a-5196-1a59-4bae-c3236758797e@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2017 03:02 PM, Michael Ellerman wrote:
> Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:
> 
>> This is a trivial fix patch regarding mapped ranges in radix MMU
>> environment during boot. No functional change.
>>
>> Before the patch:
>>
>> $dmesg | grep Mapped
>> [    0.000000] Mapped range 0x0 - 0x2000000000 with 0x40000000
>> [    0.000000] Mapped range 0x200000000000 - 0x202000000000 with 0x40000000
>>
>> After the patch:
>>
>> $dmesg | grep Mapped
>> [    0.000000] Mapped range 0x0000000000000000 - 0x0000002000000000 with 1024 MB
>> [    0.000000] Mapped range 0x0000200000000000 - 0x0000202000000000 with 1024 MB
> 
> It's a bit better, how about this instead?

Yeah this is better, I had tried to fix it in place.
