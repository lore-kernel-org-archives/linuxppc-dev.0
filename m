Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkrdG5L27zDqgv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 14:37:38 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2H3ToLX032373
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 23:37:28 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 297nkp2d85-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 23:37:28 -0400
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 23:37:28 -0400
Subject: Re: [PATCH V2 11/11] powerpc/mm: Move hash specific pte bits to be
 top bits of RPN
To: Paul Mackerras <paulus@ozlabs.org>
References: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1489660329-22501-12-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20170316223427.GK10100@fergus.ozlabs.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Fri, 17 Mar 2017 09:07:15 +0530
MIME-Version: 1.0
In-Reply-To: <20170316223427.GK10100@fergus.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <673d997b-17c1-d7f3-8dd7-875fd06074d1@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 17 March 2017 04:04 AM, Paul Mackerras wrote:
> On Thu, Mar 16, 2017 at 04:02:09PM +0530, Aneesh Kumar K.V wrote:

.....


/* pte contains a translation */
>> +
>> +/*
>> + * Top and bottom bits of RPN which can be used by hash
>> + * translation mode, because we expect them to be zero
>> + * otherwise.
>> + */
>>  #define _RPAGE_RPN0		0x01000
>>  #define _RPAGE_RPN1		0x02000
>> +#define _RPAGE_RPN45		0x0100000000000000UL
>> +#define _RPAGE_RPN44		0x0080000000000000UL
>> +#define _RPAGE_RPN43		0x0040000000000000UL
>> +#define _RPAGE_RPN42		0x0020000000000000UL
>> +#define _RPAGE_RPN41		0x0010000000000000UL
>> +#define _RPAGE_RPN40		0x0008000000000000UL
>
> If RPN0 is 0x1000, then this is actually RPN39 as far as I can see,
> and the other RPN4* bits are likewise off by one.

0x0100000000000000 >> 12 = 0x100000000000

I guess I got that naming wrong. it is 45 bit count hence the numbering 
should be RPN44. I will fixup in next update.

-aneesh
